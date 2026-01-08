import 'package:flutter/material.dart';
import '../../util/Logger.dart';
import '../../constants/app_constants.dart';

class FloatingConsole extends StatefulWidget {
  const FloatingConsole({
    super.key,
    required this.logsNotifier,
    required this.scrollController,
    required this.logger,
    required this.isVisible,
    required this.onClose,
  });

  final ValueNotifier<List<String>> logsNotifier;
  final ScrollController scrollController;
  final Logger logger;
  final bool isVisible;
  final VoidCallback onClose;

  @override
  State<FloatingConsole> createState() => _FloatingConsoleState();
}

class _FloatingConsoleState extends State<FloatingConsole>
    with SingleTickerProviderStateMixin {
  bool _isMinimized = false;
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightAnimation = Tween<double>(begin: 400, end: 56).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMinimize() {
    setState(() {
      _isMinimized = !_isMinimized;
      if (_isMinimized) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox.shrink();

    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < AppConstants.mobileBreakpoint;

    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        if (!_isMinimized) {
          return Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: isMobile ? screenSize.height * 0.7 : 500,
                maxWidth: isMobile ? screenSize.width * 0.9 : 800,
                minHeight: 56,
              ),
              height: isMobile ? screenSize.height * 0.7 : 500,
              decoration: BoxDecoration(
                color: const Color(0xFF0A1419),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF00D9FF).withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00D9FF).withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    Divider(
                      height: 1,
                      color: const Color(0xFF152228),
                      thickness: 1,
                    ),
                    Expanded(child: _buildLogsList()),
                  ],
                ),
              ),
            ),
          );
        }

        return Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Container(
            constraints: const BoxConstraints(minHeight: 56, maxHeight: 56),
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF0A1419),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF00D9FF).withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D9FF).withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildHeader(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF0F1419),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color(0xFF00D9FF).withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.terminal,
              color: Color(0xFF00D9FF),
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Console',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 208, 209, 209),
              ),
            ),
          ),
          if (!_isMinimized) ...[
            _buildDebugToggle(),
            const SizedBox(width: 6),
            _buildClearButton(),
            const SizedBox(width: 6),
          ],
          _buildMinimizeButton(),
          const SizedBox(width: 6),
          _buildCloseButton(),
        ],
      ),
    );
  }

  Widget _buildDebugToggle() {
    return StatefulBuilder(
      builder: (context, setState) {
        final isEnabled = widget.logger.debugEnabled;
        return IconButton(
          tooltip: isEnabled ? 'Debug: ON' : 'Debug: OFF',
          icon: Icon(
            isEnabled ? Icons.bug_report : Icons.bug_report_outlined,
            color: isEnabled
                ? const Color(0xFFFCD34D)
                : const Color.fromARGB(255, 208, 209, 209).withOpacity(0.5),
            size: 16,
          ),
          onPressed: () {
            setState(() {
              widget.logger.debugEnabled = !widget.logger.debugEnabled;
            });
            widget.logger.info(
              'Debug mode: ${widget.logger.debugEnabled ? 'ON' : 'OFF'}',
            );
          },
          padding: const EdgeInsets.all(6),
          constraints: const BoxConstraints(),
        );
      },
    );
  }

  Widget _buildClearButton() {
    return IconButton(
      tooltip: 'Clear Console',
      icon: Icon(
        Icons.clear_all,
        color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.5),
        size: 16,
      ),
      onPressed: () {
        widget.logsNotifier.value = [];
      },
      padding: const EdgeInsets.all(6),
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildMinimizeButton() {
    return IconButton(
      tooltip: _isMinimized ? 'Maximize' : 'Minimize',
      icon: Icon(
        _isMinimized ? Icons.expand_less : Icons.expand_more,
        color: const Color(0xFF00D9FF),
        size: 18,
      ),
      onPressed: _toggleMinimize,
      padding: const EdgeInsets.all(6),
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildCloseButton() {
    return IconButton(
      tooltip: 'Close Console',
      icon: const Icon(Icons.close, color: Color(0xFFF87171), size: 16),
      onPressed: widget.onClose,
      padding: const EdgeInsets.all(6),
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildLogsList() {
    return ValueListenableBuilder<List<String>>(
      valueListenable: widget.logsNotifier,
      builder: (context, logs, _) {
        if (logs.isEmpty) {
          return Container(
            color: const Color(0xFF050A0E),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.terminal_outlined,
                    size: 56,
                    color: const Color(0xFF00D9FF).withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Console ready',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 208, 209, 209)
                          .withOpacity(0.6),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Logs will appear here',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 208, 209, 209)
                          .withOpacity(0.4),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          color: const Color(0xFF050A0E),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            controller: widget.scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              final logInfo = _getLogInfo(log);

              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      logInfo.icon,
                      size: 12,
                      color: logInfo.color,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SelectableText(
                        log,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          height: 1.5,
                          color: logInfo.color,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  _LogInfo _getLogInfo(String log) {
    if (log.contains('[ERROR]')) {
      return _LogInfo(
        icon: Icons.error_outline,
        color: const Color(0xFFF87171),
      );
    } else if (log.contains('[INFO]')) {
      return _LogInfo(
        icon: Icons.info_outline,
        color: const Color(0xFF00D9FF),
      );
    } else if (log.contains('[DEBUG]')) {
      return _LogInfo(
        icon: Icons.bug_report_outlined,
        color: const Color(0xFFFCD34D),
      );
    } else if (log.contains('[SUCCESS]')) {
      return _LogInfo(
        icon: Icons.check_circle_outline,
        color: const Color(0xFF34D399),
      );
    }
    return _LogInfo(
      icon: Icons.circle,
      color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.7),
    );
  }
}

class _LogInfo {
  final IconData icon;
  final Color color;

  _LogInfo({
    required this.icon,
    required this.color,
  });
}