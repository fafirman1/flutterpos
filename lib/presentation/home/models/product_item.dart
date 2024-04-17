
import 'dart:convert';

import 'package:pos/data/models/response/product_response_model.dart';

class OrderItem {
  final Product product;
  int quantity;
  OrderItem({
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  Map<String, dynamic> toMapForLocal(int orderId) {
    return <String, dynamic>{
      'id_order':orderId,
      'product': product.id,
      'quantity': quantity,
      'price' : product.price,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      product: Product.fromMap(map['product']),
      quantity: map['quantity'] ?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) => OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
