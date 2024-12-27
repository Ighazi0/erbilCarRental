class CategoryModel {
  String? titleEn, image, titleAr, name, id;

  CategoryModel({this.id, this.titleEn, this.titleAr, this.image, this.name});

  factory CategoryModel.fromJson(Map json, String id) => CategoryModel(
        id: id,
        titleEn: json['titleEn'],
        titleAr: json['titleAr'],
        image: json['image'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'titleEn': titleEn,
        'titleAr': titleAr,
        'name': name,
        'image': image,
      };
}
