import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final DocumentReference? car;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final int? days;
  final int? orderId;
  final Timestamp? from;
  final Timestamp? to;
  final double? totalPrice;
  final DocumentReference? user;
  final DocumentReference? location;
  final String? status;

  OrderModel(
      {this.car,
      this.createdAt,
      this.days,
      this.from,
      this.to,
      this.totalPrice,
      this.user,
      this.orderId,
      this.updatedAt,
      this.location,
      this.status});

  factory OrderModel.fromJson(Map json) {
    return OrderModel(
      car: json['car'],
      createdAt: json['createdAt'],
      days: json['days'],
      from: json['from'],
      to: json['to'],
      totalPrice: double.tryParse(json['totalPrice'].toString()),
      user: json['user'],
      orderId: json['order_id'],
      updatedAt: json['updatedAt'],
      location: json['location'],
      status: json['status'],
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
      'id': orderId,
      'updatedAt': updatedAt,
      'location': location,
      'status': status,
    };
  }
}
