// ignore_for_file: public_member_api_docs

import 'package:test_task/ui/widgets/shop/product.dart';

class Dolls extends Product {
  final String material;
  Dolls({
    ///
    required super.price,
    required super.name,
    required super.manufacturer,

    ///
    required this.material,
  });
  @override
  String toString() =>
      'Aphrodisiak(composition: $material)} ${super.toString()}';
}
