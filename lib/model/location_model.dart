import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  String? nameAr, nameEn;
  DocumentReference? docRef;

  LocationModel({
    this.nameAr,
    this.nameEn,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    return {
      'name_ar': nameAr,
      'name_En': nameEn,
    };
  }

  static LocationModel fromMap(Map map, DocumentReference docRef) {
    return LocationModel(
        nameAr: map['name_ar'], nameEn: map['name_en'], docRef: docRef);
  }
}
