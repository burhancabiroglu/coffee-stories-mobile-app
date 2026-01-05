import 'package:coffeestories/feature/auth/presentation/register/register_page.dart';
import 'package:go_router/go_router.dart';
import '../../feature/auth/presentation/login/login_page.dart';
import 'route_names.dart';
import 'app_flow_cubit.dart';
import 'go_router_refresh_stream.dart';

import '../../feature/auth/presentation/splash/splash_page.dart';
import '../../feature/auth/presentation/onboarding/onboarding_page.dart';


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
        // GoRoute(
        //   path: RouteNames.home,
        //   builder: (_, __) => const HomePage(),
        // ),
        //
        // GoRoute(
        //   path: RouteNames.creditPurchase,
        //   builder: (_, __) => const CreditPurchasePage(),
        // ),
        // GoRoute(
        //   path: RouteNames.creditsFinished,
        //   builder: (_, __) => const CreditsFinishedPage(),
        // ),
        //
        // GoRoute(
        //   path: RouteNames.camera,
        //   builder: (_, __) => const CameraPage(),
        // ),
        // GoRoute(
        //   path: RouteNames.photoReview,
        //   builder: (_, __) => const PhotoReviewPage(),
        // ),
        //
        // GoRoute(
        //   path: RouteNames.chat,
        //   builder: (_, __) => const ChatPage(),
        // ),
        // GoRoute(
        //   path: RouteNames.voiceChat,
        //   builder: (_, __) => const VoiceChatPage(),
        // ),
        // GoRoute(
        //   path: RouteNames.conversationEnd,
        //   builder: (_, __) => const ConversationEndPage(),
        // ),
        //
        // GoRoute(
        //   path: RouteNames.settings,
        //   builder: (_, __) => const SettingsPage(),
        // ),
      ]
  );
}