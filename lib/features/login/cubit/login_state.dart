part of 'login_cubit.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginCompleted extends LoginState {}

class LoginError extends LoginState {
  final String errorMessage;
  LoginError({
    required this.errorMessage,
  });
}

class LogoutLoading extends LoginState {}

class LogoutCompleted extends LoginState {}
