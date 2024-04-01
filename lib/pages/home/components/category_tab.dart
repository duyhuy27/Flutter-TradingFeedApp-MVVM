import 'package:flutter/material.dart';
import 'package:trading_news/model/news/category_model.dart';

class CategoryTab extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(String) onCategorySelected;
  final String selectedCategory;

  const CategoryTab({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            onCategorySelected(categories[index].title.toString());
          },
          child: Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: Stack(
              children: [
                Text(
                  categories[index].title.toString(),
                  style: TextStyle(
                    color: selectedCategory == categories[index].title
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
                if (selectedCategory == categories[index].title)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Container(
                      height: 2,
                      color: Colors.orange,
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
