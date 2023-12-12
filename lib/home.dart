import "package:flutter/material.dart";
import "package:todoflutter/http/recipe.api.dart";
import "package:todoflutter/pages/home_page.dart";
import "package:todoflutter/pages/recipe.dart";
import "package:todoflutter/recipe_card.dart";

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()))
                  },
              icon: Icon(Icons.person)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Api Lista de Receitas'),
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      title: _recipes[index].name,
                      cookTime: _recipes[index].totalTime.toString(),
                      rating: _recipes[index].rating.toString(),
                      thumbnailUrl: _recipes[index].images.toString());
                },
              ));
  }
}
