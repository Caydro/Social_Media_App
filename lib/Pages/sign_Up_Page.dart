import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/routesOfPages.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/authentication/authenticationCubit.dart';
import 'package:collagiey/Cubit/authentication/authenticationState.dart';
import 'package:collagiey/Pages/date_and_circlePhoto_Pick.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:collagiey/Widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController userName = TextEditingController();

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>(); // Key for TextFields
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int? userID;
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSignUpStateFailed) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: 'Error',
            desc: state.errMessage,
            btnOkColor: Colors.red,
            btnOkOnPress: () {},
          )..show();
        } else if (state is AuthenticationSignUpStateLoading) {
          Lottie.asset(CaydroImagesPath.loadingMixSocial);
        } else if (state is AuthenticationSignUpStateSuccess) {
          userID = state.data["userID"];
          SharedPrefrencesOptions().addUserDataToSharedPrefMethod({
            "userID": userID,
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'Successfully',
            btnOkColor: CaydroColors.mainColor,
            desc: 'Thanks for registration, just a few more steps to login.',
            btnOkOnPress: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BirthDayAndCirclePhotoPage(
                    userID: userID,
                  ),
                ),
              );
            },
          )..show();
        }
      },
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationSignUpStateLoading) {
            return Scaffold(
              body: Center(
                child: Lottie.asset(CaydroImagesPath.loadingMixSocial),
              ),
            );
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "Sign Up",
                              style: CaydroTextStyles.titleStyles,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Divider(
                            indent: 90,
                            endIndent: 90,
                            thickness: 2,
                          ),
                          SizedBox(
                            width: width - 20,
                            child: Card(
                              child: Column(
                                children: [
                                  Lottie.asset(
                                    CaydroImagesPath.signUpImagePath,
                                    filterQuality: FilterQuality.high,
                                    repeat: false,
                                    fit: BoxFit.contain,
                                    height: height * 0.4,
                                  ),
                                  CustomTextField(
                                    obtScure: false,
                                    hintText: "Username",
                                    controller: userName,
                                    suffixIcon: const Icon(Icons.verified_user),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    obtScure: false,
                                    hintText: "Email",
                                    controller: emailController,
                                    suffixIcon: const Icon(Icons.email),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    obtScure: true,
                                    hintText: "Password",
                                    controller: passwordController,
                                    suffixIcon: const Icon(Icons.password),
                                    onSub: () {
                                      BlocProvider.of<AuthenticationCubit>(
                                              context)
                                          .authenticationSignUpMethod(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        userName: userName.text,
                                      );
                                    },
                                  ),
                                  Row(
                                    children: [
                                      const Text("If you don't have an account",
                                          style: CaydroTextStyles.normalText),
                                      TextButton(
                                        child: const Text("Sign In",
                                            style: CaydroTextStyles
                                                .TextButtonStyle),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              NamesOfRoutes.signInRoute);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.001,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: CaydroColors.mainColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 80),
                                      ),
                                      child: const Text(
                                        "Sign Up",
                                        style: CaydroTextStyles.buttonsStyle,
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<AuthenticationCubit>(
                                                context)
                                            .authenticationSignUpMethod(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          userName: userName.text,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
