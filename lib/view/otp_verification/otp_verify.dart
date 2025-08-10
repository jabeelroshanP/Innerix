import 'package:flutter/material.dart';
import 'package:innerix/controller/otp_provider.dart';
import 'package:innerix/view/home/home.dart';
import 'package:innerix/widgets/widgets.dart';
import 'package:provider/provider.dart';

class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({super.key});

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LinearGradient goldGradient = const LinearGradient(
      colors: [Color(0xFFEFB203), Color(0xFFCE8800)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Consumer<OtpProvider>(
            builder: (context, otpProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.05),

                  Text(
                    "Let’s verify\nYour Google Account",
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: screenWidth * 0.035,
                      ),
                      children: [
                        const TextSpan(text: "Enter the OTP code we sent to "),
                        const TextSpan(
                          text: "musavir.mate@gmail.com.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: " Need to "),
                        const TextSpan(
                          text: "edit the email",
                          style: TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.035),

                  TextField(
                    controller: otpController,
                    style: TextStyle(fontSize: screenWidth * 0.04),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter your OTP",
                      hintStyle: TextStyle(fontSize: screenWidth * 0.04),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.018,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  Center(
                    child: Text(
                      "Resend code in (00:16)",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  InkWell(
                    onTap: () async {
                      final otp = otpController.text.trim();
                      if (otp.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter OTP")),
                        );
                        return;
                      }

                      await otpProvider.verifyOtp(
                        "musavir.mate@gmail.com",
                        otp,
                      );

                      if (otpProvider.otpVerify != null &&
                          otpProvider.otpVerify!.status) {
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: textWdgt(
                              "Incorrect OTP",
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
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        gradient: goldGradient,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: Center(
                        child: otpProvider.isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : textWdgt(
                                "Verify OTP",
                                screenWidth * 0.045,
                                FontWeight.w600,
                                Colors.white,
                              ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
