import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_food_admin_web_portal/main_screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String adminEmail = "";
  String adminPassword = "";

  allowAdminToLogin() async {
    SnackBar snackBar = const SnackBar(
      content: Text(
        "Checking Credentials, Please Wait...",
        style: TextStyle(fontSize: 30, color: Colors.black),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      duration: Duration(seconds: 6),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    User? currentAdmin;

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: adminEmail,
      password: adminPassword,
    )
        .then((fAuth) {
      currentAdmin = fAuth.user;
    }).catchError((onError) {
      //Display error message
      final snackBar = SnackBar(
        content: Text(
          "Error Occured ${onError.toString()}",
          style: const TextStyle(fontSize: 30, color: Colors.black),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if (currentAdmin != null) {
      //check if that admin record also exists in the admin collection in firestore database
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get()
          .then((snap) {
        if (snap.exists) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          SnackBar snackBar = const SnackBar(
            content: Text(
              "No record found, you are not a admin",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            backgroundColor: Colors.deepPurpleAccent,
            duration: Duration(seconds: 6),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Image

                  Image.asset("images/admin.png"),

                  //Email Text Field

                  TextField(
                    onChanged: (value) {
                      adminEmail = value;
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 2,
                        ),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.email, color: Colors.deepPurpleAccent),
                    ),
                  ),

                  const SizedBox(height: 10),

                  //Password Text Field

                  TextField(
                    onChanged: (value) {
                      adminPassword = value;
                    },
                    obscureText: true,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pinkAccent,
                          width: 2,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(
                        Icons.admin_panel_settings,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      allowAdminToLogin();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 30,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.pinkAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
