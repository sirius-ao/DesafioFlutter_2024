import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_management_app/app/features/auth/domain/entities/user_entity.dart';
part 'app_user_state.dart';
class AppUserCubit extends Cubit<AppUserState>{
  AppUserCubit(): super(AppUserInitialState());

  void updateUser(User? user){
    if(user == null){
      emit(AppUserInitialState());
    }else{
      emit(AppUserLoggedInState(user));
    }

  }
}