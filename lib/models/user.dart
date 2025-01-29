class User {
  final int id;
  final String name;
  final String phoneNumber;
  
  User({
    required this.id,
    required this.name,
    required this.phoneNumber
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      phoneNumber: data['phone_number']
    );
  }
}