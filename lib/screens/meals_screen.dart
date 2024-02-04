import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  final String title;
  final List<Meal> meals;

  void  _switchToMealDetails(BuildContext context,int index) async {
    final  result = await Navigator.of(context).push<Map<String,String>>(
      MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meals[index])),
    );
    print('returned_data -> $result');
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = meals.isNotEmpty
        ? ListView.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, index) => MealItem(
                meal: meals[index],
                onMealSelected: () {
                  _switchToMealDetails(context, index);
                }),
          )
        : const Center(
            child: Text(
            'No data found!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ));

    if(meals.isEmpty) return mainContent;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: mainContent,
    );
  }
}
