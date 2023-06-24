class UserResponse {
  final String name;
  final String email;

  UserResponse({
    required this.name, 
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email
  };

  static UserResponse fromJson(Map<String, dynamic> json) => UserResponse(
    name: json['name'],
    email: json['email']
  );
}