import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smartshop/common/widget/images/t_round_images.dart';

class TPromoSlider extends StatefulWidget {
  const TPromoSlider({super.key, required this.banner});

  final List<String> banner;

  @override
  TPromoSliderState createState() => TPromoSliderState();
}

class TPromoSliderState extends State<TPromoSlider> {
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          CarouselSlider(
            items: widget.banner
                .map((url) => Padding(
                      padding:
                          const EdgeInsets.all(8.0), // Adjust padding as needed
                      child: TRoundImage(imageUrl: url),
                    ))
                .toList(),
            carouselController: _carouselController,
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(
              height:
                  10), // Add some space between the slider and the indicator
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: widget.banner.length,
            effect: WormEffect(
              dotWidth: 8.0,
              dotHeight: 8.0,
              activeDotColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              dotColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.4)
                  : Colors.black.withOpacity(0.4),
            ),
            onDotClicked: (index) {
              _carouselController.animateToPage(index);
            },
          ),
        ],
      ),
    );
  }
}
