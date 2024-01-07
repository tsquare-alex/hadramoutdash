import 'package:flutter/gestures.dart';

import '../features/dashboard/cubit/dashboard_cubit.dart';
import '../features/login/cubit/login_cubit.dart';
import 'app_export.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<LoginBloc>(),
            ),
            BlocProvider(
              create: (context) => getIt<DashboardBloc>(),
            ),
          ],
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp.router(
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {PointerDeviceKind.mouse},
              ),
              title: 'Hadrmout Hamza',
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme,
              localizationsDelegates: const [
                AppLocalizationDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ar', 'EG'),
              ],
              routerDelegate: AppRouter.router.routerDelegate,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routeInformationProvider:
                  AppRouter.router.routeInformationProvider,
              builder: (context, child) => ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: [
                  const Breakpoint(start: 350, end: 700, name: MOBILE),
                  const Breakpoint(start: 701, end: 950, name: TABLET),
                  const Breakpoint(start: 951, end: 1500, name: DESKTOP),
                  const Breakpoint(
                      start: 1501, end: double.infinity, name: '4K'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
