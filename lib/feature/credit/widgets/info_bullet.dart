import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoBullet extends StatelessWidget {
  const InfoBullet({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('• ', style: TextStyle(color: color, fontSize: 13.sp, fontWeight: FontWeight.w700)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 13.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}