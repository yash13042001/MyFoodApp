import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_food_users_app/assistantMethods/address_changer.dart';
import 'package:my_food_users_app/global/global.dart';
import 'package:my_food_users_app/main_screens/save_address_screen.dart';
import 'package:my_food_users_app/models/address.dart';
import 'package:my_food_users_app/widgets/address_design.dart';
import 'package:my_food_users_app/widgets/progress_bar.dart';
import 'package:my_food_users_app/widgets/simple_app_bar.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, this.totalAmount, this.sellerUID});

  final double? totalAmount;
  final String? sellerUID;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "IFood"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Save address to user collection
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SaveAddressScreen(),
            ),
          );
        },
        label: const Text("Add new Address"),
        backgroundColor: Colors.cyan,
        icon: const Icon(
          Icons.add_location,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Select Address:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Consumer<AddressChanger>(
            builder: (context, address, child) {
              return Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: circularProgress(),
                          )
                        // ignore: unrelated_type_equality_checks
                        : snapshot.data!.docs.isEmpty == 0
                            ? Container()
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AddressDesign(
                                    currentIndex: address.count,
                                    value: index,
                                    addressID: snapshot.data!.docs[index].id,
                                    totalAmount: widget.totalAmount,
                                    sellerUID: widget.sellerUID,
                                    model: Address.fromJson(
                                        snapshot.data!.docs[index].data()!
                                            as Map<String, dynamic>),
                                  );
                                },
                              );
                  },
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(sharedpreferences!.getString("uid"))
                      .collection("userAddress")
                      .snapshots(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
