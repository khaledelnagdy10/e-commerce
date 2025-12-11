part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {}

final class AuthSignUpSuccess extends AuthState {}

class AuthGetUserSuccess extends AuthState {}

class AuthLogoutSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final ErrorModel errorModel;

  AuthFailure({required this.errorModel});
}
