import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_food_users_app/assistantMethods/cart_item_counter.dart';
import 'package:my_food_users_app/global/global.dart';
import 'package:provider/provider.dart';

addItemToCart(String? foodItemID, BuildContext context, int itemCounter) {
  List<String>? tempList = sharedpreferences!.getStringList("userCart");
  tempList!.add("${foodItemID!}:$itemCounter");

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": tempList}).then((value) {
    Fluttertoast.showToast(msg: "Item Added Successfully.");
    sharedpreferences!.setStringList("userCart", tempList);

    //update the badge
    Provider.of<CartItemCounter>(context, listen: false)
        .displayCartListitemNumber();    
  });
}
seperateOrderItemIDs(orderIDs) {
  List<String> seperateItemIDs = [];
  List<String> defaultItemList = [];

  int i = 0;
  defaultItemList = List<String>.from(orderIDs);

  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    String getItemID = (pos != -1) ? item.substring(0, pos) : item;

    seperateItemIDs.add(getItemID);
  }

  return seperateItemIDs;
}

seperateItemIDs() {
  List<String> seperateItemIDs = [];
  List<String> defaultItemList = [];

  int i = 0;
  defaultItemList = sharedpreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    String getItemID = (pos != -1) ? item.substring(0, pos) : item;

    seperateItemIDs.add(getItemID);
  }

  return seperateItemIDs;
}
seperateOrderItemQuantities(orderIDs) {
  List<String> seperateItemQuantityList = [];
  List<String> defaultItemList = [];

  int i = 1;
  defaultItemList = List<String>.from(orderIDs);

  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();
    List<String> listItemCharacters = item.split(":").toList();

    var quantNumber = int.parse(listItemCharacters[1].toString());
    seperateItemQuantityList.add(quantNumber.toString());
  }

  return seperateItemQuantityList;
}

seperateItemQuantities() {
  List<int> seperateItemQuantityList = [];
  List<String> defaultItemList = [];

  int i = 1;
  defaultItemList = sharedpreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();
    List<String> listItemCharacters = item.split(":").toList();

    var quantNumber = int.parse(listItemCharacters[1].toString());
    seperateItemQuantityList.add(quantNumber);
  }

  return seperateItemQuantityList;
}

clearCartNow(context) {
  sharedpreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedpreferences!.getStringList("userCart");

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": emptyList}).then((value) {
    sharedpreferences!.setStringList("userCart", emptyList!);
    Provider.of<CartItemCounter>(context, listen: false)
        .displayCartListitemNumber();
  });
}
