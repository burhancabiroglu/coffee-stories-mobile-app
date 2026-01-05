import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCoffeeMark extends StatelessWidget {
  const HomeCoffeeMark({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.secondary.withOpacity(0.30),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.coffee_rounded,
        size: 24.w,
        color: theme.colorScheme.primary,
      ),
    );
  }
}

