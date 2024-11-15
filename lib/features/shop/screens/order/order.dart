import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/features/shop/screens/order/widgets/order_list.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text("My Orders",
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: TOrderListItems(),
        ));
  }
}
