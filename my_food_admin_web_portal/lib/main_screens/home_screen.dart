import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_food_admin_web_portal/authentication/login_screen.dart';
import 'package:my_food_admin_web_portal/riders/all_blocked_riders_screen.dart';
import 'package:my_food_admin_web_portal/riders/all_verified_riders_screen.dart';
import 'package:my_food_admin_web_portal/sellers/all_blocked_sellers_screen.dart';
import 'package:my_food_admin_web_portal/sellers/all_verified_sellers_screen.dart';
import 'package:my_food_admin_web_portal/users/all_blocked_users_screen.dart';
import 'package:my_food_admin_web_portal/users/all_verified_users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String timeText = "";
  String dateText = "";

  String formatCurrentLiveTime(DateTime time) {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date) {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime() {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if (mounted) {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //time
    timeText = formatCurrentLiveTime(DateTime.now());
    //date
    dateText = formatCurrentDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLiveTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.amber,
                Colors.cyan,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          "Admin Web Portal",
          style: TextStyle(fontSize: 20, letterSpacing: 3, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "$timeText\n$dateText",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // User activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Avtivate
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllVerifiedUsersScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  label: Text(
                    "All Verified Users\nAccounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    backgroundColor: Colors.amber,
                  ),
                ),
                const SizedBox(width: 20),
                //Block
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllBlockedUsersScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.block_flipped,
                    color: Colors.white,
                  ),
                  label: Text(
                    "All Blocked Users\nAccounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    backgroundColor: Colors.cyan,
                  ),
                ),
              ],
            ),
            // Seller activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Avtivate
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllVerifiedSellersScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  label: Text(
                    "All Verified Sellers\nAccounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    backgroundColor: Colors.cyan,
                  ),
                ),
                const SizedBox(width: 20),
                //Block
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllBlockedSellersScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.block_flipped,
                    color: Colors.white,
                  ),
                  label: Text(
                    "All Blocked Sellers\nAccounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    backgroundColor: Colors.amber,
                  ),
                ),
              ],
            ),
            // Rider activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Avtivate
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllVerifiedRidersScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  label: Text(
                    "All Verified Riders\nAccounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    backgroundColor: Colors.amber,
                  ),
                ),
                const SizedBox(width: 20),
                //Block
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllBlockedRidersScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.block_flipped,
                    color: Colors.white,
                  ),
                  label: Text(
                    "All Blocked Riders\nAccounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    backgroundColor: Colors.cyan,
                  ),
                ),
              ],
            ),
            // Logout
            ElevatedButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                "Logout".toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(40),
                backgroundColor: Colors.cyan,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
