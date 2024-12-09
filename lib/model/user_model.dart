import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email, password, firstName, lastName, fullName, gender, uid, image;
  Timestamp? birthday, createdAt;
  bool? deleted, blocked;

  UserModel({
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.fullName,
    this.gender,
    this.image,
    this.uid,
    this.birthday,
    this.createdAt,
    this.deleted = false,
    this.blocked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'gender': gender,
      'uid': uid,
      'image': image,
      'birthday': birthday,
      'created_at': createdAt,
      'deleted': deleted,
      'blocked': blocked,
    };
  }

  factory UserModel.fromJson(Map json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      fullName: json['full_name'],
      gender: json['gender'],
      uid: json['uid'],
      image: json['image'],
      birthday: json['birthday'],
      createdAt: json['created_at'],
      deleted: json['deleted'] ?? false,
      blocked: json['blocked'] ?? false,
    );
  }
}
