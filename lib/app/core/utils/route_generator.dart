import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_management_app/app/core/common/cubits/user_cubit/app_user_cubit.dart';
import 'package:project_management_app/app/core/constants/app_colors.dart';
import 'package:project_management_app/app/core/enums/route_path.dart';
import 'package:project_management_app/app/features/auth/presentation/screens/login_screen.dart';
import 'package:project_management_app/app/features/auth/presentation/screens/sign_up_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    if(settings.name == RoutePath.home.path){
      return _buildRoute(settings, Container());
    }else if(settings.name == RoutePath.signIn.path) {
       return _buildRoute(settings, const LoginScreen());
    }else if(settings.name == RoutePath.signUp.path) {
       return _buildRoute(settings, const SignUpScreen());
    }else{
      return _errorRoute();
    }   
  }

  static MaterialPageRoute _buildRoute(
    RouteSettings settings,
    Widget builder, {
    bool needsAuth = false,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) => state is AppUserLoggedInState,
          builder: (context, isLoggedIn) {
            if (needsAuth && !isLoggedIn) {
              return const LoginScreen();
            }
            return builder;
          },
        );
      },
      settings: settings,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      var responsise = MediaQuery.of(context);
      return Scaffold(
        body: Container(
          color: AppColor.primaryColor,
          child: Stack(
            children: [
              Positioned(
                top: responsise.size.height * 0.001,
                child: Container(
                  height: responsise.size.height * 0.47,
                  width: responsise.size.width * 0.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('ImagePath.logoImage'),
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Tela não encontrada!",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Voltar!",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
