import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static void launchMapFromSourceToDestination(
      sourceLat, sourceLng, destinationLAt, destinationLng) async {
    String mapOptions = [
      'saddr=$sourceLat,$sourceLng',
      'daddr=$destinationLAt,$destinationLng',
      'dir_action=navigate'
    ].join('&');

    final mapUrl = 'https://www.google.com/maps?$mapOptions';

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw "Could not launch $mapUrl";
    }
  }
}
