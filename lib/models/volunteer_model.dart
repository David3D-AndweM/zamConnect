class VolunteerModel {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String iconColor;

  VolunteerModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.iconColor,
  });

  factory VolunteerModel.fromMap(Map<String, dynamic> map, String id) {
    return VolunteerModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? 'volunteer_activism',
      iconColor: map['iconColor'] ?? '0xFF4CAF50',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'icon': icon,
      'iconColor': iconColor,
    };
  }
}
