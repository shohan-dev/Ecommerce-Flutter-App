import 'package:flutter/material.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/device/device_utility.dart';

class TRatingProgressIndicator extends StatelessWidget {
  const TRatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
    required this.totalCount,
  });

  final String text;
  final double value;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            )),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: TDeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: TColors.grey,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(TColors.primary),
            ),
          ),
        ),
        const SizedBox(width: 8), // Add spacing
        Text('($totalCount)',
            style: Theme.of(context).textTheme.bodySmall), // Display totalCount
      ],
    );
  }
}
