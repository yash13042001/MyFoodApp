import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_food_users_app/assistantMethods/assistant_methods.dart';
import 'package:my_food_users_app/models/menus.dart';
import 'package:my_food_users_app/models/sellers.dart';
import 'package:my_food_users_app/splash_screen/splash_screen.dart';
import 'package:my_food_users_app/widgets/menus_design.dart';
import 'package:my_food_users_app/widgets/progress_bar.dart';
import 'package:my_food_users_app/widgets/text_widget_header.dart';

class MenusScreen extends StatefulWidget {
  const MenusScreen({super.key, this.model});

  final Sellers? model;

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
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
        leading: IconButton(
          onPressed: () {
            clearCartNow(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const SplashScreen(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "IFood",
          style: TextStyle(
            color: Colors.white,
            fontSize: 45,
            fontFamily: "Signatra",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextWidgetHeader(
                title: "${widget.model!.sellername.toString()} Menus"),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellersUID)
                .collection("menus")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(child: circularProgress()),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Menus model = Menus.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);
                        return Menusdesign(context: context, model: model);
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
            },
          ),
        ],
      ),
    );
  }
}
