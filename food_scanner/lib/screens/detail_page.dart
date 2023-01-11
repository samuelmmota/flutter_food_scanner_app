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
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:json_annotation/json_annotation.dart';
import 'dart:developer';
import '../models/recipeDataModel.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  RecipeDetail({required this.recipe});

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  void _toggleFavorite() async {
    final db = await sql.openDatabase(
      path.join(await sql.getDatabasesPath(), 'favorites.db'),
      onCreate: (db, version) {
        log('SQL-Favorites.db: Table recipes created');
        db.execute(
          //"CREATE TABLE recipes(id INT PRIMARY KEY, title TEXT)",
          "CREATE TABLE recipes(id INTEGER PRIMARY KEY, title TEXT, image TEXT, sourceUrl TEXT, summary TEXT, instructions TEXT, sourceName TEXT, servings INTEGER, healthScore INTEGER, readyInMinutes INTEGER);",
        );

        return ;
      },
      version: 1,
    );

    setState(() {
      _isFavorited = !_isFavorited;
    });

    if (_isFavorited) {
      await db.insert(
        'recipes',
        widget.recipe.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    } else {
      await db.delete(
        'recipes',
        where: "id = ?",
        whereArgs: [widget.recipe.id],
      );
    }

    await db.close();
  }

  void _loadFavoriteStatus() async {
    final db = await sql.openDatabase(
      path.join(await sql.getDatabasesPath(), 'favorites.db'),
      version: 1,
    );

    final count = await db.query(
      'recipes',
      where: "id = ?",
      whereArgs: [widget.recipe.id],
    );

    setState(() {
      _isFavorited =  true;
    });

    await db.close();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TyperAnimatedTextKit(
          text: [widget.recipe.sourceName],
          textStyle: TextStyle(fontSize: 20.0, fontFamily: "Bobbers"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _titulo(widget.recipe.title),
            Image.network(widget.recipe.image.toString()),
            ButtonBar(
              children: [
                IconButton(
                  icon: _isFavorited
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  color: _isFavorited ? Colors.red : null,
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
            _popUPrecepiInfos(
              widget.recipe.healthScore,
              widget.recipe.servings,
              widget.recipe.readyInMinutes,
            ),
            _bold("Resumo"),
            _texto(widget.recipe.summary),
            _bold("Instruções"),
            _texto(widget.recipe.instructions),
            SizedBox(
              height: 60,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 2, 20, 156),
                  padding: const EdgeInsets.all(12.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  _launchURL(widget.recipe.sourceUrl);
                },
                child: const Text('Open in Browser'),
              ),
            ),
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
