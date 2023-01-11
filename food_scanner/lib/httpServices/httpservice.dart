import 'dart:developer';
import 'package:food_scanner/screens/home_page.dart';
import 'package:g_json/g_json.dart';
import 'package:http/http.dart';
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
  static const _apiKey = '1c48709454mshf63ea384742c69fp1b8ef2jsnaf56c74540da';

  Bayut._();


  static Future<Map<String, dynamic>?> _restGetRandomRecipe_Fake() async {
    var result = await HttpReqService.get<JMap>(
        'https://mocki.io/v1/a8148701-3c63-4665-a4dc-190af750b05a',);
    return result;
  }

  static Future<Map<String, dynamic>?> _restGetRandomRecipe() async {
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

  static Future<Map<String, dynamic>?> _restSearchRecipe(String query) async {
    var result = await HttpReqService.get<JMap>(
        '$_url/recipes/complexSearch?query=$query',
        auth: AuthType.apiKey,
        authData: MapEntry('X-RapidAPI-Key', _apiKey),
        headers: {
          'X-RapidAPI-Host':
              'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
        });
    return result;
  }

  static Future<String> _restRecipebyId(int id) async {
    final response = await get(
        Uri.parse(
            "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/$id/information"),
        headers: {
          "x-rapidapi-key":
              "1c48709454mshf63ea384742c69fp1b8ef2jsnaf56c74540da",
          "x-rapidapi-host":
              "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        });
    var status = response.statusCode;

    final responseJson = jsonDecode(response.body);
    print(responseJson);
    print(response.body);

    if (response.statusCode != 200) {
    } else {
      return response.body;
    }
    return "";
  }
  //------------------------------------------------|SEARCH WITH CAMERA|-----------------------------------------------------------------------
  static Future<String> getcamAPI(String path) async {
  // "/data/user/0/edu.ufp.flutter.food_scanner/cache/CAP1661843087946890547.jpg"
    // Your RapidAPI endpoint URL
    final String endpoint = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/images/analyze';

// Your RapidAPI headers
    final Map<String, String> headers = {
    'X-RapidAPI-Key': '1c48709454mshf63ea384742c69fp1b8ef2jsnaf56c74540da',
    };
// Your file to be included in the request body
   // final File file = File(path);
    final File file = File("/data/user/0/edu.ufp.flutter.food_scanner/cache/CAP1661843087946890547.jpg");
// Create a MultipartRequest
    final request = http.MultipartRequest('POST', Uri.parse(endpoint));

// Set the headers for the request
    request.headers.addAll(headers);

// Add the file to the request body
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

// Send the request and handle the response
    final response = await request.send();
    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);
    //log(responseString);
    return responseString;
  }

  static Future<Map<String, dynamic>?>getFAKEcamAPI(String path) async {
      var result = await HttpReqService.get<JMap>(
        'https://mocki.io/v1/dfb854ec-eb99-470f-9bfa-b593208703e0',);
      return result;
    }

  static Future<List<Recipe>> getScanedRecepies(String path) async {
    log("ENtei aqui");
    List<int> recipesIds = [];
    List<Recipe> returnrecipes = [];
    //var result = await Bayut.getcamAPI(path);
    var result = await Bayut.getFAKEcamAPI(path);
    List<dynamic> list = result?.entries.elementAt(3).value;

    if(list!=null){
      for(int index=0; index<list.length; index++){
        var recipe= list.elementAt(index);
        String jsonencode = jsonEncode(recipe);
        final mode = JSON.parse(jsonencode);
        recipesIds.add(int.parse(mode["id"].toString()));
        var resultRecipe = await Bayut.getRecipeById(int.parse(mode["id"].toString()));
        returnrecipes.add(resultRecipe);
      }
    }
    log(returnrecipes.toString());
    return returnrecipes;
  }



  //------------------------------------------------||--------------------------

  static Future<List<Recipe>> getrecepies() async {
    List<Recipe> returnrecipes = [];

    for (int i = 0; i < numcards; i++) {
      //var result = await Bayut._restGetRandomRecipe();
      var result = await Bayut._restGetRandomRecipe_Fake();

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
        mode[0]["id"].integerValue,
        mode[0]["title"].stringValue,
        mode[0]["image"].stringValue,
        mode[0]["sourceUrl"].stringValue,
        mode[0]["summary"].stringValue,
        mode[0]["instructions"].stringValue,
        mode[0]["sourceName"].stringValue,
        int.parse(mode[0]["servings"].toString()),
        int.parse(mode[0]["healthScore"].toString()),
        int.parse(mode[0]["readyInMinutes"].toString()),
       // vegetarian,
       // vegan,
      );
      print(auxrecipe.toString());
      returnrecipes.add(auxrecipe);
    }
    print(returnrecipes);
    return returnrecipes;
  }

  static Future<List<Recipe>> getSearchRecipes(String string) async {
    List<int> recipesIds = [];
    List<Recipe> returnrecipes = [];
    var result = await Bayut._restSearchRecipe(string);
    List<dynamic> list = result?.entries.elementAt(0).value;

    if(list!=null){
      for(int index=0; index<list.length; index++){
        var recipe= list.elementAt(index);
        String jsonencode = jsonEncode(recipe);
        final mode = JSON.parse(jsonencode);
        recipesIds.add(int.parse(mode["id"].toString()));
        var resultRecipe = await Bayut.getRecipeById(int.parse(mode["id"].toString()));
        returnrecipes.add(resultRecipe);
      }
    }
    return returnrecipes;
  }

  static Future<Recipe> getRecipeById(int id) async {
    List<Recipe> returnrecipes = [];
    var result = await Bayut._restRecipebyId(id);

    print(result);

    //List<dynamic> list = result?.entries.elementAt(0).value;
    // String list2 = jsonEncode(result);
    // 0x01 parse json string to object
    final mode = JSON.parse(result);

    bool vegetarian = toBoolean(mode["vegetarian"].toString());
    bool vegan = toBoolean(mode["vegan"].toString());

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
    Recipe recipe = Recipe(
      mode[0]["id"].integerValue,
      mode["title"].stringValue,
      mode["image"].stringValue,
      mode["sourceUrl"].stringValue,
      mode["summary"].stringValue,
      mode["instructions"].stringValue,
      mode["sourceName"].stringValue,
      int.parse(mode["servings"].toString()),
      int.parse(mode["healthScore"].toString()),
      int.parse(mode["readyInMinutes"].toString()),
     // vegetarian,
     // vegan,
    );
    print(recipe.toString());
    print(recipe.image);

    return recipe;
  }
}

