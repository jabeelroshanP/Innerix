import 'package:flutter/material.dart';
import 'package:innerix/controller/auth_provider.dart';
import 'package:innerix/view/home/home.dart';
import 'package:innerix/view/otp_verification/otp_verify.dart';
import 'package:innerix/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LinearGradient goldGradient = const LinearGradient(
      colors: [Color(0xFFEFB203), Color(0xFFCE8800)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Consumer<AuthProvider>(
              builder: (context, value, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWdgt(
                      "Sign in to your Account",
                      screenWidth * 0.10,
                      FontWeight.w500,
                    ),
                    const SizedBox(height: 20),
                    textWdgt(
                      "Enter Your email and password to log in",
                      screenWidth * 0.04,
                      FontWeight.w400,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    textWdgt("Email", screenWidth * 0.04, FontWeight.w400),
                    SizedBox(height: screenHeight * 0.01),
                    customTextFormField(
                      context,
                      emailController,
                      "Enter your Email",
                      null,
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    textWdgt("Password", screenWidth * 0.04, FontWeight.w400),
                    SizedBox(height: screenHeight * 0.01),

                    customTextFormField(
                      context,
                      passwordController,
                      "Enter your password",
                      Icon(Icons.remove_red_eye_outlined),

                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password required';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: textWdgt(
                            "Forget Password ?",
                            screenWidth * 0.04,
                            FontWeight.w500,
                            Colors.brown,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    if (value.isLoading)
                      Center(child: CircularProgressIndicator())
                    else
                      InkWell(
                        onTap: () async {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: textWdgt(
                                  "Please Enter Both email and password",
                                  screenHeight * 0.03,
                                  FontWeight.w500,
                                ),
                                backgroundColor: const Color(0xFFEFB203),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );

                            return;
                          }

                          final authProvider = Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          );
                          await authProvider.getLogin(email, password);

                          if (authProvider.user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: textWdgt(
                                  "Login Successful",
                                  screenHeight * 0.03,
                                  FontWeight.w500,
                                  Colors.white,
                                ),
                                backgroundColor: Color(0xFFEFB203),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );

                            await Future.delayed(Duration(seconds: 1));

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          } else if (authProvider.error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(authProvider.error!),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: screenHeight * 0.08,
                          decoration: BoxDecoration(
                            gradient: goldGradient,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: textWdgt(
                              "Log in",
                              screenWidth * 0.05,
                              FontWeight.w600,
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        textWdgt("Or", screenWidth * 0.05, FontWeight.w500),
                        SizedBox(width: screenWidth * 0.05),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpVerificationPage(),
                        ),
                      ),
                      child: containerWdgt(
                        screenHeight * 0.08,
                        'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                        " Continue with google",
                        screenWidth * 0.05,
                        FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    containerWdgt(
                      screenHeight * 0.08,
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIou9WTweBF8jIBPf8Mjyxzud5PEiEQpRp2w&s',
                      " Continue with Facebook",
                      screenWidth * 0.05,
                      FontWeight.w500,
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "Don’t have an account? ",
                          children: [
                            TextSpan(
                              text: "Sign up",
                              style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
