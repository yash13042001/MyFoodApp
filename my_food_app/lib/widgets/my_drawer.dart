import 'package:flutter/material.dart';
import 'package:my_food_app/authentication/auth_screen.dart';
import 'package:my_food_app/global/global.dart';
import 'package:my_food_app/main_screens/earnings_screen.dart';
import 'package:my_food_app/main_screens/history_screen.dart';
import 'package:my_food_app/main_screens/home_screen.dart';
import 'package:my_food_app/main_screens/new_orders_screen.dart';

class MYDrawer extends StatelessWidget {
  const MYDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 10,
            ),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SizedBox(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedpreferences!.getString("photoURL")!,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  sharedpreferences!.getString("name")!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "TrainOne"),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.black,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const HomeScreen(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.black,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.monetization_on,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "My Earnings",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const EarningsScreen(),
                          ),
                        );
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.black,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "New Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const NewOrdersScreen(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.black,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.local_shipping,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "History-Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const HistoryScreen(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.black,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then(
                      (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const AuthScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.black,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
