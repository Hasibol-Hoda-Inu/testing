import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData.dark(),
      home: RecipeScreen(),
    );
  }
}

class RecipeScreen extends StatefulWidget {
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final json =
    '''{"recipes":[{"title":"Pasta Carbonara","description":"Creamy pasta dish with bacon and cheese.","ingredients":["spaghetti","bacon","egg","cheese"]},{"title":"Caprese Salad","description":"Simple and refreshing salad with tomatoes, mozzarella, and basil.","ingredients":["tomatoes","mozzarella","basil"]},{"title":"Banana Smoothie","description":"Healthy and creamy smoothie with bananas and milk.","ingredients":["bananas","milk"]},{"title":"Chicken Stir-Fry","description":"Quick and flavorful stir-fried chicken with vegetables.","ingredients":["chicken breast","broccoli","carrot","soy sauce"]},{"title":"Grilled Salmon","description":"Delicious grilled salmon with lemon and herbs.","ingredients":["salmon fillet","lemon","olive oil","dill"]},{"title":"Vegetable Curry","description":"Spicy and aromatic vegetable curry.","ingredients":["mixed vegetables","coconut milk","curry powder"]},{"title":"Berry Parfait","description":"Layered dessert with fresh berries and yogurt.","ingredients":["berries","yogurt","granola"]}]}''';
    final decodedJson = jsonDecode(json);

    List<Recipe> fetchedRecipes = [];
    for (var recipeJson in decodedJson['recipes']) {
      Recipe recipe = Recipe.fromJson(recipeJson);
      fetchedRecipes.add(recipe);
    }

    setState(() {
      recipes = fetchedRecipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.food_bank),
            title: Text(recipes[index].title),
          );
        },
      ),
    );
  }
}

class Recipe {
  final String title;
  final String description;
  final List<String> ingredients;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }
}
