import 'dart:math';
import 'package:flutter/material.dart';
import '../../util/featured_servers.dart';
import '../../theme/app_theme.dart';

class FeaturedServersBanner extends StatefulWidget {
  final List<FeaturedServer> servers;
  final Function(FeaturedServer) onServerTap;

  const FeaturedServersBanner({
    super.key,
    required this.servers,
    required this.onServerTap,
  });

  @override
  State<FeaturedServersBanner> createState() => _FeaturedServersBannerState();
}

class _FeaturedServersBannerState extends State<FeaturedServersBanner> {
  late PageController _pageController;
  late List<FeaturedServer> _shuffledServers;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    
    _shuffledServers = List.from(widget.servers)..shuffle(Random());
    
    final randomStart = Random().nextInt(_shuffledServers.length);
    _pageController = PageController(
      initialPage: randomStart,
    );
    _currentPage = randomStart;
    
    Future.delayed(const Duration(seconds: 4), _autoScroll);
  }

  void _autoScroll() {
    if (!mounted || _shuffledServers.isEmpty) return;

    final nextPage = (_currentPage + 1) % _shuffledServers.length;
    
    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 4), _autoScroll);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_shuffledServers.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryAccent.withOpacity(0.08),
            AppTheme.primaryAccent.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryAccent.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.explore,
                  size: 18,
                  color: AppTheme.primaryAccent,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Sponsor Servers',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                  letterSpacing: 0.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.swipe,
                    size: 14,
                    color: AppTheme.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Swipe',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 70,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _shuffledServers.length,
              itemBuilder: (context, index) {
                final server = _shuffledServers[index];
                return _buildServerCard(server);
              },
            ),
          ),
          if (_shuffledServers.length > 1) ...[
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  _shuffledServers.length > 8 ? 8 : _shuffledServers.length,
                  (index) {
                    final displayIndex = _shuffledServers.length > 8
                        ? _currentPage % 8
                        : _currentPage;
                    final isActive = index == displayIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppTheme.primaryAccent
                            : AppTheme.primaryAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildServerCard(FeaturedServer server) {
    return GestureDetector(
      onTap: () => widget.onServerTap(server),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: server.sponsored
                ? AppTheme.primaryAccent.withOpacity(0.4)
                : AppTheme.borderGray.withOpacity(0.6),
            width: server.sponsored ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppTheme.primaryAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.primaryAccent.withOpacity(0.2),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: server.iconUrl != null
                    ? Image.network(
                        server.iconUrl!,
                        width: 46,
                        height: 46,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.dns_rounded,
                          size: 26,
                          color: AppTheme.primaryAccent,
                        ),
                      )
                    : Icon(
                        Icons.dns_rounded,
                        size: 26,
                        color: AppTheme.primaryAccent,
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    server.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    server.description,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.textMuted,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppTheme.primaryAccent.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}