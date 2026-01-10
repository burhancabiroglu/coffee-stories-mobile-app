import 'package:coffeestories/feature/chat/presentation/chat_flow/chat_flow_cubit.dart';
import 'package:coffeestories/feature/home/presentation/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:coffeestories/app/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/router/app_flow_cubit.dart';
import 'app/router/app_router.dart';
import 'core/di/di.dart';

import 'feature/auth/presentation/splash/splash_cubit.dart';
import 'feature/credit/presentation/credit_purchase_cubit.dart';
import 'feature/settings/presentation/settings/settings_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppFlowCubit _flow;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _flow = injector<AppFlowCubit>()..bootstrap();
    _router = createRouter(_flow);
  }

  // @override
  // void dispose() {
  //   _flow.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppFlowCubit>.value(value: injector()),
        BlocProvider<SplashCubit>(create: (_) => SplashCubit(flow: injector())),
        BlocProvider<HomeCubit>(create: (_) => HomeCubit(repo: injector())),
        BlocProvider<SettingsCubit>(create: (_) => SettingsCubit(repo: injector())),
        BlocProvider<CreditPurchaseCubit>(create: (_) => CreditPurchaseCubit(repo: injector(), ads: injector())),
        BlocProvider<ChatFlowCubit>(create: (_) => ChatFlowCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852), // iPhone 16 logical size
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Telveden Hikayeler',
            theme: AppTheme.light,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}