bool toBoolean(String str, [bool strict = false]) {
  if (strict == true) {
    return str == '1' || str == 'true';
  }
  return str != '0' && str != 'false' && str != '';
}

void main(List<String> args) async {
  print("teste");
  //var resultbyid = await Bayut.getRecipeById(1092983);
  //var result = await Bayut.getSearchRecipes("cheesecake");
  //var result = await Bayut.getcamAPI("");
  var result = await Bayut.getScanedRecepies("");
}

void testingcrl() async {
  final response = await get(
      Uri.parse(
          "https://instagram-data1.p.rapidapi.com/user/info/?username=samuel_mota_"),
      headers: {
        "x-rapidapi-key": "07ad1250b6msh6d028fc8946e7d2p15b3cfjsn5c7dcfe409ab",
        "x-rapidapi-host": "instagram-data1.p.rapidapi.com",
      });
  var status = response.statusCode;
  final responseJson = jsonDecode(response.body);
  if (response.statusCode != 200) {
  } else {
    print(response.body);
  }
}

void testingcrl2(int id) async {
  final response = await get(
      Uri.parse(
          "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/$id/information"),
      headers: {
        "x-rapidapi-key": "07ad1250b6msh6d028fc8946e7d2p15b3cfjsn5c7dcfe409ab",
        "x-rapidapi-host":
            "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      });
  var status = response.statusCode;
  final responseJson = jsonDecode(response.body);
  if (response.statusCode != 200) {
  } else {
    print(response.body);
  }
}
