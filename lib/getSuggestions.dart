import 'package:http/http.dart' as http;
import 'dart:convert';

class GetSuggestions {
  List data = [];
  Future<Iterable> getSuggest(pattern, lat, long) async {
    var url = Uri.parse(
        'https://autosuggest.search.hereapi.com/v1/autosuggest?at=$lat,$long&limit=5&lang=en&q=$pattern&apiKey='YOUR API KEY'');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      data = (json.decode(response.body)['items']);
      return data;
    } else {
      print('Error in GetSuggestions with ${response.statusCode}');
      return data;
    }
  }
}
