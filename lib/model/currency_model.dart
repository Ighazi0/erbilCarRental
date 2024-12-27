class CurrencyModel {
  final String? code, flag;
  final double? rate;

  CurrencyModel({this.code, this.flag, this.rate});

  static CurrencyModel fromMap(Map map) {
    return CurrencyModel(
      code: map['code'],
      flag: map['flag'],
      rate: double.tryParse(map['rate'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'flag': flag,
      'rate': rate,
    };
  }
}
