class LocationModel {
  String? titleAr, titleEn, descriptionAr, descriptionEn, id;

  LocationModel({
    this.id,
    this.titleAr,
    this.titleEn,
    this.descriptionAr,
    this.descriptionEn,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titleAr': titleAr,
      'titleEn': titleEn,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
    };
  }

  static LocationModel fromMap(Map map, String id) {
    return LocationModel(
      id: id,
      titleAr: map['titleAr'],
      titleEn: map['titleEn'],
      descriptionAr: map['descriptionAr'],
      descriptionEn: map['descriptionEn'],
    );
  }
}
