import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_food_riders_app/assistant_methods/assistant_methods.dart';
import 'package:my_food_riders_app/global/global.dart';
import 'package:my_food_riders_app/widgets/order_cart.dart';
import 'package:my_food_riders_app/widgets/progress_bar.dart';
import 'package:my_food_riders_app/widgets/simple_app_bar.dart';

class ParcelInProgessScreen extends StatefulWidget {
  const ParcelInProgessScreen({super.key});

  @override
  State<ParcelInProgessScreen> createState() => _ParcelInProgessScreenState();
}

class _ParcelInProgessScreenState extends State<ParcelInProgessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const SimpleAppBar(title: "Parcel In Progress"),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("riderUID",
                  isEqualTo: sharedpreferences!.getString("uid"))
              .where("status", isEqualTo: "picking")
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
