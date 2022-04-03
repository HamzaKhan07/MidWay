import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteHelper {
  Future getCoordinates(startLat, startLong, endLat, endLong) async {
    try {
      var url = Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key='YOUR API KEY'&start=$startLong,$startLat&end=$endLong,$endLat');
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
