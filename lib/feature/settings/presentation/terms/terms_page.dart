import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';

class SettingsTermsPage extends StatelessWidget {
  const SettingsTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppColors.foreground,
          onPressed: () => context.pop(),
        ),
        title: const Text('Kullanım Koşulları'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text(
              'TODO: Kullanım Koşulları içeriği\n\n'
                  'Bu alan daha sonra webview veya statik metin ile doldurulacak.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}