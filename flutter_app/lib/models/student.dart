class Student {
  final int? id;
  final String name;
  final String rollNumber;
  final String email;
  final double cgpa;

  Student({
    this.id,
    required this.name,
    required this.rollNumber,
    required this.email,
    required this.cgpa,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      name: json['name'] ?? '',
      rollNumber: json['roll_number'] ?? '',
      email: json['email'] ?? '',
      cgpa: double.tryParse(json['cgpa'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'roll_number': rollNumber,
      'email': email,
      'cgpa': cgpa.toString(),
    };
  }
}
