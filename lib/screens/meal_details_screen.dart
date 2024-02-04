import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/provider/favourites_provider.dart';
import 'package:meals_app/provider/meals_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  void onToggleFavourite(Meal meal) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final favMeals = ref.watch(favouriteMealsProvider);
    final isFav = favMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              bool isAdded = ref.read(favouriteMealsProvider.notifier).toggleMealFavouriteStatus(meal);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isAdded ? 'Added to favourite' : 'Removed from favourite'),
                ),
              );
            },
            icon: isFav ? const Icon( Icons.star) : const Icon(Icons.star_border),
          ),
        ],
        title: Text(meal.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(meal.title, style: const TextStyle(color: Colors.white)),
            PopScope(
              canPop: true,
              onPopInvoked: (didPop) {
                if (didPop) return;
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    action: SnackBarAction(label: 'OK', onPressed: () {}),
                    content: const Center(
                      child: Text(
                        'You can not pop!',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                );
              },
              child: TextButton(
                child: const Text('Back'),
                onPressed: () {
                  Navigator.of(context).pop({
                    'name': 'Asadul Haque',
                    'age': '28',
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
