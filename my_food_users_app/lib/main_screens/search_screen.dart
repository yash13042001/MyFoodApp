import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_food_users_app/models/sellers.dart';
import 'package:my_food_users_app/widgets/sellers_design.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot>? restaurantDocumentsList;
  String sellerNameText = "";

  initSearchingRestaurant(String textEntered) {
    restaurantDocumentsList = FirebaseFirestore.instance
        .collection("sellers")
        .where("sellername", isGreaterThanOrEqualTo: textEntered)
        .get();
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
        title: TextField(
          onChanged: (textentered) {
            setState(() {
              sellerNameText = textentered;
            });
            initSearchingRestaurant(textentered);
          },
          decoration: InputDecoration(
            hintText: "Search Restaurant...",
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                initSearchingRestaurant(sellerNameText);
              },
              color: Colors.white,
              icon: const Icon(Icons.search),
            ),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: FutureBuilder(
        future: restaurantDocumentsList,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Sellers model = Sellers.fromJson(snapshot.data!.docs[index]
                        .data()! as Map<String, dynamic>);

                    return SellersDesign(
                      context: context,
                      model: model,
                    );
                  },
                )
              : const Center(
                  child: Text("No Records Found"),
                );
        },
      ),
    );
  }
}
