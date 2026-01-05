import 'package:flutter/material.dart';
import 'package:coffeestories/app/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/router/app_flow_cubit.dart';
import 'app/router/app_router.dart';

void main() {
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
    _flow = AppFlowCubit()..bootstrap();
    _router = createRouter(_flow);
  }

  @override
  void dispose() {
    _flow.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _flow,
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