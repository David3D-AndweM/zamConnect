class DestinationModel {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String gradientStart;
  final String gradientEnd;
  final String? imageUrl;

  DestinationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
    this.imageUrl,
  });

  factory DestinationModel.fromMap(Map<String, dynamic> map, String id) {
    return DestinationModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? 'place',
      gradientStart: map['gradientStart'] ?? '0xFF1565C0',
      gradientEnd: map['gradientEnd'] ?? '0xFF42A5F5',
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'icon': icon,
      'gradientStart': gradientStart,
      'gradientEnd': gradientEnd,
      'imageUrl': imageUrl,
    };
  }
}
