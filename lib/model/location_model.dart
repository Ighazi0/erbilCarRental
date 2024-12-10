class LocationModel {
  int? id;
  String? titleAr, titleEn, descriptionAr, descriptionEn;

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
      'title_ar': titleAr,
      'title_en': titleEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
    };
  }

  static LocationModel fromMap(Map map) {
    return LocationModel(
      id: map['id'],
      titleAr: map['title_ar'],
      titleEn: map['title_en'],
      descriptionAr: map['description_ar'],
      descriptionEn: map['description_en'],
    );
  }
}
