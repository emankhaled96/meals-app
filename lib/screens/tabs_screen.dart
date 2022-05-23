import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
   late List<Map<String,dynamic>> _pages ;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    _pages =  [
      { 'page':CategoriesScreen(),'title':'Categories'},
      {'page':FavoritesScreen(widget.favoriteMeals) , 'title': 'Favorites'}];
    super.initState();
  }
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
// to add bottom tab bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( _pages[_selectedPageIndex]['title']),
      ),
      drawer: Drawer(child: MainDrawer(),),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
         //type: BottomNavigationBarType.shifting ,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
        //    backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
          //  backgroundColor: Theme.of(context).primaryColor,
          )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
    );

// To add a top tap bar

    // DefaultTabController(
    //     length: 2,// Number of tabs I want
    //     child: Scaffold(
    //       appBar:AppBar(title: Text('Meals'),
    //       bottom: TabBar(tabs: [
    //         Tab(
    //           icon:Icon(Icons.category ) ,
    //           text: 'Categories',
    //         ),
    //         Tab(
    //           icon: Icon(Icons.star,),
    //           text: 'Favorites' ,
    //
    //         )
    //       ],
    //       ),
    //       ) ,
    //       body: TabBarView(
    //         children: [
    //           CategoriesScreen(),
    //           FavoritesScreen()
    //         ],
    //       ),
    //     )
    // );
  }
}
