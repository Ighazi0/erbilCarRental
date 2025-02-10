import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? titleEn, image, titleAr, id;
  DocumentReference? docRef;

  CategoryModel({this.id, this.titleEn, this.titleAr, this.image, this.docRef});

  factory CategoryModel.fromJson(Map json, DocumentReference docRef) {
    return CategoryModel(
      id: json['id'].toString(),
      titleEn: json['titleEn'],
      titleAr: json['titleAr'],
      image: json['image'],
      docRef: docRef,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'titleEn': titleEn,
        'titleAr': titleAr,
        'image': image,
      };
}
