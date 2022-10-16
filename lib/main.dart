import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_task/ui/widgets/app_widget.dart';
import 'package:test_task/ui/widgets/shop/product.dart';
import 'package:test_task/ui/widgets/shop/products/aphrodisiak.dart';
import 'package:test_task/ui/widgets/shop/products/condoms.dart';
import 'package:test_task/ui/widgets/shop/products/dolls.dart';
import 'package:test_task/ui/widgets/shop/user.dart';

void main() {
  runApp(const AppWidget());
  final user = User(
    address: "Kyiv",
    name: "Ivan",
    balance: 24.9,
    spent: 234.2,
  );
  log(user.toString());
  final gusDolls = Dolls(
    price: 241.2,
    name: "Dolls",
    manufacturer: "Gysuna",
    material: "rezina",
  );
  log(gusDolls.toString());
  final aphrodisiakHorses = Aphrodisiak(
    price: 213.1,
    name: "Horses Afrodisiak",
    manufacturer: "Blagov",
    composition: "Voda",
  );
  log(aphrodisiakHorses.toString());
  final aphrodisiakHumans = Aphrodisiak(
    price: 213.1,
    name: "Horses Afrodisiak",
    manufacturer: "Blagov",
    composition: "Hren",
  );

  final durexCondoms = Condoms(
    200,
    price: 13.1,
    name: "Ultra-thin",
    manufacturer: "Durex",
  );
  log(durexCondoms.toString());
  final List<Product> products = [];

  products
    ..add(durexCondoms)
    ..add(gusDolls)
    ..add(aphrodisiakHumans)
    ..add(aphrodisiakHorses);
  print(products);
}
