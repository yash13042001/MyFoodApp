import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_food_riders_app/assistant_methods/get_current_location.dart';
import 'package:my_food_riders_app/authentication/auth_screen.dart';
import 'package:my_food_riders_app/global/global.dart';
import 'package:my_food_riders_app/main_screens/earnings_screen.dart';
import 'package:my_food_riders_app/main_screens/history_screen.dart';
import 'package:my_food_riders_app/main_screens/new_orders_screen.dart';
import 'package:my_food_riders_app/main_screens/not_yet_delivered_screen.dart';
import 'package:my_food_riders_app/main_screens/parcel_in_prgress.dart';
import 'package:my_food_riders_app/splashScreen/splas_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Card makeDashboardItem(String title, IconData iconData, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.amber,
                    Colors.cyan,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              )
            : const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.redAccent,
                    Colors.amber,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //New Available orders
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewOrdersScreen(),
                ),
              );
            }
            if (index == 1) {
              //Parcels in Progress
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParcelInProgessScreen(),
                ),
              );
            }
            if (index == 2) {
              //Net Yet Delivered
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotYetDeliveredScreen(),
                ),
              );
            }
            if (index == 3) {
              //History
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            }
            if (index == 4) {
              //Total Earnings
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EarningsScreen(),
                ),
              );
            }
            if (index == 5) {
              //LogOut
              firebaseAuth.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthScreen(),
                  ),
                );
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Icon(
                  iconData,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  restrictBlockedRidersFromUsingApp() async {
    await FirebaseFirestore.instance
        .collection("riders")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["status"] != "approved") {
        Fluttertoast.showToast(msg: "You have been blocked");
        firebaseAuth.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const SplashScreen(),
          ),
        );
      } else {
        UserLocation ulocation = UserLocation();
        ulocation.getCurrentLocation();
        getPerParcelDeliveryAmount();
        getRiderPreviousEarnings();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    restrictBlockedRidersFromUsingApp();
  }

  getRiderPreviousEarnings() {
    FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedpreferences!.getString("uid"))
        .get()
        .then((snap) {
      previousRiderEarnings = snap.data()!["earnings"].toString();
    });
  }

  getPerParcelDeliveryAmount() {
    FirebaseFirestore.instance
        .collection("perDelivery")
        .doc("yash13042001")
        .get()
        .then((snap) {
      perParcelDeliveryAmount = snap.data()!["amount"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: Text(
          "Welcome ${sharedpreferences!.getString("name")!}",
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontFamily: "Signatra",
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(2),
          children: [
            makeDashboardItem("New Available Orders", Icons.assignment, 0),
            makeDashboardItem("Parcel in Progress", Icons.airport_shuttle, 1),
            makeDashboardItem("Net Yet Delivered", Icons.location_history, 2),
            makeDashboardItem("History", Icons.done_all, 3),
            makeDashboardItem("Total Earnings", Icons.monetization_on, 4),
            makeDashboardItem("Logout", Icons.logout, 5),
          ],
        ),
      ),
    );
  }
}
