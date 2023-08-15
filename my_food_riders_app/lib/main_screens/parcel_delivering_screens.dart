import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_food_riders_app/assistant_methods/get_current_location.dart';
import 'package:my_food_riders_app/global/global.dart';
import 'package:my_food_riders_app/maps.dart/map_utils.dart';
import 'package:my_food_riders_app/splashScreen/splas_screen.dart';

// ignore: must_be_immutable
class ParcelDeliveringScreen extends StatefulWidget {
  ParcelDeliveringScreen({
    super.key,
    this.purchaserId,
    this.purchaserAddress,
    this.purchaserLat,
    this.purchaserLng,
    this.sellerId,
    this.getOrderId,
  });

  final String? purchaserId;
  final String? purchaserAddress;
  final double? purchaserLat;
  final double? purchaserLng;
  String? sellerId;
  final String? getOrderId;

  @override
  State<ParcelDeliveringScreen> createState() => _ParcelDeliveringScreenState();
}

class _ParcelDeliveringScreenState extends State<ParcelDeliveringScreen> {
  String orderTotalAmount = "";
  confirmParcelHasBeenDelivered(getOrderId, sellerId, purchaserId,
      purchaserAddress, purchaserLat, purchaserLng) {
    String riderNewTotalEarningsAmount = ((double.parse(previousRiderEarnings)) + (double.parse(perParcelDeliveryAmount))).toString();

    FirebaseFirestore.instance.collection("orders").doc(getOrderId).update({
      "status": "ended",
      "address": completeAddress,
      "lat": position!.latitude,
      "lng": position!.longitude,
      "earnings": perParcelDeliveryAmount, // Pay per Parcel Delivery Amount
    }).then((value) {
      FirebaseFirestore.instance
          .collection("riders")
          .doc(sharedpreferences!.getString("uid"))
          .update({
        "earnings": riderNewTotalEarningsAmount, // Total Earnings of the Rider
      });
    }).then((value) {
      FirebaseFirestore.instance
          .collection("sellers")
          .doc(widget.sellerId)
          .update({
        "earnings": (
          double.parse(orderTotalAmount) + double.parse(previousEarnings)
        )
            .toString(), // Total Earnings Amount of the seller
      });
    }).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(purchaserId)
          .collection("orders")
          .doc(getOrderId)
          .update({
        "status": "ended",
        "riderUID": sharedpreferences!.getString("uid"),
      });
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => const SplashScreen(),
      ),
    );
  }

  

  getOrderTotalAmount() {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.getOrderId)
        .get()
        .then((snap) {
      orderTotalAmount = snap.data()!["totalAmount"].toString();
      widget.sellerId = snap.data()!["sellerUID"].toString();
    }).then((value) {
      getSellerData();
    });
  }

  getSellerData() {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.sellerId)
        .get()
        .then((snap) {
      previousEarnings = snap.data()!["earnings"].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    UserLocation uLocation = UserLocation();
    uLocation.getCurrentLocation();
    getOrderTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/confirm2.png"),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              //Show location from rider current location towards seller location
              MapUtils.launchMapFromSourceToDestination(
                position!.latitude,
                position!.longitude,
                widget.purchaserLat,
                widget.purchaserLng,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/restaurant.png", width: 50),
                const SizedBox(width: 7),
                const Column(
                  children: [
                    SizedBox(height: 13),
                    Text(
                      "Show Delivery Drop-off Location",
                      style: TextStyle(
                        fontFamily: "Signatra",
                        fontSize: 18,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  //Updated User Location
                  UserLocation uLocation = UserLocation();
                  uLocation.getCurrentLocation();
                  //Confirmed - that rider has picked parcel from seller
                  confirmParcelHasBeenDelivered(
                    widget.getOrderId,
                    widget.sellerId,
                    widget.purchaserId,
                    widget.purchaserAddress,
                    widget.purchaserLat,
                    widget.purchaserLng,
                  );
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
                  width: MediaQuery.of(context).size.width - 90,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Order has benn Delivered - Confirmed",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
