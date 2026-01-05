import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_flow_cubit.dart';
import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radii.dart';
import '../../widgets/onboarding_slide.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}


class _OnboardingPageState extends State<OnboardingPage> {
  int _index = 0;
  late final PageController _pageController;

  final List<OnboardingSlideData> _slides = const [
    OnboardingSlideData(
      icon: Icons.coffee,
      title: 'Hoş Geldiniz',
      description:
      'Telveden Hikâyeler, Türk kahvesi eşliğinde düşünceli sohbetler için tasarlanmış bir yapay zeka asistanıdır.',
    ),
    OnboardingSlideData(
      icon: Icons.chat_bubble_outline,
      title: 'Saygılı Sohbet',
      description:
      'Bu uygulama fal bakmaz, gelecek hakkında öngörü sunmaz. Sadece anlık, düşünceli ve saygılı bir sohbet deneyimi sunar.',
    ),
    OnboardingSlideData(
      icon: Icons.favorite_outline,
      title: 'Huzurlu Anlar',
      description:
      'Kahvenizin tadını çıkarırken, sakin ve samimi bir ortamda düşüncelerinizi paylaşın.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _isLast => _index == _slides.length - 1;

  void _complete() {
    // Onboarding bitince:
    // 1) flag set et (router redirect artık onboarding’e zorlamasın)
    // 2) login’e git (auth yoksa zaten redirect login’e atar)
    context.read<AppFlowCubit>().markOnboardingSeen();
    context.go(RouteNames.login);
  }

  void _next() {
    if (_isLast) {
      _complete();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  void _skip() => _complete();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) {
                    final s = _slides[i];
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: OnboardingSlide(
                          icon: s.icon,
                          title: s.title,
                          description: s.description,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Dots
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: AnimatedBuilder(
                animation: _pageController,
                builder: (context, _) {
                  final page = _pageController.hasClients
                      ? (_pageController.page ?? _pageController.initialPage.toDouble())
                      : _index.toDouble();

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_slides.length, (i) {
                      final t = (1.0 - (page - i).abs()).clamp(0.0, 1.0);
                      final width = 8 + (24 * t); // 8 -> 32
                      final color = Color.lerp(AppColors.muted, AppColors.primary, t)!;

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: width,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),

            // Bottom buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
              child: Row(
                children: [
                  if (!_isLast)
                    Expanded(
                      child: TextButton(
                        onPressed: _skip,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.mutedForeground,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadii.borderRadiusXl,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Atla'),
                      ),
                    ),
                  if (!_isLast) const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _next,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadii.borderRadiusXl,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: _isLast
                          ? const Text('Başla')
                          : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('İleri'),
                          SizedBox(width: 6),
                          Icon(Icons.chevron_right, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
