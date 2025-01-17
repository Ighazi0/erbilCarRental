class LocationModel {
  String? nameAr, nameEn, descriptionAr, descriptionEn, id;

  LocationModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_En': nameEn,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
    };
  }

  static LocationModel fromMap(Map map, String id) {
    return LocationModel(
      id: id,
      nameAr: map['name_ar'],
      nameEn: map['name_en'],
      descriptionAr: map['descriptionAr'],
      descriptionEn: map['descriptionEn'],
    );
  }
}
