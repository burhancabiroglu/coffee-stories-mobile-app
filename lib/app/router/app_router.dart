import 'package:coffeegenie/core/ui/blank_page.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';
import 'app_flow_cubit.dart';
import 'go_router_refresh_stream.dart';


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
          builder: (_, _) => const BlankPage(),
        ),
        GoRoute(
          path: RouteNames.onboarding,
          builder: (_, __) => const BlankPage(),
        ),
        GoRoute(
          path: RouteNames.login,
          builder: (_, __) => const BlankPage(),
        ),
        GoRoute(
          path: RouteNames.register,
          builder: (_, __) => const BlankPage(),
        ),
        GoRoute(
          path: RouteNames.home,
          builder: (_, __) => const BlankPage(),
        ),
        GoRoute(
          path: RouteNames.creditPurchase,
          builder: (_, __) => const BlankPage(),
        ),
        GoRoute(
          path: RouteNames.chatFlow,
          builder: (_, __) => const BlankPage(),
        ),
        GoRoute(
          path: RouteNames.settings,
          builder: (_, __) => const BlankPage(),
          routes: [
            GoRoute(
              path: 'profile',
              builder: (_, __) => const BlankPage(),
            ),
            GoRoute(
              path: 'notifications',
              builder: (_, __) => const BlankPage(),
            ),
            GoRoute(
              path: 'privacy',
              builder: (_, __) => const BlankPage(),
            ),
            GoRoute(
              path: 'help',
              builder: (_, __) => const BlankPage(),
            ),
            GoRoute(
              path: 'terms',
              builder: (_, __) => const BlankPage(),
            ),
            GoRoute(
              path: 'privacy-policy',
              builder: (_, __) => const BlankPage(),
            ),
          ],
        ),
      ]
  );
}