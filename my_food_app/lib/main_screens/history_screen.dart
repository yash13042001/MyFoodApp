import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_food_app/assistant_methods/assistant_methods.dart';
import 'package:my_food_app/global/global.dart';
import 'package:my_food_app/widgets/order_cart.dart';
import 'package:my_food_app/widgets/progress_bar.dart';
import 'package:my_food_app/widgets/simple_app_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const SimpleAppBar(title: "History"),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("sellerUID",
                  isEqualTo: sharedpreferences!.getString("uid"))
              .where("status", isEqualTo: "ended")
              .orderBy("orderTime",descending: true)
              .snapshots(),
          builder: (c, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (c, index) {
                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("items")
                            .where(
                              "itemID",
                              whereIn: seperateOrderItemIDs(
                                (snapshot.data!.docs[index].data()!
                                    as Map<String, dynamic>)["productIDs"],
                              ),
                            )
                            .where(
                              "sellerUID",
                              whereIn: (snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>)["uid"],
                            )
                            .orderBy("publishedDate", descending: true)
                            .get(),
                        builder: (c, snap) {
                          return snap.hasData
                              ? OrderCard(
                                  itemCount: snap.data!.docs.length,
                                  data: snap.data!.docs,
                                  orderID: snapshot.data!.docs[index].id,
                                  seperateQuantitiesList:
                                      seperateOrderItemQuantities(
                                          (snapshot.data!.docs[index].data()!
                                                  as Map<String, dynamic>)[
                                              "productIDs"]),
                                )
                              : Center(
                                  child: circularProgress(),
                                );
                        },
                      );
                    },
                  )
                : Center(child: circularProgress());
          },
        ),
      ),
    );
  }
}