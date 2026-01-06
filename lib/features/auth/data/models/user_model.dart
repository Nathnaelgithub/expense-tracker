import 'package:expense_tracker/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.emailVerified,
    super.name,
    super.displayName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      name: json['name'],
      displayName: json['displayName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'emailVerified': emailVerified,
    'name': name,
    'displayName': displayName,
  };
}
