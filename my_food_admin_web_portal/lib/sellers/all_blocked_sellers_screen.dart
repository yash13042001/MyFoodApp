import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_food_admin_web_portal/main_screens/home_screen.dart';
import 'package:my_food_admin_web_portal/widgets/simple_app_bar.dart';

class AllBlockedSellersScreen extends StatefulWidget {
  const AllBlockedSellersScreen({super.key});

  @override
  State<AllBlockedSellersScreen> createState() =>
      _AllBlockedSellersScreenState();
}

class _AllBlockedSellersScreenState extends State<AllBlockedSellersScreen> {
  QuerySnapshot? allSellers;

  displayDialogBoxForActivatingAccount(sellerDocumentID) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Activate Account",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Do you want to activate this account",
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> userDataMap = {"status": "approved"};
                FirebaseFirestore.instance
                    .collection("sellers")
                    .doc(sellerDocumentID)
                    .update(userDataMap)
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const HomeScreen(),
                    ),
                  );
                  SnackBar snackBar = const SnackBar(
                    content: Text(
                      "Activated Successfully",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    backgroundColor: Colors.deepPurpleAccent,
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "not approved")
        .get()
        .then((allverifiedSellers) {
      setState(() {
        allSellers = allverifiedSellers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget displayBlockedSellersAccounts() {
      if (allSellers != null) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: allSellers!.docs.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                allSellers!.docs[index].get("sellerAvatarURL"),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        title: Text(
                          allSellers!.docs[index].get("sellername"),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            Text(
                              allSellers!.docs[index].get("sellerEmail"),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan),
                        onPressed: () {
                          SnackBar snackBar = SnackBar(
                            content: Text(
                              "Total Earnings ₹ ${allSellers!.docs[index].get("earnings")}"
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.black),
                            ),
                            backgroundColor: Colors.cyan,
                            duration: const Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: const Icon(
                          Icons.person_pin_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Total Earnings ₹ ${allSellers!.docs[index].get("earnings")}"
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          displayDialogBoxForActivatingAccount(
                              allSellers!.docs[index].id);
                        },
                        icon: const Icon(
                          Icons.person_pin_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Activate this Account".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      } else {
        return const Center(
          child: Text(
            "No Records Found",
            style: TextStyle(fontSize: 30),
          ),
        );
      }
    }

    return Scaffold(
      appBar: const SimpleAppBar(
        title: "All Blocked Sellers Accounts",
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: displayBlockedSellersAccounts(),
        ),
      ),
    );
  }
}
