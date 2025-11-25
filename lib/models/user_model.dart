class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final DateTime createdAt;
  final List<String> savedDestinations;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.createdAt,
    this.savedDestinations = const [],
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
      savedDestinations: List<String>.from(map['savedDestinations'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'savedDestinations': savedDestinations,
    };
  }
}
