import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  final String? id, transmission, name, description, status, model, year;
  final List? images;
  final bool? rented;
  final double? price;
  final DocumentReference? location, type;
  final Timestamp? updatedAt;

  CarModel(
      {this.id,
      this.images,
      this.transmission,
      this.rented,
      this.price,
      this.name,
      this.description,
      this.location,
      this.model,
      this.type,
      this.status,
      this.updatedAt,
      this.year});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'images': images,
      'transmission': transmission,
      'rented': rented,
      'price': price,
      'name': name,
      'description': description,
      'location': location,
      'model': model,
      'type': type,
      'status': status,
      'updatedAt': updatedAt,
      'year': year,
    };
  }

  factory CarModel.fromMap(Map map, String id) {
    return CarModel(
      id: id,
      images: map['images'],
      transmission: map['transmission'],
      rented: map['rented'],
      price: double.tryParse(map['price'].toString()),
      name: map['name'],
      description: map['description'],
      location: map['location'],
      model: map['model'],
      type: map['type'],
      status: map['status'],
      updatedAt: map['updatedAt'],
      year: map['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'images': images,
      'transmission': transmission,
      'rented': rented,
      'price': price,
      'name': name,
      'description': description,
      'location': location,
      'model': model,
      'type': type,
      'status': status,
      'updatedAt': updatedAt,
      'year': year
    };
  }
}
