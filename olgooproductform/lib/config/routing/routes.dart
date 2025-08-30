/*import 'package:flutter/material.dart';
import 'package:flutter_olgoo_product/feature/presentation/authentication/screens/login.screen.dart';
import 'package:flutter_olgoo_product/feature/presentation/authentication/screens/otp.screen.dart';
import 'package:flutter_olgoo_product/feature/presentation/authentication/screens/signup.step1.screen.dart';
import 'package:flutter_olgoo_product/feature/presentation/authentication/screens/signup_stap2_details_screen.dart';
import 'package:flutter_olgoo_product/feature/presentation/dashboard/screens/signup_step3_product.dart';
import 'package:flutter_olgoo_product/feature/presentation/dashboard/screens/signup_step4_order.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter routs =
    GoRouter(navigatorKey: navigatorKey, initialLocation: "/signupstep4order", routes: [
 
 
 
 
  GoRoute(
    path: '/login',
    name: "/login",
    builder: (context, state) => const LoginScreen(),
  ),
   GoRoute(
      path: '/otp',
      name: "/otp",
      builder: (context, state) {
        final String userPhoneNumber = state.extra as String;
        return OtpScreen(
         userPhoneNumber: userPhoneNumber,
       );
      }),
  GoRoute(
    path: '/signup',
    name: "/signup",
    builder: (context, state) => SignupScreen(),
  ),
   GoRoute(
    path: '/signupstep3product',
    name: "/signupstep3product",
    builder: (context, state) => SignupStep3Product(),
  ),
   GoRoute(
    path: '/signupstep4order',
    name: "/signupstep4order",
    builder: (context, state) => SignupStep4Order(),
  ),
   GoRoute(
    path: '/details',
    name: "/details",
    builder: (context, state) => SignupDetailsScreen(),
),
  
]);*/
