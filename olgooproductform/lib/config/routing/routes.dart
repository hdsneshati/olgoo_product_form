import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olgooproductform/feature/presentation/dashboard/screens/dashboard_screen.dart';
import 'package:olgooproductform/feature/presentation/dashboard/screens/signup_step3_product.dart';
import 'package:olgooproductform/feature/presentation/dashboard/screens/signup_step4_order.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter routs =
    GoRouter(navigatorKey: navigatorKey, initialLocation: "/dashboard", routes: [
 
 
 
 
 
   
  
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
    path: '/dashboard',
    name: "/dashboard",
    builder: (context, state) => DashboardScreen(),
  ),
  
]);
