import 'dart:developer';

import 'package:test_task/ui/widgets/shop/product.dart';
import 'package:test_task/ui/widgets/shop/user.dart';

class Informer {
  void buy(User user, Product product) {
    double price = product.getDiscountPrice(user);
    user.reduceBalance(price);
    log("${user.name} degan kupyv ${product.name} za $price na sklad poletiv");
  }
}
