import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'Colors.dart';
import 'Sizes.dart';
import 'device_utility.dart';
import 'helperFunctions.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding =
        const EdgeInsets.symmetric(horizontal: Allsizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(Allsizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? AllColors.dark
                    : AllColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(Allsizes.cardRadiusLg),
            border: showBorder ? Border.all(color: AllColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: AllColors.darkGrey),
              const SizedBox(width: Allsizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
