
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '/dummy_data.dart';
class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
 String? categoryTitle;
 late List<Meal> displayedMeals;
 var _loadedInitData = false;
 @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
   if(!_loadedInitData){
     final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String,String>;
     categoryTitle = routeArgs['title'];
     final categoryId = routeArgs['id'];
     displayedMeals = widget.availableMeals.where((meal)  {
       return meal.categories.contains(categoryId);
     }).toList();
     _loadedInitData = true;
   }
  }
  void _removeMeal(String mealId){

   setState(() {
     displayedMeals.removeWhere((meal) => meal.id==mealId);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryTitle '),
      ),
      body: ListView.builder(itemBuilder: (ctx,position){
        return MealItem(title: displayedMeals[position].title,
            id: displayedMeals[position].id,
            imageUrl: displayedMeals[position].imageUrl,
            duration: displayedMeals[position].duration,
            complexity: displayedMeals[position].complexity,
            affordability: displayedMeals[position].affordability
        ,);
      },
        itemCount: displayedMeals.length,

      ),
    );
  }
}
