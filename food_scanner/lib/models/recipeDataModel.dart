class Recipe {
  String title;
  String image;
  String sourceUrl;
  String summary;
  String instructions;
  String sourceName;
  int servings;
  int healthScore;
  int readyInMinutes;
  bool vegetarian;
  bool vegan;

  Recipe(
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
  );
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