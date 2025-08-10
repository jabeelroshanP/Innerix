// import 'dart:developer';

// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:innerix/controller/auth_provider.dart';
// import 'package:innerix/controller/best_offers_provider.dart';
// import 'package:innerix/controller/bottom_nav_bar_provider.dart';
// import 'package:innerix/controller/carousel_provider.dart';
// import 'package:innerix/controller/categories_provider.dart';
// import 'package:innerix/controller/otp_provider.dart';
// import 'package:innerix/controller/product_view_provider.dart';
// import 'package:innerix/controller/top_sellingProvider.dart';
// import 'package:innerix/view/get_start/page1.dart';
// import 'package:innerix/view/login/login.dart';
// import 'package:innerix/view/home/home.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// late bool isLoggedIn;
// late bool isOnboardingCompleted;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('access_token');
//   isLoggedIn = token != null && token.trim().isNotEmpty;
//   log("Token at startup: $token");

//   isOnboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

//   runApp(DevicePreview(builder: (context) => const MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => CategoriesProvider()),
//         ChangeNotifierProvider(create: (context) => AuthProvider()),
//         ChangeNotifierProvider(create: (context) => CarouselProvider()),
//         ChangeNotifierProvider(create: (context) => TopSellingProvider()),
//         ChangeNotifierProvider(create: (context) => BestOfferProvider()),
//         ChangeNotifierProvider(create: (context) => ProductProvider()),
//         ChangeNotifierProvider(create: (context) => OtpProvider()),
//         ChangeNotifierProvider(create: (context) => BottomNavProvider()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         builder: DevicePreview.appBuilder,
//         useInheritedMediaQuery: true,
//         theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF9F9F9)),
//         home: isOnboardingCompleted
//             ? (isLoggedIn ? const HomePage() : const LoginPage())
//             : OnboardingScreen()
//       ),
//     );
//   }
// }



import 'dart:developer';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:innerix/controller/auth_provider.dart';
import 'package:innerix/controller/best_offers_provider.dart';
import 'package:innerix/controller/bottom_nav_bar_provider.dart';
import 'package:innerix/controller/carousel_provider.dart';
import 'package:innerix/controller/categories_provider.dart';
import 'package:innerix/controller/otp_provider.dart';
import 'package:innerix/controller/product_view_provider.dart';
import 'package:innerix/controller/top_sellingProvider.dart';
import 'package:innerix/view/bottom_nav/bottom_nav_bar.dart';
import 'package:innerix/view/get_start/page1.dart';
import 'package:innerix/view/login/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late bool isLoggedIn;
late bool isOnboardingCompleted;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  isLoggedIn = token != null && token.trim().isNotEmpty;
  log("Token at startup: $token");

  isOnboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

  runApp(DevicePreview(builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CarouselProvider()),
        ChangeNotifierProvider(create: (context) => TopSellingProvider()),
        ChangeNotifierProvider(create: (context) => BestOfferProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => OtpProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: DevicePreview.appBuilder,
        useInheritedMediaQuery: true,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF9F9F9)),
        home: isOnboardingCompleted
            ? (isLoggedIn ?  BottomNavBar() : const LoginPage()) 
            : OnboardingScreen(),
      ),
    );
  }
}
