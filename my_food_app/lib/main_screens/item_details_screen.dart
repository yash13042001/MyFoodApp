import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_food_app/global/global.dart';
import 'package:my_food_app/models/items.dart';
import 'package:my_food_app/splash_screen/splash_screen.dart';
import 'package:my_food_app/widgets/simple_app_bar.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key, this.model});

  final Items? model;

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  deleteItem(String itemID) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedpreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuID!)
        .collection("items")
        .doc(itemID)
        .delete()
        .then((value) {
      FirebaseFirestore.instance.collection("items").doc(itemID).delete();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      );

      Fluttertoast.showToast(msg: "Item Deleted Successflly.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: sharedpreferences!.getString("name")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 285,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.model!.thumnbnailURL.toString(),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "₹ ${widget.model!.price.toString()}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: InkWell(
              onTap: () {
                deleteItem(widget.model!.itemID!);
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan,
                      Colors.amber,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 10,
                height: 50,
                child: const Center(
                  child: Text(
                    "Delete this Item",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
