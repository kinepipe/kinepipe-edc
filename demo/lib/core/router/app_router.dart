import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/evaluation/presentation/evaluation_flow_screen.dart';
import '../../features/configuration/presentation/module_manager_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/user_manager_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      
      if (authState == null && !isLoggingIn) {
        return '/login';
      }
      if (authState != null && isLoggingIn) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/module_manager',
        builder: (context, state) => const ModuleManagerScreen(),
      ),
      GoRoute(
        path: '/user_manager',
        builder: (context, state) => const UserManagerScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/evaluation',
        builder: (context, state) => const EvaluationFlowScreen(),
      ),
    ],
  );
});
