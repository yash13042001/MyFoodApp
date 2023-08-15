import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedpreferences;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Position? position;
List<Placemark>? placemarks;
String completeAddress = "";
String perParcelDeliveryAmount = "";
String previousEarnings = ""; // It is seller previous earnings
String previousRiderEarnings = "";  // It is rider previous earnings
