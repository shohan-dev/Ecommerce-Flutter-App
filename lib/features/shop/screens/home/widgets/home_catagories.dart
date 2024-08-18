import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartshop/common/widget/image_text_widgets/vertical_image_text.dart';
import 'package:smartshop/features/shop/screens/sub_category/sub_categories.dart';
import 'package:smartshop/utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          // fixing the padding left and right
          double leftPadding = index == 0 ? 16.0 : 8.0;
          double rightPadding = index == 5 ? 16.0 : 8.0;

          return Padding(
            padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
            child: TVerticalImageText(
              image: TImages.shoeIcon,
              title: 'Shoe Category',
              onTap: () {
                Get.to(() => const SubCategoriesScreen());
              },
            ),
          );
        },
      ),
    );
  }
}
