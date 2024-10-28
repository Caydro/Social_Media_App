import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/routesOfPages.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/authentication/authenticationCubit.dart';
import 'package:collagiey/Cubit/authentication/authenticationState.dart';
import 'package:collagiey/Home/home_Body.dart';
import 'package:collagiey/Home/mainHome.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:collagiey/Widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthenticationSignInStateSuccess) {
            Map<String, dynamic> data = state.data;
            int userID = data['user_id'];
            SharedPrefrencesOptions().addUserDataToSharedPrefMethod({
              "userID": userID,
            });
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(
                  userID: userID,
                ),
              ),
            );
          } else if (state is AuthenticationSignInStateFailed) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.bottomSlide,
              title: 'Error',
              desc: state.errMessage,
              btnOkColor: CaydroColors.mainColor,
              btnOkOnPress: () {},
            )..show();
          }
        },
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSignInStateLoading) {
              return Scaffold(
                body: Center(
                    child: Lottie.asset(CaydroImagesPath.loadingMixSocial)),
              );
            } else {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Sign In",
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
                                CaydroImagesPath.signInImagePath,
                                filterQuality: FilterQuality.high,
                                repeat: false,
                                width: width * 0.7,
                                fit: BoxFit.contain,
                              ),
                              CustomTextField(
                                obtScure: false,
                                hintText: "Username",
                                controller: emailController,
                                suffixIcon: const Icon(Icons.email),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                obtScure: true,
                                hintText: "Password",
                                controller: passwordController,
                                suffixIcon: const Icon(Icons.password),
                              ),
                              Row(
                                children: [
                                  const Text("If you Dont have an account",
                                      style: CaydroTextStyles.normalText),
                                  TextButton(
                                    child: const Text("Sign Up",
                                        style:
                                            CaydroTextStyles.TextButtonStyle),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(NamesOfRoutes.signUpRoute);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
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
                                    "Login",
                                    style: CaydroTextStyles.buttonsStyle,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<AuthenticationCubit>(
                                            context)
                                        .authenticationSignInMethod(
                                            email: emailController.text,
                                            password: passwordController.text);
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
              );
            }
          },
        ),
      ),
    );
  }
}
