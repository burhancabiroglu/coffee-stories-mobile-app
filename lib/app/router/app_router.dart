import 'package:go_router/go_router.dart';

import 'route_names.dart';
import 'app_flow_cubit.dart';
import 'go_router_refresh_stream.dart';

import 'package:coffeestories/feature/auth/presentation/register/register_page.dart';
import 'package:coffeestories/feature/auth/presentation/login/login_page.dart';
import 'package:coffeestories/feature/credit/presentation/credit_purchase_page.dart';
import 'package:coffeestories/feature/home/presentation/home_page.dart';
import 'package:coffeestories/feature/settings/presentation/help/help_page.dart';
import 'package:coffeestories/feature/settings/presentation/notification/notification_page.dart';
import 'package:coffeestories/feature/settings/presentation/policy/policy_page.dart';
import 'package:coffeestories/feature/settings/presentation/privacy/privacy_page.dart';
import 'package:coffeestories/feature/settings/presentation/profile/profile_page.dart';
import 'package:coffeestories/feature/settings/presentation/settings/settings_page.dart';
import 'package:coffeestories/feature/settings/presentation/terms/terms_page.dart';
import 'package:coffeestories/feature/auth/presentation/splash/splash_page.dart';
import 'package:coffeestories/feature/auth/presentation/onboarding/onboarding_page.dart';
import 'package:coffeestories/feature/chat/presentation/chat_flow/chat_flow_page.dart';
import 'package:coffeestories/feature/chat/presentation/camera/camera_page.dart';
import 'package:coffeestories/feature/chat/presentation/photo_review/photo_review_page.dart';
import 'package:coffeestories/feature/chat/presentation/text_chat/text_chat_page.dart';
import 'package:coffeestories/feature/chat/presentation/voice_chat/voice_chat_page.dart';
import 'package:coffeestories/feature/chat/presentation/conversation_end/conversation_end_page.dart';


GoRouter createRouter(AppFlowCubit flow) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    refreshListenable: GoRouterRefreshStream(flow.stream),
    redirect: (context, state) {
      final s = flow.state;
      final loc = state.matchedLocation;

      // Bootstrap bitmediyse sadece splash
      if (!s.isBootstrapped) {
        return loc == RouteNames.splash ? null : RouteNames.splash;
      }

      // Onboarding görülmediyse onboarding’e zorla
      if (!s.onboardingSeen) {
        final allowed = loc == RouteNames.onboarding || loc == RouteNames.splash;
        return allowed ? null : RouteNames.onboarding;
      }

      // Auth yoksa login/register dışında hiçbir yere gitme
      if (!s.isAuthed) {
        final allowed = loc == RouteNames.login || loc == RouteNames.register;
        return allowed ? null : RouteNames.login;
      }

      // Auth varsa login/register’a gitmesin
      if (s.isAuthed && (loc == RouteNames.login || loc == RouteNames.register)) {
        return RouteNames.home;
      }

      return null;
    },
      routes: [
        GoRoute(
          path: RouteNames.splash,
          builder: (_, _) => const SplashPage(),
        ),
        GoRoute(
          path: RouteNames.onboarding,
          builder: (_, __) => const OnboardingPage(),
        ),
        GoRoute(
          path: RouteNames.login,
          builder: (_, __) => const LoginPage(),
        ),
        GoRoute(
          path: RouteNames.register,
          builder: (_, __) => const RegisterPage(),
        ),
        GoRoute(
          path: RouteNames.home,
          builder: (_, __) => const HomePage(),
        ),
        GoRoute(
          path: RouteNames.creditPurchase,
          builder: (_, __) => const CreditPurchasePage(),
        ),
        GoRoute(
          path: RouteNames.chatFlow,
          builder: (_, __) => const ChatFlowPage(),
          routes: [
            GoRoute(
              path: 'camera',
              builder: (_, __) => const CameraPage(),
            ),
            GoRoute(
              path: 'photo-review',
              builder: (_, __) => const PhotoReviewPage(),
            ),
            GoRoute(
              path: 'text',
              builder: (_, __) => TextChatPage(),
            ),
            GoRoute(
              path: 'voice',
              builder: (_, __) => VoiceChatPage(),
            ),
            GoRoute(
              path: 'result',
              builder: (_, __) => ConversationEndPage(),
            ),
          ],
        ),
        GoRoute(
          path: RouteNames.settings,
          builder: (_, __) => const SettingsPage(),
          routes: [
            GoRoute(
              path: 'profile',
              builder: (_, __) => const SettingsProfilePage(),
            ),
            GoRoute(
              path: 'notifications',
              builder: (_, __) => const SettingsNotificationsPage(),
            ),
            GoRoute(
              path: 'privacy',
              builder: (_, __) => const SettingsPrivacyPage(),
            ),
            GoRoute(
              path: 'help',
              builder: (_, __) => const SettingsHelpPage(),
            ),
            GoRoute(
              path: 'terms',
              builder: (_, __) => const SettingsTermsPage(),
            ),
            GoRoute(
              path: 'privacy-policy',
              builder: (_, __) => const SettingsPrivacyPolicyPage(),
            ),
          ],
        ),
      ]
  );
}