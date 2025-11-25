class JobModel {
  final String id;
  final String title;
  final String company;
  final String description;
  final String salary;
  final String icon;
  final DateTime createdAt;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.salary,
    required this.icon,
    required this.createdAt,
  });

  factory JobModel.fromMap(Map<String, dynamic> map, String id) {
    return JobModel(
      id: id,
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      description: map['description'] ?? '',
      salary: map['salary'] ?? '',
      icon: map['icon'] ?? 'work',
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'description': description,
      'salary': salary,
      'icon': icon,
      'createdAt': createdAt,
    };
  }
}
