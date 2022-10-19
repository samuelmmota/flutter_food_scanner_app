import 'package:wnetworking/wnetworking.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Bayut {
  static const _url =
      'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';
  static const _apiKey = '07ad1250b6msh6d028fc8946e7d2p15b3cfjsn5c7dcfe409ab';

  Bayut._();

  static Future<Map<String, dynamic>?> getPropertiesDetail() async {
    var result = await HttpReqService.get<JMap>(
        '$_url/recipes/random?tags=vegetarian%2Cdessert&number=10',
        auth: AuthType.apiKey,
        authData: MapEntry('X-RapidAPI-Key', _apiKey),
        headers: {
          'X-RapidAPI-Host':
              'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
        });
    return result;
  }
}

void main(List<String> args) async {
  //var result = await Bayut.getPropertiesDetail();
  //print(result);
  print(APIService().get());

  print('\nJob done!');
}

class APIService {
  // API key
  // Base API url
  static const String _baseUrl =
      "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com";
  // Base headers for Response url
  static const Map<String, String> _headers = {
    "x-rapidapi-key": "07ad1250b6msh6d028fc8946e7d2p15b3cfjsn5c7dcfe409ab",
    "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
  };

  // Base API request to get response
  Future<dynamic> get() async {
    Uri uri = Uri.https(
        _baseUrl, "/recipes/random?tags=vegetarian%2Cdessert&number=1");
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print("success");
      return json.decode(response.body);
    } else {
      print("not success");
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }
}
