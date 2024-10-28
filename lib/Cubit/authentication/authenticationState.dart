abstract class AuthenticationState {}

class AuthenticationSignUpStateinitial extends AuthenticationState {}

class AuthenticationSignUpStateSuccess extends AuthenticationState {
  final Map<String, dynamic> data;
  AuthenticationSignUpStateSuccess(this.data);
}

class AuthenticationSignUpStateLoading extends AuthenticationState {}

class AuthenticationSignUpStateFailed extends AuthenticationState {
  final String errMessage;
  AuthenticationSignUpStateFailed(this.errMessage);
}
////////////////////////////////////////////                            SIGN IN STATES                 ///////////////////////////////////////////////////////

class AuthenticationSignInStateinitial extends AuthenticationState {}

class AuthenticationSignInStateSuccess extends AuthenticationState {
  final Map<String, dynamic> data;
  AuthenticationSignInStateSuccess(this.data);
}

class AuthenticationSignInStateLoading extends AuthenticationState {}

class AuthenticationSignInStateFailed extends AuthenticationState {
  final String errMessage;
  AuthenticationSignInStateFailed(this.errMessage);
}
