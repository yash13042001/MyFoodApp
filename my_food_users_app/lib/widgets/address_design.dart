import 'package:flutter/material.dart';
import 'package:my_food_users_app/assistantMethods/address_changer.dart';
import 'package:my_food_users_app/main_screens/placed_order_screen.dart';
import 'package:my_food_users_app/maps/maps.dart';
import 'package:my_food_users_app/models/address.dart';
import 'package:provider/provider.dart';

class AddressDesign extends StatefulWidget {
  const AddressDesign({
    super.key,
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  });

  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<AddressChanger>(context, listen: false)
            .displayResult(widget.value);
      },
      child: Card(
        color: Colors.cyan.withOpacity(0.4),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: widget.value!,
                  groupValue: widget.currentIndex!,
                  activeColor: Colors.amber,
                  onChanged: (value) {
                    Provider.of<AddressChanger>(context, listen: false)
                        .displayResult(value);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.model!.name.toString())
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Phone Number: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.model!.phoneNumber.toString())
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Flat Number: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.model!.flatNumber.toString())
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "City: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.model!.city.toString())
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "State: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.model!.state.toString())
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Full Address: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.model!.fullAddress.toString())
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                MapUtils.openMapWithPosition(
                    widget.model!.lat!, widget.model!.lng!);
                // MapUtils.openMapWithAddress(widget.model!.fullAddress!);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
              ),
              child: const Text(
                "Check on Maps",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            widget.value == Provider.of<AddressChanger>(context).count
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => PlacedOrderScreen(
                            addressID: widget.addressID,
                            totalAmount: widget.totalAmount,
                            sellerUID: widget.sellerUID,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Proceed"),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
