import 'package:flutter/material.dart';
import '../main.dart';
import 'package:food_scanner/cards/fill_image_card.dart';
import 'package:food_scanner/httpServices/httpservice.dart';
import 'package:food_scanner/models/recipeDataModel.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetail(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TyperAnimatedTextKit(
          text: [this.recipe.sourceName],
          textStyle: TextStyle(fontSize: 20.0, fontFamily: "Bobbers"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _titulo(this.recipe.title),
            Image.network(this.recipe.image.toString()),
            _popUPrecepiInfos(
              this.recipe.healthScore,
              this.recipe.servings,
              this.recipe.readyInMinutes,
            ),
            _bold("Resumo"),
            _texto(this.recipe.summary),
            _bold("Instruções"),
            _texto(this.recipe.instructions),
            SizedBox(
              height: 60,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 2, 20, 156),
                  padding: const EdgeInsets.all(12.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  _launchURL(this.recipe.sourceUrl);
                },
                child: const Text('Open in Browser'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _texto(String textoHTML) {
  var doc = parse(textoHTML);
  String parsedstring;
  if (doc.documentElement != null) {
    parsedstring = doc.documentElement!.text;
    print(parsedstring);
  } else {
    return Text("NUll");
  }
  return Text(
    parsedstring,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: "Agne",
      fontSize: 14.0,
      wordSpacing: 2.0,
      height: 1.1,
    ),
    maxLines: 30, // you can freely use any value here\
  );
}

Widget _titulo(String titulo) {
  return Text(
    titulo,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.w600,
      fontFamily: "Horizon",
      fontSize: 30.0,
      wordSpacing: 3.0,
      height: 1.1,
    ),
    maxLines: 5, // you can freely use any value here\
  );
}

Widget _bold(String text) {
  return SizedBox(
      height: 40,
      child: Text(
        '$text:',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromARGB(255, 142, 26, 224),
          fontWeight: FontWeight.w600,
          fontFamily: "Horizon",
          fontSize: 30.0,
          letterSpacing: 1.5,
          wordSpacing: 3.0,
          height: 1.1,
        ),
      ));
}

Widget _popUPrecepiInfos(int healthScore, int servings, int readyInMinutes) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      SizedBox(width: 20.0, height: 100.0),
      RotateAnimatedTextKit(
        text: [
          "HealthScore: $healthScore ",
          "Nº of Servings: $servings ",
          "Ready in $readyInMinutes min!"
        ],
        textStyle: TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
      ),
    ],
  );
}

_launchURL(String sourceUrl) async {
  final Uri uri = Uri.parse(sourceUrl);
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $sourceUrl';
  }
}

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