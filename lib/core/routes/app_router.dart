import '/features/dashboard/cubit/dashboard_cubit.dart';
import '/features/dashboard/presentation/screens/dashboard_screen.dart';
import '/features/feature/presentation/screens/feature_screen.dart';
import '/features/login/cubit/login_cubit.dart';
import '/features/login/presentation/screens/login_screen.dart';
import '/features/splash_screen/splash_screen.dart';
import '/src/app_export.dart';

part 'app_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
// final GlobalKey<NavigatorState> _shellNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.initScreen,
    routes: [
      GoRoute(
        path: AppRoutes.initScreen,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.dashboardScreen,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            lazy: false,
            create: (context) => getIt<DashboardBloc>(),
            child: const DashboardScreen(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.dashboardLoginScreen,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            lazy: false,
            create: (context) => getIt<LoginBloc>(),
            child: const LoginScreen(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.featureScreen,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const FeatureScreen(),
        ),
      ),
    ],
    // redirect: (context, state) {
    //   if (FirebaseAuth.instance.currentUser == null &&
    //       !state.location.endsWith(AppRoutes.initScreen)) {
    //     return '/${AppRoutes.loginScreen}';
    //   }
    //   if (FirebaseAuth.instance.currentUser != null &&
    //       state.location.startsWith('/${AppRoutes.loginScreen}')) {
    //     return '/${AppRoutes.dashboardPage.toLowerCase()}';
    //   }

    //   return null;
    // },
  );
}
