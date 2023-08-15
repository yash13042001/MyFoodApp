import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_food_users_app/global/global.dart';
import 'package:my_food_users_app/models/address.dart';
import 'package:my_food_users_app/widgets/simple_app_bar.dart';
import 'package:my_food_users_app/widgets/text_field.dart';

// ignore: must_be_immutable
class SaveAddressScreen extends StatelessWidget {
  final __name = TextEditingController();
  final __phoneNumber = TextEditingController();
  final __flatNumber = TextEditingController();
  final __city = TextEditingController();
  final __state = TextEditingController();
  final __completeAddress = TextEditingController();
  final __locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<Placemark>? placemarks;
  Position? position;

  SaveAddressScreen({super.key});

  getUserLocationAddress() async {
    // ignore: unused_local_variable
    LocationPermission permission = await Geolocator.requestPermission();
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = newPosition;
    placemarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );

    Placemark pMark = placemarks![0];

    String fullAddress =
        '${pMark.thoroughfare} ${pMark.subThoroughfare},${pMark.subLocality} ${pMark.locality},${pMark.subAdministrativeArea},${pMark.administrativeArea} ${pMark.postalCode},${pMark.country}';
    __locationController.text = fullAddress;
    __flatNumber.text =
        '${pMark.thoroughfare} ${pMark.subThoroughfare}, ${pMark.subLocality} ${pMark.locality}';
    __city.text =
        '${pMark.subAdministrativeArea} ,${pMark.administrativeArea} ${pMark.postalCode}';
    __state.text = '${pMark.country}';
    __completeAddress.text = fullAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "IFood",),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // save address info
          if (formKey.currentState!.validate()) {
            final model = Address(
              name: __name.text.trim(),
              phoneNumber: __phoneNumber.text.trim(),
              flatNumber: __flatNumber.text.trim(),
              city: __city.text.trim(),
              state: __state.text.trim(),
              fullAddress: __completeAddress.text.trim(),
              lat: position!.latitude,
              lng: position!.longitude,
            ).tojson();

            FirebaseFirestore.instance
                .collection("users")
                .doc(sharedpreferences!.getString("uid"))
                .collection("userAddress")
                .doc(DateTime.now().microsecondsSinceEpoch.toString())
                .set(model)
                .then((value) {});
            Fluttertoast.showToast(msg: "New Address has been saved.");
            formKey.currentState!.reset();
          }
        },
        label: const Text(
          "Save Now",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 6),
            const Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Save New Address:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_pin_circle,
                color: Colors.black,
                size: 30,
              ),
              title: SizedBox(
                width: 250,
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: __locationController,
                  decoration: const InputDecoration(
                    hintText: "What's your address?",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            ElevatedButton.icon(
              onPressed: () {
                //get current location with address
                getUserLocationAddress();
              },
              icon: const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              label: const Text(
                "Get My Location",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.cyan),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  MyTextField(
                    hint: "Name",
                    controller: __name,
                  ),
                  MyTextField(
                    hint: "Phone Number",
                    controller: __phoneNumber,
                  ),
                  MyTextField(
                    hint: "City",
                    controller: __city,
                  ),
                  MyTextField(
                    hint: "State/Country",
                    controller: __state,
                  ),
                  MyTextField(
                    hint: "Address Line",
                    controller: __flatNumber,
                  ),
                  MyTextField(
                    hint: "Complete Address",
                    controller: __completeAddress,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
