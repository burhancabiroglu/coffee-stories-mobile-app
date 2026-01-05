import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

class AuthLabel extends StatelessWidget {
  final String text;
  const AuthLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.foreground,
      ),
    );
  }
}