import 'package:flutter/material.dart';
import 'package:t_store/common/widget/appbar/appbar.dart';
import 'package:t_store/common/widget/custom_shape/containers/primary_header_container.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                TAppBar(
                  title: Column(
                    children: [Text(TTexts.homeAppbarTitle)],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
