// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs

import 'package:test_task/ui/widgets/shop/product.dart';

class Aphrodisiak extends Product {
  final String composition;
  Aphrodisiak({
    ///
    required super.price,
    required super.name,
    required super.manufacturer,

    ///
    required this.composition,
  });

  @override
  String toString() =>
      'Aphrodisiak(composition: $composition)} ${super.toString()}';
}
