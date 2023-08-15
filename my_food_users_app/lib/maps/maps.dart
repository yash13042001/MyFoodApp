import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMapWithPosition(double latitude, double longitude) async {
    String googleMapUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (await canLaunch(googleMapUrl)) { // Use canLaunch instead of canLaunchUrl
      await launch(googleMapUrl); // Use launch instead of launchUrl
    } else {
      throw "Could not open the map";
    }
}

  static Future<void> openMapWithAddress(String fullAddress) async {
    String query = Uri.encodeComponent(fullAddress);
    String googleMapUrl =
        "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleMapUrl)) {
      await launch(googleMapUrl);
    } else {
      throw "Could not open the map";
    }
  }
}
