enum LogLevel { info, debug, warning, error }

typedef LogCallback = void Function(String message);

class Logger {
  final LogCallback logCallback;
  bool debugEnabled;

  Logger({required this.logCallback, this.debugEnabled = false});

  void info(String message) => _log('INFO', message);
  void debug(String message) {
    if (debugEnabled) _log('DEBUG', message);
  }

  void warning(String message) => _log('WARNING', message);
  void error(String message) => _log('ERROR', message);

  void _log(String level, String message) {
    final now = DateTime.now();
    final formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    logCallback('[$formattedTime] [$level] $message');
  }
}
