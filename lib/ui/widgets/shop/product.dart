// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: no-magic-number
import 'package:test_task/ui/widgets/shop/user.dart';

class Product {
  double price;
  String name;
  String manufacturer;
  Product({
    required this.price,
    required this.name,
    required this.manufacturer,
  });

  double getDiscountPrice(User user) {
    if (user.spent < 300) {
      return price;
    }
    if (user.spent < 1000) {
      return price * 0.9;
    }

    return price * 0.8;
  }

  @override
  String toString() =>
      'price: $price, name: $name, manufacturer: $manufacturer';
}
