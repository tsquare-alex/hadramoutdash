import '../../src/app_export.dart';
import '../themes/cubit/app_theme_cubit.dart';
import '/features/dashboard/cubit/dashboard_cubit.dart';
import '/features/dashboard/data/data_source/dashboard_data_source.dart';
import '/features/dashboard/data/repository/dashboard_repository.dart';
import '/features/feature/cubit/feature_cubit.dart';
import '/features/feature/data/data_source/feature_data_source.dart';
import '/features/feature/data/repository/feature_repository.dart';
import '/features/login/cubit/login_cubit.dart';
import '/features/login/data/data_source/login_data_source.dart';
import '/features/login/data/repository/login_repository.dart';

final getIt = GetIt.instance;

void initGetIt() {
  /// BLoC
  getIt.registerFactory<AppThemeBloc>(() => AppThemeBloc());
  getIt.registerFactory<FeatureBloc>(() => FeatureBloc(getIt()));
  getIt.registerFactory<DashboardBloc>(() => DashboardBloc(getIt()));
  getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt()));

  /// Data Sources
  getIt.registerLazySingleton<FeatureDataSource>(() => FeatureDataSource());
  getIt.registerLazySingleton<DashboardDataSource>(() => DashboardDataSource());
  getIt.registerLazySingleton<LoginDataSource>(() => LoginDataSource());

  /// Repository
  getIt.registerLazySingleton<FeatureRepository>(
    () => FeatureRepository(getIt()),
  );
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepository(getIt()),
  );
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepository(getIt()),
  );
}
