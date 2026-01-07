class ServerEntry {
  final String name;
  final String address;
  final int port;
  final String background;

  ServerEntry({
    required this.name,
    required this.address,
    required this.port,
    required this.background,
  });

  factory ServerEntry.fromJson(Map<String, dynamic> json) {
    return ServerEntry(
      name: json['name'],
      address: json['address'],
      port: json['port'],
      background: json['background'],
    );
  }
}
