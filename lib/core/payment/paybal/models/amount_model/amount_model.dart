import 'details.dart';

class AmountModel {
  String? total;
  String? currency;
  Details? details;

  AmountModel({this.total, this.currency, this.details});

  factory AmountModel.fromAmountModel(Map<String, dynamic> json) {
    return AmountModel(
      total: json['total'] as String?,
      currency: json['currency'] as String?,
      details: json['details'] == null
          ? null
          : Details.fromAmountModel(json['details'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toAmountModel() => {
        'total': total,
        'currency': currency,
        'details': details?.toAmountModel(),
      };
}
