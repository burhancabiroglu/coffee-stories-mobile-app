import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';

class SettingsNotificationsPage extends StatelessWidget {
  const SettingsNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Bildirimler'),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: const Center(child: Text('TODO: Bildirim tercihleri')),
    );
  }
}