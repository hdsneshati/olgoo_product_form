import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olgooproductform/feature/domain/product/entity/product_entity.dart' show TempProduct;
import 'package:olgooproductform/feature/presentation/authentication/bloc/auth/auth.bloc.dart';
import 'package:olgooproductform/feature/presentation/authentication/screens/login.screen.dart';
import 'package:olgooproductform/feature/presentation/authentication/screens/otp.screen.dart';
import 'package:olgooproductform/feature/presentation/authentication/screens/signup.step1.screen.dart';
import 'package:olgooproductform/feature/presentation/authentication/screens/signup_stap2_details_screen.dart';
import 'package:olgooproductform/feature/presentation/product/screens/dashboard_screen.dart';
import 'package:olgooproductform/feature/presentation/product/screens/signup_step3_product.dart';
import 'package:olgooproductform/feature/presentation/product/screens/signup_step4_order.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter routs =
    GoRouter(navigatorKey: navigatorKey, initialLocation: "/login", routes: [
 
 
 GoRoute(
    path: '/login',
    name: "/login",
    builder: (context, state) => LoginScreen(),
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
    path: '/signupdetails',
    name: "/signupdetails",
    builder: (context, state) => SignupDetailsScreen(),
  ),
  
   GoRoute(
    path: '/signupstep3product',
    name: "/signupstep3product",
    builder: (context, state) => SignupStep3Product(),
  ),
   GoRoute(
  path: '/signupstep4order',
  name: "signupstep4order", // بدون / در نام
  builder: (context, state) {
    // گرفتن اطلاعات محصول از صفحه قبل
    final TempProduct tempProduct = state.extra as TempProduct;
    return SignupStep4Order(tempProduct: tempProduct);
  },
),

   GoRoute(
    path: '/dashboard',
    name: "/dashboard",
    builder: (context, state) => DashboardScreen(),
  ),
  
]);
