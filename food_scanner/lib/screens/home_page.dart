import 'package:flutter/material.dart';
import '../main.dart';
import 'package:food_scanner/cards/fill_image_card.dart';
import 'package:food_scanner/httpServices/httpservice.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:food_scanner/models/recipeDataModel.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

final Recipe staticRecipe = Recipe(
  "Fresh Apple Cake With Caramel Sauce",
  "https://spoonacular.com/recipeImages/643426-556x370.jpg",
  "https://www.foodista.com/recipe/DBJYD6L8/fresh-apple-cake-with-caramel-sauce",
  "If you want to add more <b>lacto ovo vegetarian</b> recipes to your recipe box, Fresh Apple Cake With Caramel Sauce might be a recipe you should try. For <b>11.58 per serving</b>, this recipe <b>covers 77%</b> of your daily requirements of vitamins and minerals. One serving contains <b>8596 calories</b>, <b>79g of protein</b>, and <b>456g of fat</b>. This recipe serves 1. Only a few people made this recipe, and 9 would say it hit the spot. It works well as a pricey dessert. If you have coconut, cinnamon, brown sugar, and a few other ingredients on hand, you can make it. It is brought to you by Foodista. From preparation to the plate, this recipe takes around <b>around 45 minutes</b>. Taking all factors into account, this recipe <b>earns a spoonacular score of 90%</b>, which is spectacular. If you like this recipe, take a look at these similar recipes: <a href=\"https://spoonacular.com/recipes/fresh-apple-cake-with-caramel-sauce-418753\">Fresh Apple Cake with Caramel Sauce</a>, <a href=\"https:",
  "No instructions",
  "Foodista",
  2,
  30,
  100,
  true,
  false,
);

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  bool isLoading = false;
  List<Recipe> itemCards = [];

  Widget build(BuildContext context) => Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text(
            "Home Page",
          ),
        ),
        body: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
      );

  @override
  void initState() {
    super.initState();
    fetch();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
/**
 * Get more 10 recepies
 */

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;
    debugPrint('Fetching ${Bayut.numcards} cards!');
    /*** Receita Template OFFline */
    //List<Recipe> newitemCards =
    //  List.generate(Bayut.numcards, (index) => staticRecipe);
    /*** Receitas From Rapid API */
    //
    List<Recipe> newitemCards = await Bayut.getRESTrecepies();

    setState(() {
      /*
      itemCards.addAll([
        newitemCards[0],
        newitemCards[1],
        newitemCards[2],
        newitemCards[3],
        newitemCards[4],
        newitemCards[5],
        newitemCards[6],
        newitemCards[7],
        newitemCards[8],
        newitemCards[9],
      ]);
      */
      for (int i = 0; i < Bayut.numcards; i++) itemCards.add(newitemCards[i]);
      isLoading = false;
    });
  }
}
