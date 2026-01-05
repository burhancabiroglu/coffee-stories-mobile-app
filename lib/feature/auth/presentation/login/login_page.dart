import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/router/app_flow_cubit.dart';
import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radii.dart';
import '../../widgets/auth_input.dart';
import '../../widgets/auth_label.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    // Şimdilik: login başarılı varsayımı
    context.read<AppFlowCubit>().setAuthed(true);

    // Router zaten login/register'dan home'a yönlendirecek,
    // ama biz de doğrudan home'a gidebiliriz:
    context.go(RouteNames.home);
  }

  void _loginWithGoogle() {
    // TODO: Google Sign-In entegrasyonu
    // Şimdilik başarılı varsayım
    context.read<AppFlowCubit>().setAuthed(true);
    context.go(RouteNames.home);
  }

  void _goRegister() => context.go(RouteNames.register);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 12),

                            // Header
                            Column(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: AppColors.accent.withOpacity(0.30),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.coffee,
                                      size: 32,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Hoş Geldiniz',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(color: AppColors.foreground),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Hesabınıza giriş yapın',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.mutedForeground,
                                      ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 36),

                            // Form fields
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AuthLabel('E-posta'),
                                const SizedBox(height: 8),
                                AuthInput(
                                  controller: _emailCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'ornek@email.com',
                                  prefixIcon: Icons.mail_outline,
                                  validator: (v) {
                                    final s = (v ?? '').trim();
                                    if (s.isEmpty) return 'E-posta gerekli';
                                    if (!s.contains('@') || !s.contains('.')) {
                                      return 'Geçerli bir e-posta girin';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 16),

                                AuthLabel('Şifre'),
                                const SizedBox(height: 8),
                                AuthInput(
                                  controller: _passwordCtrl,
                                  obscureText: true,
                                  hintText: '••••••••',
                                  prefixIcon: Icons.lock_outline,
                                  validator: (v) {
                                    final s = (v ?? '');
                                    if (s.isEmpty) return 'Şifre gerekli';
                                    if (s.length < 6) {
                                      return 'Şifre en az 6 karakter olmalı';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 12),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // TODO: forgot password flow
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      foregroundColor: AppColors.mutedForeground,
                                    ),
                                    child: const Text(
                                      'Şifrenizi mi unuttunuz?',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            // Bottom actions
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Google login button
                                SizedBox(
                                  height: 52,
                                  child: OutlinedButton(
                                    onPressed: _loginWithGoogle,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.foreground,
                                      side: BorderSide(color: AppColors.border),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: AppRadii.borderRadiusXl,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/google.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        const Text('Google ile devam et'),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                // Email/password login
                                SizedBox(
                                  height: 52,
                                  child: FilledButton(
                                    onPressed: _submit,
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.onPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: AppRadii.borderRadiusXl,
                                      ),
                                    ),
                                    child: const Text('Giriş Yap'),
                                  ),
                                ),

                                const SizedBox(height: 14),

                                Center(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        'Hesabınız yok mu? ',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.mutedForeground,
                                            ),
                                      ),
                                      TextButton(
                                        onPressed: _goRegister,
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 6),
                                          foregroundColor: AppColors.primary,
                                        ),
                                        child: const Text('Kayıt Olun'),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ],
                        ),
                      )
                          // React: initial { opacity:0, y:20 } -> animate { opacity:1, y:0 }
                          .animate()
                          .fadeIn(duration: 350.ms)
                          .moveY(
                            begin: 20,
                            end: 0,
                            duration: 350.ms,
                            curve: Curves.easeOut,
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
