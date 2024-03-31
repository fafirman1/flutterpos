import 'dart:convert';

class AuthResponseModel {
    final User user;
    final String token;

    AuthResponseModel({
        required this.user,
        required this.token,
    });

    factory AuthResponseModel.fromRawJson(String str) => AuthResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    final int id;
    final String name;
    final String email;
    final String roles;
    final String phone;
    final DateTime createdAt;
    final DateTime updatedAt;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.roles,
        required this.phone,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roles: json["roles"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "roles": roles,
        "phone": phone,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
