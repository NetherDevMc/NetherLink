import 'package:flutter/material.dart';
import '../../util/server_entry.dart';
import '../../constants/app_constants.dart';

class ServerCard extends StatelessWidget {
  const ServerCard({
    super.key,
    required this.server,
    required this.onTap,
    this.isTop = false,
  });

  final ServerEntry server;
  final VoidCallback onTap;
  final bool isTop;

  @override
  Widget build(BuildContext context) {
    final hasValidBackground = _hasValidBackground();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF1F2937),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        side: isTop
            ? const BorderSide(color: Color(0xFF10B981), width: 2)
            : const BorderSide(color: Color(0xFF4B5563), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: const Color(0xFF10B981).withOpacity(0.2),
        hoverColor: const Color(0xFF10B981).withOpacity(0.1),
        child: SizedBox(
          height: AppConstants.cardHeight,
          child: Stack(
            children: [
              _buildBackground(hasValidBackground),
              _buildGradientOverlay(),
              if (isTop) const _TopBadge(),
              _buildServerInfo(),
            ],
          ),
        ),
      ),
    );
  }

  bool _hasValidBackground() {
    return server.background != null &&
        (server.background!.startsWith('http://') ||
            server.background!.startsWith('https://'));
  }

  Widget _buildBackground(bool hasValidBackground) {
    if (hasValidBackground) {
      return Positioned.fill(
        child: Image.network(
          server.background!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const _DefaultBackground(),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const _DefaultBackground();
          },
        ),
      );
    }
    return const _DefaultBackground();
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.4),
            Colors.transparent,
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.9),
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
      ),
    );
  }

  Widget _buildServerInfo() {
    return Positioned(
      bottom: 12,
      left: 12,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${server.address}:${server.port}',
              style: const TextStyle(color: Color(0xFFE5E7EB), fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.content_copy, size: 12, color: Color(0xFF10B981)),
        ],
      ),
    );
  }
}

class _DefaultBackground extends StatelessWidget {
  const _DefaultBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF065F46), Color(0xFF0D9488)],
        ),
      ),
    );
  }
}

class _TopBadge extends StatelessWidget {
  const _TopBadge();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        color: const Color(0xFF10B981),
        child: const Text(
          'TOP',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
