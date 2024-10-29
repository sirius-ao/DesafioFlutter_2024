import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_management_app/app/core/common/cubits/user_cubit/app_user_cubit.dart';
import 'package:project_management_app/app/core/constants/app_theme.dart';
import 'package:project_management_app/app/core/utils/route_generator.dart';
import 'package:project_management_app/app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:project_management_app/app/features/auth/presentation/screens/login_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Managment App',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: AppTheme.darkTheme,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) => state is AppUserLoggedInState,
        builder: (context, isLoggedin) {
          if (isLoggedin) {
            return  Container(); //BlogScreen();
          }
          return const LoginScreen();
        }
      ),
    );
  }
}