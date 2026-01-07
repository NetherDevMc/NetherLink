import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'bedrock_profile.dart';

class ProfileStorage {
  static const String _fileName = 'bedrock_profiles.json';
  static const _uuid = Uuid();

  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  static Future<List<BedrockProfile>> loadProfiles() async {
    try {
      final file = await _getFile();
      if (!await file.exists()) return [];

      final String contents = await file.readAsString();
      final List<dynamic> decoded = jsonDecode(contents);
      return decoded.map((json) => BedrockProfile.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveProfiles(List<BedrockProfile> profiles) async {
    final file = await _getFile();
    final List<Map<String, dynamic>> jsonList = profiles
        .map((p) => p.toJson())
        .toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  static Future<void> addProfile(BedrockProfile profile) async {
    final profiles = await loadProfiles();

    if (profiles.isEmpty || profile.isDefault) {
      for (var i = 0; i < profiles.length; i++) {
        profiles[i] = profiles[i].copyWith(isDefault: false);
      }
    }

    profiles.add(profile);
    await saveProfiles(profiles);
  }

  static Future<void> removeProfile(String id) async {
    final profiles = await loadProfiles();
    profiles.removeWhere((p) => p.id == id);

    if (profiles.isNotEmpty && !profiles.any((p) => p.isDefault)) {
      profiles[0] = profiles[0].copyWith(isDefault: true);
    }

    await saveProfiles(profiles);
  }

  static Future<void> updateProfile(String id, BedrockProfile profile) async {
    final profiles = await loadProfiles();
    final index = profiles.indexWhere((p) => p.id == id);

    if (index >= 0) {
      if (profile.isDefault) {
        for (var i = 0; i < profiles.length; i++) {
          if (i != index) {
            profiles[i] = profiles[i].copyWith(isDefault: false);
          }
        }
      }

      profiles[index] = profile;
      await saveProfiles(profiles);
    }
  }

  static Future<BedrockProfile?> getDefaultProfile() async {
    final profiles = await loadProfiles();
    return profiles.firstWhere(
      (p) => p.isDefault,
      orElse: () =>
          profiles.isNotEmpty ? profiles.first : null as BedrockProfile,
    );
  }

  static String generateId() => _uuid.v4();
}
