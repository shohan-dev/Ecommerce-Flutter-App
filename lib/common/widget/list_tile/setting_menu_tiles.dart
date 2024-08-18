import 'package:flutter/material.dart';
import 'package:smartshop/utils/constants/colors.dart';

class TSettingMenuTiles extends StatelessWidget {
  const TSettingMenuTiles(
      {super.key,
      this.trailing,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.onTap});

  final Widget? trailing;
  final IconData icon;
  final String title, subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: TColors.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
