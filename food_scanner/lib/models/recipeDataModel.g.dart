// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipeDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      json['id'] as int,
      json['title'] as String,
      json['image'] as String,
      json['sourceUrl'] as String,
      json['summary'] as String,
      json['instructions'] as String,
      json['sourceName'] as String,
      json['servings'] as int,
      json['healthScore'] as int,
      json['readyInMinutes'] as int,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'sourceUrl': instance.sourceUrl,
      'summary': instance.summary,
      'instructions': instance.instructions,
      'sourceName': instance.sourceName,
      'servings': instance.servings,
      'healthScore': instance.healthScore,
      'readyInMinutes': instance.readyInMinutes,
    };
