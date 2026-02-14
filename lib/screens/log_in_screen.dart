import 'package:flutter/material.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/extensions/nav.dart';
import 'package:grocery/extensions/screen_size.dart';
import 'package:grocery/screens/products_list_screen.dart';
import 'package:grocery/screens/sign_up_screen.dart';
import 'package:grocery/services/database.dart';
import 'package:grocery/widgets/text_filed_widget.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              height: context.screenHeight * 0.25,
              width: context.screenWidth,
              alignment: Alignment.center,
              child: Text(
                "Log In",
                //textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().darkGreen,
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            Container(
              //padding: EdgeInsets.symmetric( horizontal: context.screenWidth * 0.3,  ), // 40
              decoration: BoxDecoration(
                color: AppColors().green,
                borderRadius: BorderRadius.only(topRight: Radius.circular(150)),
              ),
              width: context.screenWidth,
              height: context.screenHeight * 0.75,
              child: Column(
                children: [
                  SizedBox(height: context.screenHeight * 0.15),
                  SizedBox(
                    height: 60,
                    width: 300,
                    child: TextFieldWidget(
                      controller: emailController,
                      hintText: "enter your email",
                      errorText: null,
                      prefixIcon: Icon(Icons.email_outlined),
                      fillColor: AppColors().darkGreen,
                      iconAndTextColor: AppColors().creamBg,
                      hintTextColor: AppColors().grey,
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.02),
                  SizedBox(
                    height: 60,
                    width: 300,

                    child: TextFieldWidget(
                      controller: passwordController,
                      hintText: "enter your password",
                      errorText: null,
                      prefixIcon: Icon(Icons.password),
                      fillColor: AppColors().darkGreen,
                      iconAndTextColor: AppColors().creamBg,
                      hintTextColor: AppColors().grey,
                    ),
                  ),
                  SizedBox(height: context.screenHeight * 0.08),
                  SizedBox(
                    height: 60,
                    width: 300,
                    child: navButton(emailController: emailController, passwordController: passwordController, mounted: mounted),
                  ),
                  SizedBox(height: context.screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don't have an account?",
                        style: TextStyle(
                          color: AppColors().creamBg,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.navAndClean(SignUpScreen());
                        },
                        child: Text(
                          'Sign Up',
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

class navButton extends StatelessWidget {
  const navButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.mounted,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (emailController.text.isEmpty ||
            passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please fill in all fields"),
            ),
          );
          return;
        }
        try {
          await DataBase().login(
            email: emailController.text,
            password: passwordController.text,
          );
    
          if (mounted) {
            context.navToScreen(ProductsListScreen());
          }
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error $e")));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors().black,
        foregroundColor: AppColors().creamBg,
        minimumSize: const Size(double.infinity, 55),
        elevation: 0,
      ),
      child: Text(
        "Log In",
        style: TextStyle(
          color: AppColors().creamBg,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
