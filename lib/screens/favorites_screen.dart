import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
 final List<Meal> favoriteMeals ;
 FavoritesScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
   if(favoriteMeals.isEmpty){
    return Center(child: Text('You have no favorites yet - start adding some!'),);
   }else{

    return ListView.builder(itemBuilder: (ctx,position){
     return MealItem(title: favoriteMeals[position].title,
      id: favoriteMeals[position].id,
      imageUrl: favoriteMeals[position].imageUrl,
      duration: favoriteMeals[position].duration,
      complexity: favoriteMeals[position].complexity,
      affordability: favoriteMeals[position].affordability
      ,);
    },
     itemCount: favoriteMeals.length,

    );
   }

  }
}
