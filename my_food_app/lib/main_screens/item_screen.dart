import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_food_app/global/global.dart';
import 'package:my_food_app/models/items.dart';
import 'package:my_food_app/models/menus.dart';
import 'package:my_food_app/upload_screen/items_upload_screen.dart';
import 'package:my_food_app/widgets/items_design.dart';
import 'package:my_food_app/widgets/my_drawer.dart';
import 'package:my_food_app/widgets/progress_bar.dart';
import 'package:my_food_app/widgets/text_widget_header.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key, this.model});

  final Menus? model;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
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
          sharedpreferences!.getString("name")!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => ItemsUploadScreen(model: widget.model),
                ),
              );
            },
            icon: const Icon(
              Icons.library_add,
              color: Colors.cyan,
            ),
          ),
        ],
      ),
      drawer: const MYDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: TextWidgetHeader(
                title: "My ${widget.model!.menuTitle.toString()}'s Items"),
            pinned: true,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedpreferences!.getString("uid"))
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items")
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
                        Items model = Items.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);
                        return ItemsDesign(context: context, model: model);
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
