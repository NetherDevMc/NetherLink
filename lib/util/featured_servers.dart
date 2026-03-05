class FeaturedServer {
  final String name;
  final String address;
  final int port;
  final String description;
  final String? iconUrl;
  final String? websiteUrl;

  FeaturedServer({
    required this.name,
    required this.address,
    required this.port,
    required this.description,
    this.iconUrl,
    this.websiteUrl,
  });

  factory FeaturedServer.fromJson(Map<String, dynamic> json) => FeaturedServer(
    name: json['name'] as String,
    address: json['address'] as String,
    port: json['port'] as int? ?? 19132,
    description: json['description'] as String? ?? '',
    iconUrl: json['iconUrl'] as String?,
    websiteUrl: json['websiteUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'port': port,
    'description': description,
    'iconUrl': iconUrl,
    'websiteUrl': websiteUrl,
  };
}
