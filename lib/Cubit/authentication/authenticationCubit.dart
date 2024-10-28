import 'package:collagiey/Core/ApiLinks.dart';
import 'package:collagiey/Cubit/authentication/authenticationState.dart';
import 'package:collagiey/Service/custom_HttpRequest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationSignUpStateinitial());
  Future authenticationSignUpMethod({
    required String email,
    required String password,
    required String userName,
  }) async {
    emit(AuthenticationSignUpStateLoading());

    Future.delayed(const Duration(seconds: 3), () async {
      try {
        Map<String, dynamic> data =
            await customHttpRequest(url: ApiActionsLink.signUpLink, body: {
          "email": email,
          "password": password,
          "user_name": userName,
          "position": "user",
        });
        print(data);
        if (data.containsKey("message")) {
          emit(AuthenticationSignUpStateSuccess(data));
        } else if (data.containsKey("error")) {
          emit(
            AuthenticationSignUpStateFailed(data["error"]),
          );
        } else {
          emit(AuthenticationSignUpStateFailed(
              "There's no Such a user Like that"));
        }
      } catch (e) {
        emit(
          AuthenticationSignUpStateFailed(e.toString()),
        );
      }
    });
  }

  Future authenticationSignInMethod(
      {required String email, required String password}) async {
    emit(AuthenticationSignInStateLoading());
    Future.delayed(Duration(seconds: 3), () async {
      try {
        Map<String, dynamic> data =
            await customHttpRequest(url: ApiActionsLink.signInLink, body: {
          "email": email,
          "password": password,
        });
        if (data.containsKey("success")) {
          emit(AuthenticationSignInStateSuccess(data));
        } else if (data.containsKey("error")) {
          emit(AuthenticationSignInStateFailed(data["error"]));
        }
      } catch (e) {
        emit(AuthenticationSignInStateFailed(e.toString()));
      }
    });
  }
}
