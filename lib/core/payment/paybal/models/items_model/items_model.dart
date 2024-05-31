import 'item.dart';

class ItemsModel {
  List<Item>? items;

  ItemsModel({this.items});

  factory ItemsModel.fromItemsModel(Map<String, dynamic> json) => ItemsModel(
        items: (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromItemsModel(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toItemsModel() => {
        'items': items?.map((e) => e.toItemsModel()).toList(),
      };
}
