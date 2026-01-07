import 'package:flutter/material.dart';
import '../../util/server_entry.dart';
import '../../constants/app_constants.dart';
import 'server_card.dart';

class FeaturedServers extends StatelessWidget {
  const FeaturedServers({
    super.key,
    required this.servers,
    required this.currentServerPage,
    required this.rotationAnimation,
    required this.scrollController,
    required this.onRefresh,
    required this.onServerTap,
  });

  final List<ServerEntry> servers;
  final int currentServerPage;
  final Animation<double> rotationAnimation;
  final ScrollController scrollController;
  final VoidCallback onRefresh;
  final Function(ServerEntry) onServerTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          if (servers.length > 1) _buildProgressBar(),
          const SizedBox(height: 8),
          const Divider(height: 1, color: Color(0xFF374151)),
          Expanded(child: _buildServerList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'List of Advertised Servers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF10B981),
            ),
          ),
          Row(
            children: [
              if (servers.length > 1) _buildRotationIndicator(),
              const SizedBox(width: 8),
              _buildRefreshButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRotationIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        '5s rotation',
        style: TextStyle(color: Color(0xFFD1D5DB), fontSize: 10),
      ),
    );
  }

  Widget _buildRefreshButton() {
    return IconButton(
      icon: const Icon(Icons.refresh, color: Color(0xFF10B981), size: 20),
      tooltip: 'Refresh servers',
      onPressed: onRefresh,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(2),
      ),
      child: AnimatedBuilder(
        animation: rotationAnimation,
        builder: (context, _) {
          return FractionallySizedBox(
            widthFactor: rotationAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServerList() {
    if (servers.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF10B981)),
      );
    }

    return ListView.builder(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      itemCount: servers.length,
      itemBuilder: (context, index) {
        final server = servers[index];
        return ServerCard(
          server: server,
          isTop: index == 0,
          onTap: () => onServerTap(server),
        );
      },
    );
  }
}
