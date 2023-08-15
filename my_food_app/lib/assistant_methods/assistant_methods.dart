import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_food_app/global/global.dart';


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
  });
}
