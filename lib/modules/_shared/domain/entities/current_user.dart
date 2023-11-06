import 'dart:convert';


class CurrentUser {
  final String id;
  final String name;
  final String email;
  final String avatar; 
  final String type;
  String? token;
  
  CurrentUser({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.type,
    this.token = ''
  });

  @override
  String toString() {
    return 'CurrentUser(id: $id, name: $name, email: $email, avatar: $avatar, token: $token)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'type': type,
      'token': token,
    };
  }

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return CurrentUser(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? '',
      type: map['type'] ?? '',
      token: map['access_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentUser.fromJson(String source) => CurrentUser.fromMap(json.decode(source));
}
