import 'package:flutter/material.dart';

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
      home: SearchRecipePage(),
    );
  }
}

class SearchRecipePage extends StatefulWidget {
  SearchRecipePage({super.key});

  @override
  _MyHomePageState2 createState() => new _MyHomePageState2();
}

class _MyHomePageState2 extends State<SearchRecipePage> {
  TextEditingController searchController = new TextEditingController();
  TextEditingController editingController = TextEditingController();
  final controller = ScrollController();
  bool isLoading = false;
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = <String>[];
  List<Recipe> itemCards = [];

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void SearchResults(String query) async {
    if (query.isNotEmpty) {
      //var searchList = Bayut.getSearchRecipes(query);
      Bayut.getSearchRecipes(query).then((List<Recipe> result) {
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
        title: new Text("Search Recipes"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: /*TextField(
                onChanged: (value) {
                  SearchResults(value);
                },
                controller: editingController,
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),*/
              TextField(
                onChanged: (text) {
                  SearchResults(text);
                },
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search Recipes name',
                ),
              ),
            ),
            TextButton(
              onPressed: (

                  ) {
                print("this is the text to search for => ${searchController.text}");
              },
              child: Text("Search"),
            ),
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
