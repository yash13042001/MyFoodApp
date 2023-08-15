import 'package:flutter/material.dart';
import 'package:my_food_users_app/main_screens/item_details_screen.dart';
import 'package:my_food_users_app/models/items.dart';

class ItemsDesign extends StatefulWidget {
  const ItemsDesign({super.key, required this.context, required this.model});
  final Items? model;
  final BuildContext? context;

  @override
  State<ItemsDesign> createState() => _ItemsDesignState();
}

class _ItemsDesignState extends State<ItemsDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailsScreen(model: widget.model),
          ),
        );
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 285,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.thumnbnailURL!,
                height: 220.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1),
              Text(
                widget.model!.title!,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                  fontFamily: "TrainOne",
                ),
              ),
              Text(
                widget.model!.shortInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: "TrainOne",
                ),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
