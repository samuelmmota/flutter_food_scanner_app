import 'dart:developer';
import 'dart:math';
import 'package:food_scanner/screens/home_page.dart';
import 'package:g_json/g_json.dart';
import 'package:wnetworking/wnetworking.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_scanner/models/recipeDataModel.dart';
import 'dart:io';

class Bayut {
  static final int numcards = 4;
  static const _url =
      'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';
  static const _apiKey = '07ad1250b6msh6d028fc8946e7d2p15b3cfjsn5c7dcfe409ab';

  Bayut._();

  static Future<Map<String, dynamic>?> getPropertiesDetail() async {
    var result = await HttpReqService.get<JMap>(
        '$_url/recipes/random?tags=vegetarian%2Cdessert&number=1',
        auth: AuthType.apiKey,
        authData: MapEntry('X-RapidAPI-Key', _apiKey),
        headers: {
          'X-RapidAPI-Host':
              'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
        });
    return result;
  }

  static Future<List<Recipe>> getRESTrecepies() async {
    List<Recipe> returnrecipes = [];

    for (int i = 0; i < numcards; i++) {
      var result = await Bayut.getPropertiesDetail();

      List<dynamic> list = result?.entries.elementAt(0).value;
      String list2 = jsonEncode(list);
      // 0x01 parse json string to object
      final mode = JSON.parse(list2);

      //final _id = mode['_id'].stringValue;
      //final secondFriend = mode[['friends', 2]]['name'].stringValue;

      //print(mode.prettyString());
      //debugPrint(mode.prettyString());
      //debugPrint(mode[0]["sourceUrl"].stringValue);
      bool vegetarian = toBoolean(mode[0]["vegetarian"].toString());
      bool vegan = toBoolean(mode[0]["vegan"].toString());

/**Recipe(
    this.title,
    this.image,
    this.sourceUrl,
    this.summary,
    this.instructions,
    this.sourceName,
    this.servings,
    this.healthScore,
    this.readyInMinutes,
    this.vegetarian,
    this.vegan,
  ); */
      Recipe auxrecipe = Recipe(
        mode[0]["title"].stringValue,
        mode[0]["image"].stringValue,
        mode[0]["sourceUrl"].stringValue,
        mode[0]["summary"].stringValue,
        mode[0]["instructions"].stringValue,
        mode[0]["sourceName"].stringValue,
        int.parse(mode[0]["servings"].toString()),
        int.parse(mode[0]["healthScore"].toString()),
        int.parse(mode[0]["readyInMinutes"].toString()),
        vegetarian,
        vegan,
      );
      print(auxrecipe.toString());
      returnrecipes.add(auxrecipe);
    }
    print(returnrecipes);
    return returnrecipes;
  }
}

bool toBoolean(String str, [bool strict = false]) {
  if (strict == true) {
    return str == '1' || str == 'true';
  }
  return str != '0' && str != 'false' && str != '';
}

void main(List<String> args) async {
  var result = await Bayut.getPropertiesDetail();

  List<dynamic> list = result?.entries.elementAt(0).value;
  String list2 = jsonEncode(list);
  // 0x01 parse json string to object
  final mode = JSON.parse(list2);
  //final _id = mode['_id'].stringValue;
  //final secondFriend = mode[['friends', 2]]['name'].stringValue;

  //print(mode.prettyString());
  //debugPrint(mode.prettyString());
  debugPrint(mode[0]["sourceUrl"].stringValue);
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
