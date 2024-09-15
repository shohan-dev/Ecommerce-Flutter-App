import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/effect/catagories_shimmer_effect.dart';
import 'package:smartshop/common/widget/image_text_widgets/vertical_image_text.dart';
import 'package:smartshop/features/shop/controllers/category_controller.dart';
import 'package:smartshop/features/shop/screens/sub_category/sub_categories.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isloading.value) {
        return const TCategoryShimmer();
      }
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Categories Found',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }

      return SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryController.featuredCategories.length,
          itemBuilder: (context, index) {
            final category = categoryController.featuredCategories[index];
            double leftPadding = index == 0 ? 16.0 : 8.0;
            double rightPadding = index == 5 ? 16.0 : 8.0;

            return Padding(
              padding: EdgeInsets.only(right: rightPadding, left: leftPadding),
              child: TVerticalImageText(
                image: category.image,
                title: category.name,
                onTap: () {
                  Get.to(() => const SubCategoriesScreen());
                },
              ),
            );
          },
        ),
      );
    });
  }
}
