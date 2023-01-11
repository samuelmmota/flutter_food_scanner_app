import 'dart:io';
import 'package:flutter/material.dart';
import '../cards/fill_image_card.dart';
import '../main.dart';
import '../models/recipeDataModel.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:json_annotation/json_annotation.dart';

class FavoriteRecipesPage extends StatefulWidget {
  @override
  _FavoriteRecipesPageState createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
  List<Recipe> _favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    final db = await sql.openDatabase(
      path.join(await sql.getDatabasesPath(), 'favorites.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> maps = await db.query('recipes');
    setState(() {
      _favoriteRecipes = maps.map((map) => Recipe.fromJson(map)).toList();
    });

    await db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: Text('Favorite Recipes'),
      ),
      body: _favoriteRecipes == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _favoriteRecipes.isEmpty
              ? const Center(
                  child: Text('No favorite recipes'),
                )
              : ListView.builder(
                  itemCount: _favoriteRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = _favoriteRecipes[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 30),
                        createcard(context, recipe),
                      ],
                    );
                  },
                ),
    );
  }
}
