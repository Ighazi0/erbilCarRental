import 'package:erbil/model/currency_model.dart';

class AppDataModel {
  final List<CurrencyModel>? currencies;

  AppDataModel({this.currencies});

  factory AppDataModel.fromJson(Map json) {
    List c = json['currencies'] ?? [];
    return AppDataModel(
      currencies: c.map((m) => CurrencyModel.fromMap(m)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'currencies': currencies,
      };
}
