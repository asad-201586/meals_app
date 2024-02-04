import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/api_service/api_service.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/model/product.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/provider/api_provider.dart';
import 'package:meals_app/provider/counter_provider.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

final apiProvider = Provider<ApiService>((ref) => ApiService());
final productProvider = FutureProvider<Product>((ref) => ref.read(apiProvider).getProduct());

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    print('print_title ----------> ${category.title}');

    final filteredMeals = dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return GridView(
    //   padding: const EdgeInsets.all(24),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     childAspectRatio: 1.5,
    //     crossAxisSpacing: 20,
    //     mainAxisSpacing: 20,
    //   ),
    //   children: [
    //     for (final item in availableCategories)
    //       CategoryGridItem(
    //         category: item,
    //         onSelectCategory: (category) {
    //           _selectCategory(context, category);
    //         },
    //       ),
    //   ],
    // );
    final counter = ref.watch(counterProvider);
    final provider = ref.read(counterProvider.notifier);

    final product = ref.watch(productProvider);

    return product.when(
      data: (data) => Center(
        child: Column(
          children: [
            Text('id: ${data.id}',style: const TextStyle(color: Colors.white)),
            Text('title: ${data.title}',style: const TextStyle(color: Colors.white)),
            Text('category: ${data.category}',style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                provider.increment();
              },
              icon: const Icon(Icons.add),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                provider.decrement();
              },
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(width: 40),
            Text(
              '$counter',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(width: 100),
          ],
        ),
      ],
    );
  }
}
