import 'package:market_admin_app/Model/Models/product_model.dart';

class UserModel {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String? imageUrl;
  final String? phoneNumber;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.imageUrl,
    this.phoneNumber,
  });

  factory UserModel.fromMap(Map<dynamic, dynamic> data) {
    return UserModel(
        id: data['id'],
        username: data['username'],
        email: data['email'],
        password: data['password'],
        imageUrl: data['image'],
        phoneNumber: data['phoneNumber']);
  }

  Map<String , dynamic>toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'image_url': imageUrl,
      'phone_number': phoneNumber,
    };
  }
}
