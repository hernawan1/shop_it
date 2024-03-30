part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLogin extends AuthState {
  final LoginModel loginModel;
  const AuthLogin(this.loginModel);

  @override
  List<Object> get props => [loginModel];
}

class AuthError extends AuthState {
  final String reason;
  const AuthError(this.reason);

  @override
  List<Object> get props => [reason];
}
