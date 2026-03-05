import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
    _pageController = PageController(initialPage: randomStart);
    _currentPage = randomStart;
    Future.delayed(const Duration(seconds: 5), _autoScroll);
  }

  void _autoScroll() {
    if (!mounted || _shuffledServers.isEmpty) return;
    final nextPage = (_currentPage + 1) % _shuffledServers.length;
    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
    Future.delayed(const Duration(seconds: 5), _autoScroll);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_shuffledServers.isEmpty) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.primaryAccent.withOpacity(0.2),
                        ),
                      ),
                      child: Icon(
                        Icons.explore_rounded,
                        size: 15,
                        color: AppTheme.primaryAccent,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Featured Servers',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const Spacer(),
                    if (_shuffledServers.length > 1)
                      Text(
                        '${(_currentPage % _shuffledServers.length) + 1} / ${_shuffledServers.length}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 90,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemCount: _shuffledServers.length,
                  itemBuilder: (context, index) =>
                      _buildServerCard(_shuffledServers[index]),
                ),
              ),

              if (_shuffledServers.length > 1)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 14),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _shuffledServers.length > 8
                            ? 8
                            : _shuffledServers.length,
                        (index) {
                          final displayIndex = _shuffledServers.length > 8
                              ? _currentPage % 8
                              : _currentPage;
                          final isActive = index == displayIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: isActive ? 20 : 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppTheme.primaryAccent
                                  : Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServerCard(FeaturedServer server) {
    final hasWebsite = server.websiteUrl != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.09)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryAccent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: server.iconUrl != null
                        ? Image.network(
                            server.iconUrl!,
                            width: 52,
                            height: 52,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.dns_rounded,
                              size: 24,
                              color: AppTheme.primaryAccent,
                            ),
                          )
                        : Icon(
                            Icons.dns_rounded,
                            size: 24,
                            color: AppTheme.primaryAccent,
                          ),
                  ),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        server.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasWebsite)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Tooltip(
                          message: server.websiteUrl!
                              .replaceAll('https://', '')
                              .replaceAll('http://', ''),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => launchUrl(
                                Uri.parse(server.websiteUrl!),
                                mode: LaunchMode.externalApplication,
                              ),
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                child: Icon(
                                  Icons.language_rounded,
                                  size: 17,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => widget.onServerTap(server),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryAccent,
                                AppTheme.primaryAccent.withBlue(255),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryAccent.withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.play_arrow_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Play',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
