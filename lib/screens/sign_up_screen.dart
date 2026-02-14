import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/extensions/nav.dart';
import 'package:grocery/extensions/screen_size.dart';
import 'package:grocery/screens/log_in_screen.dart';
import 'package:grocery/services/database.dart';
import 'package:grocery/widgets/nav_button.dart';
import 'package:grocery/widgets/text_filed_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //final firstNameController = TextEditingController();
  //final lastNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().creamBg,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 60, right: 100),
              height: context.screenHeight * 0.18,
              width: context.screenWidth,
              alignment: Alignment.center,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.navToScreen(LogInScreen());
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: context.screenWidth * 0.1,
                      color: AppColors().darkGreen,
                    ),
                  ),
                  SizedBox(width: context.screenWidth * 0.02),
                  Text(
                    "Sign Up",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors().green,
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              //padding: EdgeInsets.symmetric(  horizontal: context.screenWidth * 0.3,), // 40
              decoration: BoxDecoration(
                color: AppColors().darkGreen,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
              ),
              width: context.screenWidth,
              height: context.screenHeight * 0.82,
              child: Column(
                children: [
                  SizedBox(height: context.screenHeight * 0.1),
                  // SizedBox(
                  //   height: 60,
                  //   width: 300,
                  //   child: TextFieldWidget(
                  //     controller: firstNameController,
                  //     hintText: "enter yor first name",
                  //     prefixIcon: Icon(Icons.person_2_outlined),
                  //     fillColor: AppColors().green,
                  //     iconAndTextColor: AppColors().creamBg,
                  //     hintTextColor: AppColors().darkGreen,
                  //   ),
                  // ),
                  // SizedBox(height: context.screenHeight * 0.02),
                  // SizedBox(
                  //   height: 60,
                  //   width: 300,
                  //   child: TextFieldWidget(
                  //     controller: lastNameController,
                  //     hintText: "enter yor last name",
                  //     prefixIcon: Icon(Icons.person_2_outlined),
                  //     fillColor: AppColors().green,
                  //     iconAndTextColor: AppColors().creamBg,
                  //     hintTextColor: AppColors().darkGreen,
                  //   ),
                  // ),
                  SizedBox(height: context.screenHeight * 0.02),
                  SizedBox(
                    height: (emailError != null) ? 85 : 60,
                    width: 300,
                    child: TextFieldWidget(
                      controller: emailController,
                      hintText: "enter your email",
                      errorText: emailError,
                      prefixIcon: Icon(Icons.email_outlined),
                      fillColor: AppColors().green,
                      iconAndTextColor: AppColors().creamBg,
                      hintTextColor: AppColors().darkGreen,
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.02),
                  SizedBox(
                    height: (passwordError != null) ? 85 : 60,
                    width: 300,
                    child: TextFieldWidget(
                      controller: passwordController,
                      hintText: "enter your password",
                      errorText: passwordError,
                      prefixIcon: Icon(Icons.password),
                      fillColor: AppColors().green,
                      iconAndTextColor: AppColors().creamBg,
                      hintTextColor: AppColors().darkGreen,
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.02),
                  SizedBox(
                    height: (confirmPasswordError != null) ? 85 : 60,
                    width: 300,
                    child: TextFieldWidget(
                      controller: confirmPasswordController,
                      hintText: "confirm your password",
                      errorText: confirmPasswordError,
                      prefixIcon: Icon(Icons.password),
                      fillColor: AppColors().green,
                      iconAndTextColor: AppColors().creamBg,
                      hintTextColor: AppColors().darkGreen,
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.06),
                  SizedBox(
                    height: 60,
                    width: 300,
                    child: NavButton(
                      text: "Sign Up",
                      textColor: AppColors().creamBg,
                      backgroundColor: AppColors().black,
                      onPressed: () async {
                        setState(() {
                          emailError = emailController.text.isEmpty
                              ? "Email is required"
                              : null;
                          passwordError = passwordController.text.length < 6
                              ? "Password too short"
                              : null;

                          confirmPasswordError =
                              passwordController.text !=
                                  confirmPasswordController.text
                              ? "Passwords do not match"
                              : null;
                        });

                        if (emailError != null ||
                            passwordError != null ||
                            confirmPasswordError != null) {
                          return;
                        }
                        try {
                          await DataBase().signUp(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          if (context.mounted) {
                            context.navAndClean(LogInScreen());
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Error $e")));
                        }
                      },
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: AppColors().creamBg,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.navAndClean(LogInScreen());
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xFFFFB347),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
