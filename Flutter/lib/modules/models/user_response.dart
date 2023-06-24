class User {
  final String name;
  final String email;

  User({
    required this.name, 
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email
  };

  static User fromJson(Map<String, dynamic> json) => User(
    name: json['name'],
    email: json['email']
  );
}