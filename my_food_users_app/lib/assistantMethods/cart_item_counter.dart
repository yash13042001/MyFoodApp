import 'package:flutter/material.dart';
import 'package:my_food_users_app/global/global.dart';

class CartItemCounter extends ChangeNotifier {
  int cartListItemCounter =
      sharedpreferences!.getStringList("userCart")!.length-1;

  int get count => cartListItemCounter;

  Future<void> displayCartListitemNumber() async {
    cartListItemCounter = sharedpreferences!.getStringList("userCart")!.length-1;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
