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

    final theme = Theme.of(context);
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
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF10B981), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(theme),
                    const Divider(height: 1, color: Color(0xFF374151)),
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
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF10B981), width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildHeader(theme),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      color: const Color(0xFF111827),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.terminal,
              color: Color(0xFF10B981),
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Console',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 208, 209, 209),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!_isMinimized) ...[
            _buildDebugToggle(),
            const SizedBox(width: 4),
            _buildClearButton(),
            const SizedBox(width: 4),
          ],
          IconButton(
            tooltip: _isMinimized ? 'Maximize' : 'Minimize',
            icon: Icon(
              _isMinimized ? Icons.expand_less : Icons.expand_more,
              color: const Color(0xFF10B981),
              size: 20,
            ),
            onPressed: _toggleMinimize,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            tooltip: 'Close Console',
            icon: const Icon(Icons.close, color: Color(0xFFF87171), size: 18),
            onPressed: widget.onClose,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  Widget _buildDebugToggle() {
    return StatefulBuilder(
      builder: (context, setState) {
        return IconButton(
          tooltip: 'Toggle Debug',
          icon: Icon(
            widget.logger.debugEnabled
                ? Icons.bug_report
                : Icons.bug_report_outlined,
            color: widget.logger.debugEnabled
                ? const Color(0xFFF87171)
                : const Color(0xFF9CA3AF),
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
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          visualDensity: VisualDensity.compact,
        );
      },
    );
  }

  Widget _buildClearButton() {
    return IconButton(
      tooltip: 'Clear Console',
      icon: const Icon(Icons.clear_all, color: Color(0xFF9CA3AF), size: 16),
      onPressed: () {
        widget.logsNotifier.value = [];
      },
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildLogsList() {
    return ValueListenableBuilder<List<String>>(
      valueListenable: widget.logsNotifier,
      builder: (context, logs, _) {
        if (logs.isEmpty) {
          return Container(
            color: const Color(0xFF0D1117),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.terminal,
                    size: 48,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.3),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No logs yet...',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Logs will appear here when broadcasting',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.4),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          color: const Color(0xFF0D1117),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            controller: widget.scrollController,
            physics: const ClampingScrollPhysics(),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              final textColor = _getLogColor(log);
              final icon = _getLogIcon(log);

              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, size: 14, color: textColor.withOpacity(0.8)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SelectableText(
                        log,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          height: 1.4,
                          color: textColor,
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

  Color _getLogColor(String log) {
    if (log.contains('[ERROR]')) {
      return const Color(0xFFF87171);
    } else if (log.contains('[INFO]')) {
      return const Color(0xFF60A5FA);
    } else if (log.contains('[DEBUG]')) {
      return const Color(0xFFFCD34D);
    } else if (log.contains('[SUCCESS]')) {
      return const Color(0xFF34D399);
    }
    return const Color(0xFFD1D5DB);
  }

  IconData _getLogIcon(String log) {
    if (log.contains('[ERROR]')) {
      return Icons.error_outline;
    } else if (log.contains('[INFO]')) {
      return Icons.info_outline;
    } else if (log.contains('[DEBUG]')) {
      return Icons.bug_report_outlined;
    } else if (log.contains('[SUCCESS]')) {
      return Icons.check_circle_outline;
    }
    return Icons.circle;
  }
}
