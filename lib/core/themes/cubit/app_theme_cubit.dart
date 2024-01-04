import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_theme_cubit.freezed.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Cubit<AppThemeState> {
  AppThemeBloc() : super(const AppThemeState.initial());

  static AppThemeBloc get(context) => BlocProvider.of<AppThemeBloc>(context);

  Future<SharedPreferences> getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  Future<void> setAppTheme() async {
    final preferences = await getPreferences();
    preferences.setBool('AppTheme', isDarkMode);
  }

  Future<bool?> fetchAppTheme() async {
    final preferences = await getPreferences();
    return preferences.getBool('AppTheme');
  }

  Future<void> applyAppTheme() async {
    final isDarkModeFetched = await fetchAppTheme();
    isDarkModeFetched == null
        ? ThemeMode.light
        : _themeMode = isDarkModeFetched ? ThemeMode.dark : ThemeMode.light;
    emit(const AppThemeState.fetched());
  }

  // final _brightness =
  //     WidgetsBinding.instance.platformDispatcher.platformBrightness;

  // bool get isDarkModeSystem => _brightness == Brightness.dark;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // void setInitialThemeMode() {
  //   isDarkModeSystem
  //       ? _themeMode = ThemeMode.dark
  //       : _themeMode = ThemeMode.light;
  // }

  void toggleTheme(bool isOn) {
    emit(const AppThemeState.initial());
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    setAppTheme();
    emit(const AppThemeState.changed());
  }

  void changeTheme() {
    emit(const AppThemeState.initial());
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    setAppTheme();
    emit(const AppThemeState.changed());
  }
}
