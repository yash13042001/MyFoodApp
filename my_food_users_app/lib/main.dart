import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_food_users_app/assistantMethods/address_changer.dart';
import 'package:my_food_users_app/assistantMethods/cart_item_counter.dart';
import 'package:my_food_users_app/assistantMethods/total_amount.dart';
import 'package:my_food_users_app/global/global.dart';
import 'package:my_food_users_app/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (c) => CartItemCounter(),
        ),
        ChangeNotifierProvider(
          create: (c) => TotalAmount(),
        ),
        ChangeNotifierProvider(
          create: (c) => AddressChanger(),
        ),
      ],
      child: MaterialApp(
        title: 'Sellers App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
