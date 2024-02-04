import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavouriteMealProvider extends StateNotifier<List<Meal>> {
  FavouriteMealProvider() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    final mealsIsFavourite = state.contains(meal);
    if (mealsIsFavourite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider = StateNotifierProvider<FavouriteMealProvider, List<Meal>>((ref) {
  return FavouriteMealProvider();
});
