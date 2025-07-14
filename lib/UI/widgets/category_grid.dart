import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final Function(String?) onSelectCategory;

  const CategoryGrid({
    super.key,
    required this.categories,
    this.selectedCategory,
    required this.onSelectCategory,
  });

  // Helper to get category image (ensure these images exist in assets!)
  String _getCategoryImage(String category) {
    switch (category.toLowerCase()) {
      case 'fruits':
        return 'assets/images/fruits.jpg';
      case 'vegetables':
        return 'assets/images/vegetables.jpg';
      case 'dairy':
        return 'assets/images/dairy.jpg';
      case 'bakery':
        return 'assets/images/bakery.jpg';
      case 'beverages':
        return 'assets/images/beverages.jpg';
      default:
        return 'assets/images/default.jpg';

    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return GestureDetector(
          onTap: () => onSelectCategory(category),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2F3F2),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    _getCategoryImage(category),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
