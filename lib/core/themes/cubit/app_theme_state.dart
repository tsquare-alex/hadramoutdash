part of 'app_theme_cubit.dart';

// @freezed
sealed class AppThemeState with _$AppThemeState {
  const factory AppThemeState.initial() = Init;
  const factory AppThemeState.fetched() = Fetched;
  const factory AppThemeState.changed() = Changed;
}
