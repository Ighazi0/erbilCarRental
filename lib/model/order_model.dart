import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final DocumentReference? car;
  final Timestamp? createdAt;
  final int? days;
  final Timestamp? from;
  final Timestamp? to;
  final int? totalPrice;
  final DocumentReference? user;

  OrderModel({
    required this.car,
    required this.createdAt,
    required this.days,
    required this.from,
    required this.to,
    required this.totalPrice,
    required this.user,
  });

  factory OrderModel.fromJson(Map json) {
    return OrderModel(
      car: json['car'],
      createdAt: json['createdAt'],
      days: json['days'],
      from: json['from'],
      to: json['to'],
      totalPrice: json['totalPrice'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'car': car,
      'createdAt': createdAt,
      'days': days,
      'from': from,
      'to': to,
      'totalPrice': totalPrice,
      'user': user,
    };
  }
}
