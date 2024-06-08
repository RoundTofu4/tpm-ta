class Worker {
  final String firstName;
  final String lastName;
  final String email;

  Worker({required this.firstName, required this.lastName, required this.email});

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      email: json['email'],
    );
  }
}
