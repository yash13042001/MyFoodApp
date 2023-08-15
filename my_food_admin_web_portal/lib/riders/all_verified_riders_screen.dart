import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_food_admin_web_portal/main_screens/home_screen.dart';
import 'package:my_food_admin_web_portal/widgets/simple_app_bar.dart';

class AllVerifiedRidersScreen extends StatefulWidget {
  const AllVerifiedRidersScreen({super.key});

  @override
  State<AllVerifiedRidersScreen> createState() => _AllVerifiedRidersScreenState();
}

class _AllVerifiedRidersScreenState extends State<AllVerifiedRidersScreen> {
  QuerySnapshot? allRiders;

  displayDialogBoxForblockingAccount(riderDocumentID) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Block Account",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Do you want to block this account",
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
                Map<String, dynamic> userDataMap = {"status": "not approved"};
                FirebaseFirestore.instance
                    .collection("riders")
                    .doc(riderDocumentID)
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
                      "Blocked Successfully",
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
        .collection("riders")
        .where("status", isEqualTo: "approved") 
        .get()
        .then((allverifiedRiders) {
      setState(() {
        allRiders = allverifiedRiders;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget displayVerifiedRidersAccounts() {
      if (allRiders != null) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: allRiders!.docs.length,
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
                                allRiders!.docs[index].get("riderAvatarURL"),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        title: Text(
                          allRiders!.docs[index].get("ridername"),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            Text(
                              allRiders!.docs[index].get("riderEmail"),
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
                            backgroundColor: Colors.green),
                        onPressed: () {
                          SnackBar snackBar = SnackBar(
                            content: Text(
                              "Total Earnings ₹ ${allRiders!.docs[index].get("earnings")}"
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.black),
                            ),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: const Icon(
                          Icons.person_pin_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Total Earnings ₹ ${allRiders!.docs[index].get("earnings")}"
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
                            backgroundColor: Colors.red),
                        onPressed: () {
                          displayDialogBoxForblockingAccount(
                              allRiders!.docs[index].id);
                        },
                        icon: const Icon(
                          Icons.person_pin_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Block this Account".toUpperCase(),
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
        title: "All Verified Riders Accounts",
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: displayVerifiedRidersAccounts(),
        ),
      ),
    );
  }
}
