import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:food_scanner/screens/home_page.dart';
import 'package:food_scanner/screens/scan/similarRecipes_page.dart';
import 'package:food_scanner/screens/search/search_page.dart';

import '../../cards/fill_image_card.dart';
import '../../httpServices/httpservice.dart';
import '../../main.dart';
import '../../models/recipeDataModel.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchSiminarRecipesScreen(
        imagePath: '',
      ),
    );
  }
}

class SearchSiminarRecipesScreen extends StatefulWidget {
  SearchSiminarRecipesScreen({super.key, required String imagePath});

  @override
  _SearchSiminarRecipesScreen createState() =>
      new _SearchSiminarRecipesScreen(imagePath: "");
}

class _SearchSiminarRecipesScreen extends State<SearchSiminarRecipesScreen> {
  final String imagePath;

  _SearchSiminarRecipesScreen({required this.imagePath});

  final controller = ScrollController();
  bool isLoading = false;
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = <String>[];
  List<Recipe> itemCards = [];

  @override
  void initState() {
    items.addAll(duplicateItems);
    SearchCamaraResults("44");
    super.initState();
  }

  void SearchCamaraResults(String path) async {
    if (path.isNotEmpty) {
      //var searchList = Bayut.getSearchRecipes(query);
      Bayut.getScanedRecepies(path).then((List<Recipe> result) {
        setState(() {
          itemCards = result;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: new AppBar(
        title: new Text("Search Similar Recipes"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  controller: controller,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  itemCount: itemCards.length + 1,
                  itemBuilder: (context, index) {
                    if (index < itemCards.length) {
                      final Recipe item = itemCards[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 30),
                          createcard(context, item),
                        ],
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
