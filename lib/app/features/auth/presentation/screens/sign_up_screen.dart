import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_management_app/app/core/common/widgets/loader.dart';
import 'package:project_management_app/app/core/constants/app_colors.dart';
import 'package:project_management_app/app/core/constants/app_textstyle.dart';
import 'package:project_management_app/app/core/enums/route_path.dart';
import 'package:project_management_app/app/core/utils/show_snackbar.dart';
import 'package:project_management_app/app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:project_management_app/app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:project_management_app/app/features/auth/presentation/widgets/auth_textfiled.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>(); 
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Padding(
        padding:const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state){
            if (state is AuthFailureState) {
              showSnackBar(context, state.message);
            }else if(state is AuthSuccessState){
              RoutePath.project.pushAndRemoveUntil(context);
            }
          },
          builder: (context, state) {
            if(state is AuthLoadingState){
              return const Loader();
            }
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Sign up",
                    style:AppTextStyle.titleStyle1
                  ),
                  const SizedBox(height: 30,),
                  AuthTextField(title: "Name", controller: _nameController,),
                  const SizedBox(height: 10,),
                  AuthTextField(title: "Email", controller: _emailController),
                  const SizedBox(height: 10,),
                  AuthTextField(title: "Password", controller: _passwordController, obscureText: true,),
                  const SizedBox(height: 10,),
                  AuthGradientButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                     context.read<AuthBloc>().add(
                      AuthSingUpEvent(
                        email: _emailController.text.trim(), 
                        name: _nameController.text.trim(), 
                        password: _passwordController.text.trim())); 
                    }
                  }, title: "Sign Up"),
                  const SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){
                      RoutePath.signIn.push(context);
                    },
                    child: RichText(text: TextSpan(
                      style: Theme.of(context).textTheme.titleMedium,
                      text: "Already have an account?",
                      children: [
                        TextSpan(text:" Sign In",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColor.gradient2Color )),
                      ]),
                    ),
                  ),
                ]
              ,),
            );
          }
        ),
      ) 
    ,);
  }
}