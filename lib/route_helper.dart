import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteHelper {
  Future getCoordinates(startLat, startLong, endLat, endLong) async {
    try {
      var url = Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248387c410cb70a408aac8ced092bba2f3b&start=$startLong,$startLat&end=$endLong,$endLat');
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> lst = data["features"];

        Map<String, dynamic> real = lst[0]["geometry"];

        List<dynamic> fin = real["coordinates"];

        return fin;
      }
    } catch (e) {
      print("Exception occured in Network Helper");
      print(e.toString());
    }
  }
}
