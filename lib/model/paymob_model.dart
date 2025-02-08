class PaymobModel {
  final int? id;
  final String? shortenUrl;
  final int? amountCents;
  final String? clientUrl;
  final String? state;
  final int? order;

  PaymobModel({
    this.id,
    this.shortenUrl,
    this.amountCents,
    this.clientUrl,
    this.state,
    this.order,
  });

  factory PaymobModel.fromJson(Map<String, dynamic> json) {
    return PaymobModel(
      id: json['id'],
      shortenUrl: json['shorten_url'],
      amountCents: json['amount_cents'],
      clientUrl: json['client_url'],
      state: json['state'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shorten_url': shortenUrl,
      'amount_cents': amountCents,
      'client_url': clientUrl,
      'state': state,
      'order': order,
    };
  }
}
