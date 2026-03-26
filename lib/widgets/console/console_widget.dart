import 'dart:ui';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';

class ConsoleWidget extends StatefulWidget {
  final ValueNotifier<List<String>> logsNotifier;
  final ScrollController scrollController;
  final bool debugEnabled;
  final VoidCallback onToggleDebug;
  final VoidCallback onClearLogs;
  final VoidCallback onCopyLogs;

  const ConsoleWidget({
    super.key,
    required this.logsNotifier,
    required this.scrollController,
    required this.debugEnabled,
    required this.onToggleDebug,
    required this.onClearLogs,
    required this.onCopyLogs,
  });

  @override
  State<ConsoleWidget> createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  bool _expanded = false;

  Color _getLogColor(String log) {
    if (log.contains('[ERROR]')) return AppTheme.error;
    if (log.contains('[WARN]')) return AppTheme.warning;
    if (log.contains('[INFO]')) return AppTheme.info;
    if (log.contains('[DEBUG]')) return AppTheme.success;
    return Colors.white.withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: _expanded ? 380 : 52,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(loc),
                  if (_expanded) Expanded(child: _buildLogList(loc)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations loc) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          border: _expanded
              ? Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.07)),
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primaryAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.primaryAccent.withOpacity(0.2),
                ),
              ),
              child: Icon(
                Icons.terminal_rounded,
                color: AppTheme.primaryAccent,
                size: 14,
              ),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Text(
                loc.consoleOutput,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            if (_expanded)
              ValueListenableBuilder<List<String>>(
                valueListenable: widget.logsNotifier,
                builder: (context, logs, _) {
                  if (logs.isEmpty) return const SizedBox.shrink();
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Text(
                      '${logs.length}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.35),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),

            if (_expanded) ...[
              _iconBtn(
                icon: widget.debugEnabled
                    ? Icons.bug_report_rounded
                    : Icons.bug_report_outlined,
                color: widget.debugEnabled
                    ? AppTheme.success
                    : Colors.white.withOpacity(0.3),
                tooltip: loc.toggleDebug,
                onTap: widget.onToggleDebug,
              ),
              _iconBtn(
                icon: Icons.copy_outlined,
                color: Colors.white.withOpacity(0.3),
                tooltip: loc.copyLogs,
                onTap: widget.onCopyLogs,
              ),
              _iconBtn(
                icon: Icons.delete_outline_rounded,
                color: Colors.white.withOpacity(0.3),
                tooltip: loc.clear,
                onTap: widget.onClearLogs,
              ),
            ],

            const SizedBox(width: 4),
            AnimatedRotation(
              turns: _expanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white.withOpacity(0.3),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogList(AppLocalizations loc) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: widget.logsNotifier,
      builder: (context, logs, _) {
        if (logs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.terminal_rounded,
                  size: 32,
                  color: Colors.white.withOpacity(0.08),
                ),
                const SizedBox(height: 10),
                Text(
                  loc.noLogsYet,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.2),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  loc.startBroadcastingToSeeOutput,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.1),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: widget.scrollController,
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 8),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getLogColor(log).withOpacity(0.7),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      log,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: _getLogColor(log),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _iconBtn({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 15, color: color),
        ),
      ),
    );
  }
}

class ConsoleDialog extends StatelessWidget {
  final ValueNotifier<List<String>> logsNotifier;
  final ScrollController scrollController;
  final bool debugEnabled;
  final VoidCallback onToggleDebug;
  final VoidCallback onClearLogs;
  final VoidCallback onCopyLogs;

  const ConsoleDialog({
    super.key,
    required this.logsNotifier,
    required this.scrollController,
    required this.debugEnabled,
    required this.onToggleDebug,
    required this.onClearLogs,
    required this.onCopyLogs,
  });

  Color _getLogColor(String log) {
    if (log.contains('[ERROR]')) return AppTheme.error;
    if (log.contains('[WARN]')) return AppTheme.warning;
    if (log.contains('[INFO]')) return AppTheme.info;
    if (log.contains('[DEBUG]')) return AppTheme.success;
    return Colors.white.withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog.fullscreen(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A0A1A), Color(0xFF0D0A1F), Color(0xFF080D1A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withOpacity(0.07),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryAccent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppTheme.primaryAccent.withOpacity(0.2),
                            ),
                          ),
                          child: Icon(
                            Icons.terminal_rounded,
                            color: AppTheme.primaryAccent,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            loc.consoleOutput,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        _iconBtn(
                          icon: debugEnabled
                              ? Icons.bug_report_rounded
                              : Icons.bug_report_outlined,
                          color: debugEnabled
                              ? AppTheme.success
                              : Colors.white.withOpacity(0.3),
                          tooltip: loc.toggleDebug,
                          onTap: onToggleDebug,
                        ),
                        _iconBtn(
                          icon: Icons.copy_outlined,
                          color: Colors.white.withOpacity(0.3),
                          tooltip: loc.copyLogs,
                          onTap: onCopyLogs,
                        ),
                        _iconBtn(
                          icon: Icons.delete_outline_rounded,
                          color: Colors.white.withOpacity(0.3),
                          tooltip: loc.clear,
                          onTap: onClearLogs,
                        ),
                        _iconBtn(
                          icon: Icons.close_rounded,
                          color: Colors.white.withOpacity(0.5),
                          tooltip: loc.close,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ValueListenableBuilder<List<String>>(
                  valueListenable: logsNotifier,
                  builder: (context, logs, _) {
                    if (logs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.terminal_rounded,
                              size: 40,
                              color: Colors.white.withOpacity(0.08),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              loc.noLogsYet,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.2),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1.5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  right: 8,
                                ),
                                child: Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _getLogColor(log).withOpacity(0.7),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  log,
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 12,
                                    color: _getLogColor(log),
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconBtn({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }
}
