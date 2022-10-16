// ignore_for_file: public_member_api_docs

import 'package:test_task/ui/widgets/shop/product.dart';

class Condoms extends Product {
  final int size;

  Condoms(
    this.size, {
    required super.price,
    required super.name,
    required super.manufacturer,
  });
  // int size;
  @override
  String toString() => 'Aphrodisiak(composition: $size)} ${super.toString()}';
}
