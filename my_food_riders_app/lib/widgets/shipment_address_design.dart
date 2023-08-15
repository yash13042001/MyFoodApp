import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_food_riders_app/assistant_methods/get_current_location.dart';
import 'package:my_food_riders_app/global/global.dart';
import 'package:my_food_riders_app/main_screens/parcel_picking_screen.dart';
import 'package:my_food_riders_app/models/address.dart';
import 'package:my_food_riders_app/splashScreen/splas_screen.dart';

class ShipmentAddressDesign extends StatelessWidget {
  const ShipmentAddressDesign({
    super.key,
    this.model,
    this.orderStatus,
    this.orderId,
    this.sellerId,
    this.orderByUser,
  });

  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  confirmedParcelShipment(BuildContext context, String getOrderID,
      String sellerId, String purchaserID) {
    FirebaseFirestore.instance.collection("orders").doc(getOrderID).update({
      "riderUID": sharedpreferences!.getString("uid"),
      "riderName": sharedpreferences!.getString("name"),
      "status": "picking",
      "lat": position!.latitude,
      "lng": position!.longitude,
      "address": completeAddress,
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParcelpickingScreen(
            purchaserID: purchaserID,
            purchaserAddress: model!.fullAddress,
            purchaserLat: model!.lat,
            purchaserLng: model!.lng,
            sellerId: sellerId,
            getOrderID: getOrderID,
          ),
        ),
      );
    });

    //send rider to shipment screen
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Shipment Details:",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  const Text(
                    "Name:",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.name!)
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "Phone Number:",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.phoneNumber!)
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),
        orderStatus == "ended"
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      UserLocation ulocation = UserLocation();
                      ulocation.getCurrentLocation();
                      confirmedParcelShipment(
                        context,
                        orderId!,
                        sellerId!,
                        orderByUser!,
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
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Confirm - to Deliver this Parcel",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
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
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Go Back",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
