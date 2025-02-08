import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  final DocumentReference? docRef;
  final String? color;
  final DocumentReference? location;
  final int? cityMpg;
  final int? cylinders;
  final String? status;
  final String? fuelType;
  final DocumentReference? brand;
  final String? engineSize;
  final List<String>? images;
  final Timestamp? createdAt;
  final int? seats;
  final String? transmission;
  final String? mileage;
  final String? name;
  final String? driverType;
  final DocumentReference? type;
  final String? year;
  final String? condition;
  final DocumentReference? model;
  final int? doors;
  final double? price;
  final List<String>? features;
  final int? highwayMpg;
  final String? description;

  CarModel({
    this.color,
    this.location,
    this.cityMpg,
    this.cylinders,
    this.status,
    this.fuelType,
    this.brand,
    this.engineSize,
    this.images,
    this.createdAt,
    this.seats,
    this.transmission,
    this.mileage,
    this.name,
    this.driverType,
    this.type,
    this.year,
    this.condition,
    this.model,
    this.doors,
    this.price,
    this.features,
    this.highwayMpg,
    this.description,
    this.docRef,
  });

  factory CarModel.fromMap(Map data, DocumentReference docRef) {
    return CarModel(
      docRef: docRef,
      color: data['color'],
      location: data['location'],
      cityMpg: data['cityMpg'],
      cylinders: data['cylinders'],
      status: data['status'],
      fuelType: data['fuelType'],
      brand: data['brand'],
      engineSize: data['engineSize'],
      images: data['images'] != null ? List<String>.from(data['images']) : null,
      seats: data['seats'],
      transmission: data['transmission'],
      mileage: data['mileage'],
      name: data['name'],
      driverType: data['driverType'],
      type: data['type'],
      year: data['year'].toString(),
      condition: data['condition'],
      model: data['model'],
      doors: data['doors'],
      price: double.tryParse(data['price'].toString()),
      features: data['features'] != null
          ? (data['features'] as Map<String, dynamic>)
              .values
              .expand((value) => List<String>.from(value))
              .toList()
          : null,
      highwayMpg: data['highwayMpg'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'docRef': docRef,
      'color': color,
      'location': location,
      'cityMpg': cityMpg,
      'cylinders': cylinders,
      'status': status,
      'fuelType': fuelType,
      'brand': brand,
      'engineSize': engineSize,
      'images': images,
      'createdAt': createdAt,
      'seats': seats,
      'transmission': transmission,
      'mileage': mileage,
      'name': name,
      'driverType': driverType,
      'type': type,
      'year': year,
      'condition': condition,
      'model': model,
      'doors': doors,
      'price': price,
      'features': features,
      'highwayMpg': highwayMpg,
      'description': description,
    };
  }
}
