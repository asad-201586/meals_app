import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/provider/counter_provider.dart';
import 'package:meals_app/provider/favourites_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import 'package:meals_app/provider/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const CategoriesScreen();
    String  pageTitle = 'Categories';

    final meals = ref.watch(mealsProvider);
    final counter = ref.watch(counterProvider);
    final availableMeals = meals.where((meal) => meal.title == 'a');

    if (_selectedPageIndex == 1) {
      final favouritesMeals = ref.watch(favouriteMealsProvider);
      activeScreen = MealsScreen(title: 'Favourites', meals: favouritesMeals);
      pageTitle = 'Favourites';
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        child: Text('$counter'),
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
      ),
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      drawer: const MainDrawer(),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
