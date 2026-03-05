import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class GitHubUpdateService {
  static const String PUBSPEC_URL =
      'https://raw.githubusercontent.com/NetherDevMc/NetherLink/main/pubspec.yaml';
  static const String WINDOWS_DOWNLOAD =
      'https://github.com/NetherLinkMC/NetherLinkWebsite/raw/refs/heads/main/downloads/windows/NetherLinkInstaller.exe';

  Future<UpdateInfo?> checkForUpdates() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      final response = await http.get(Uri.parse(PUBSPEC_URL));

      if (response.statusCode == 200) {
        final pubspecContent = response.body;

        final latestVersion = _extractVersion(pubspecContent);

        if (latestVersion == null) {
          return null;
        }

        final isNewer = _isNewerVersion(currentVersion, latestVersion);

        if (isNewer) {
          final downloadUrl = WINDOWS_DOWNLOAD;

          return UpdateInfo(
            version: latestVersion,
            downloadUrl: downloadUrl,
            releaseNotes: _generateReleaseNotes(currentVersion, latestVersion),
            publishedAt: DateTime.now(),
          );
        }
      } else {
        print('❌ Failed to fetch pubspec.yaml: ${response.statusCode}');
      }
    } catch (e, st) {
      print('❌ Update check error: $e');
      print('  Stack trace: $st');
    }
    return null;
  }

  String? _extractVersion(String pubspecContent) {
    try {
      final lines = pubspecContent.split('\n');

      for (final line in lines) {
        final trimmedLine = line.trim();

        if (trimmedLine.startsWith('version:')) {
          final parts = trimmedLine.split(':');

          if (parts.length < 2) continue;

          final versionPart = parts.sublist(1).join(':').trim();

          final version = versionPart.split('+')[0].trim();

          return version;
        }
      }
    } catch (e) {
      print('❌ Error parsing version: $e');
    }
    return null;
  }

  bool _isNewerVersion(String current, String latest) {
    try {
      final currentParts = current.split('.').map((e) {
        final parsed = int.tryParse(e.trim()) ?? 0;
        return parsed;
      }).toList();

      final latestParts = latest.split('.').map((e) {
        final parsed = int.tryParse(e.trim()) ?? 0;
        return parsed;
      }).toList();

      while (currentParts.length < 3) currentParts.add(0);
      while (latestParts.length < 3) latestParts.add(0);

      for (int i = 0; i < 3; i++) {
        if (latestParts[i] > currentParts[i]) {
          return true;
        }
        if (latestParts[i] < currentParts[i]) {
          return false;
        }
      }

      return false;
    } catch (e) {
      print('❌ Version comparison error: $e');
      return false;
    }
  }

  String _generateReleaseNotes(String oldVersion, String newVersion) {
    final oldParts = oldVersion
        .split('.')
        .map((e) => int.tryParse(e.trim()) ?? 0)
        .toList();
    final newParts = newVersion
        .split('.')
        .map((e) => int.tryParse(e.trim()) ?? 0)
        .toList();

    while (oldParts.length < 3) oldParts.add(0);
    while (newParts.length < 3) newParts.add(0);

    if (newParts[0] > oldParts[0]) {
      return '''🎉 **Major Update Available!**

This is a significant update with new features and improvements. 

• New features and functionality
• Performance enhancements
• Bug fixes and stability improvements

Download the latest version to enjoy the new experience!''';
    } else if (newParts[1] > oldParts[1]) {
      return '''✨ **New Features Available!**

This update includes new features and improvements: 

• Enhanced functionality
• Performance optimizations
• Bug fixes

Update now to get the latest features! ''';
    } else {
      return '''🔧 **Update Available**

This update includes:

• Bug fixes
• Performance improvements
• Stability enhancements

Update recommended for best experience. ''';
    }
  }
}

class UpdateInfo {
  final String version;
  final String downloadUrl;
  final String releaseNotes;
  final DateTime publishedAt;

  UpdateInfo({
    required this.version,
    required this.downloadUrl,
    required this.releaseNotes,
    required this.publishedAt,
  });

  @override
  String toString() {
    return 'UpdateInfo(version: $version, url: $downloadUrl)';
  }
}