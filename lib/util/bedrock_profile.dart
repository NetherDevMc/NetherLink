class BedrockProfile {
  final String id;
  final String username;
  final bool isDefault;

  BedrockProfile({
    required this.id,
    required this.username,
    this.isDefault = false,
  });

  String get label => username;

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'isDefault': isDefault,
  };

  factory BedrockProfile.fromJson(Map<String, dynamic> json) => BedrockProfile(
    id: json['id'] as String,
    username: json['username'] as String,
    isDefault: json['isDefault'] as bool? ?? false,
  );

  BedrockProfile copyWith({
    String? id,
    String? username,
    bool? isDefault,
  }) {
    return BedrockProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BedrockProfile &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => username;
}