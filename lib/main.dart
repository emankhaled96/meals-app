import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/filters_screen.dart';


import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import 'models/meal.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegetarian' : false,
    'vegan' : false,

  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];


  void _setFilters(Map<String,bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {

        if(_filters['gluten'] == true&& !meal.isGlutenFree){
          return false;

        }
        if(_filters['lactose'] == true && !meal.isLactoseFree){
          return false;

        }
        if(_filters['vegetarian'] == true&& !meal.isVegetarian){
          return false;

        }
        if(_filters['vegan'] == true&& !meal.isVegan){
          return false;

        }
        return true;
      }).toList();

    });




  }
  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id==mealId) ;
    if(existingIndex >=0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
      });
    }
  }

  bool _isFavorite(String id){
  return _favoriteMeals.any((meal) => meal.id==id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: TextStyle(
            color: Color.fromRGBO(20,51, 51, 1)
          ),
          bodyMedium: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          )
        )
      ),
      title: 'DeliMeals',
      home: TabsScreen(_favoriteMeals),
      routes: {
        CategoryMealsScreen.routeName :(context)=>CategoryMealsScreen(_availableMeals),
        MealDetailsScreen.routeName : (context)=> MealDetailsScreen(_toggleFavorite,_isFavorite),
        FiltersScreen.routeName:(context)=>FiltersScreen(_filters,_setFilters)
      },
    );
  }
}