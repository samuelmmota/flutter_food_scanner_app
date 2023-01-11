import 'package:json_annotation/json_annotation.dart';
part 'recipeDataModel.g.dart';

//import 'recipeDataModel.g.dart';
@JsonSerializable()
class Recipe {
  int id;
  String title;
  String image;
  String sourceUrl;
  String summary;
  String instructions;
  String sourceName;
  int servings;
  int healthScore;
  int readyInMinutes;
 // bool vegetarian;
  //bool vegan;


  Recipe(
    this.id,
    this.title,
    this.image,
    this.sourceUrl,
    this.summary,
    this.instructions,
    this.sourceName,
    this.servings,
    this.healthScore,
    this.readyInMinutes,
    //this.vegetarian,
    //this.vegan,
  );
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'image': image,
    'sourceUrl': sourceUrl,
    'summary': summary,
    'instructions': instructions,
    'sourceName': sourceName,
    'servings': servings,
    'healthScore': healthScore,
    'readyInMinutes': readyInMinutes,
    //'vegetarian': vegetarian,
   // 'vegan': vegan,
};
}

/**
 * class Recipe {
  bool vegetarian;
  bool vegan;
  int readyInMinutes;
  String sourceName;
  String summary;
  String sourceUrl;
  String image;
  String title;
  int servings;
  int healthScore;
  String instructions;
  Recipe(
    this.vegetarian,
    this.vegan,
    this.readyInMinutes,
    this.sourceName,
    this.summary,
    this.sourceUrl,
    this.image,
    this.tittle,
    this.servings,
    this.healthScore,
    this.instructions,
  );
}

 */