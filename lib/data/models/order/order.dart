import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  String? id;

  bool? isActive;

  // "price": "$3,164.16",
  double? price;

  String? company;

  String? picture;

  /// name of the buyer
  String? buyer;

  List<String>? tags;

  String? status;

  DateTime? registered;

  /// if this order has been returned
  bool get isReturned => status == 'RETURNED';

  Order({
    required this.id,
    required this.isActive,
    required String price,
    required this.company,
    required this.picture,
    required this.buyer,
    required this.tags,
    required this.status,
    required this.registered,
  }) {
    // parse the price
    this.price =
        double.tryParse(price.replaceAll(r'$', '').replaceAll(',', ''));
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return _$OrderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
