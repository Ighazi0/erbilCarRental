import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  final String? id, transmission, name, description, status, year, seats, color;
  final List? images;
  final double? price;
  final DocumentReference? location, type, model;

  CarModel(
      {this.id,
      this.images,
      this.transmission,
      this.price,
      this.name,
      this.description,
      this.location,
      this.model,
      this.type,
      this.status,
      this.seats,
      this.color,
      this.year});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'images': images,
      'transmission': transmission,
      'price': price,
      'name': name,
      'description': description,
      'location': location,
      'model': model,
      'type': type,
      'status': status,
      'year': year,
      'color': color,
      'seats': seats,
    };
  }

  factory CarModel.fromMap(Map map, String id) {
    return CarModel(
      id: id,
      images: map['images'],
      transmission: map['transmission'],
      price: double.tryParse(map['price'].toString()),
      name: map['name'],
      description: map['description'],
      location: map['location'],
      model: map['model'],
      type: map['type'],
      status: map['status'],
      year: map['year'].toString(),
      seats: map['seats'].toString(),
      color: map['color'],
    );
  }
}
