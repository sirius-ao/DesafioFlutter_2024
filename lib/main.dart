import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_management_app/app/core/common/cubits/user_cubit/app_user_cubit.dart';
import 'package:project_management_app/app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:project_management_app/init_dependences.dart';
import 'package:project_management_app/main_config.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependences();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create:(_) => servicelocator<AppUserCubit>()
      ),
      BlocProvider(
        create:(_) => servicelocator<AuthBloc>()
      ),
      //BlocProvider(
      //  create:(_) => servicelocator<BlogBloc>()
      //),
    ],
    child: const MyApp()));
}


