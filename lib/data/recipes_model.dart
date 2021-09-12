import 'dart:convert';

import 'links.dart';
import 'recipe.dart';

class RecipesModel {
  final Recipe recipe;
  final Links links;
  RecipesModel({
    required this.recipe,
    required this.links,
  });

  RecipesModel copyWith({
    Recipe? recipe,
    Links? links,
  }) {
    return RecipesModel(
      recipe: recipe ?? this.recipe,
      links: links ?? this.links,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recipe': recipe.toMap(),
      'links': links.toMap(),
    };
  }

  factory RecipesModel.fromMap(Map<String, dynamic> map) {
    return RecipesModel(
      recipe: Recipe.fromMap(map['recipe']),
      links: Links.fromMap(map['_links']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipesModel.fromJson(String source) =>
      RecipesModel.fromMap(json.decode(source));

  @override
  String toString() => 'RecipesModel(recipe: $recipe, links: $links)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipesModel &&
        other.recipe == recipe &&
        other.links == links;
  }

  @override
  int get hashCode => recipe.hashCode ^ links.hashCode;
}
