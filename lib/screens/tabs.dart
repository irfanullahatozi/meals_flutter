import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int selectedPageIndex = 0;
  final List<Meal> favoriteMeals = [];

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void toggleFavoriteMeals(Meal meal) {
    final isExist = favoriteMeals.contains(meal);
    if (isExist) {
      setState(() {
        favoriteMeals.remove(meal);
        showInfoMessage('Meal is no longer a favorite.');
      });
    } else {
      setState(() {
        favoriteMeals.add(meal);
      });
      showInfoMessage('Mark as a favorite.');
    }
  }

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: toggleFavoriteMeals,
    );
    var activePageTitle = 'Categories';
    if (selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: favoriteMeals,
        onToggleFavorite: toggleFavoriteMeals,
      );
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
