import 'package:flutter/material.dart';
import 'package:my_food_users_app/models/items.dart';

class CartitemDesign extends StatefulWidget {
  const CartitemDesign({
    super.key,
    this.model,
    this.context,
    this.quantNumber,
  });

  final Items? model;
  final BuildContext? context;
  final int? quantNumber;

  @override
  State<CartitemDesign> createState() => _CartitemDesignState();
}

class _CartitemDesignState extends State<CartitemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(
                widget.model!.thumnbnailURL!,
                width: 140,
                height: 120,
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.model!.title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "KiwiMaru",
                    ),
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      const Text(
                        "x ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Acme",
                        ),
                      ),
                      Text(
                        widget.quantNumber.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Acme",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Price: ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        "₹ ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.model!.price.toString(),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
