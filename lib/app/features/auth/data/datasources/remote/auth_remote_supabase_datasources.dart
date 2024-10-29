
import 'package:project_management_app/app/core/failures/exceptions/server_exception.dart';
import 'package:project_management_app/app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class IAuthRemoteDataSource{
 Session? get currentUsersession;
 Future<UserModel> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }); 
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }); 
  Future<UserModel?> getCurrentUserData(); 
}
class AuthRemoteSupaBaseDataSourceImpl implements IAuthRemoteDataSource{
  final SupabaseClient supabaseClient;
  AuthRemoteSupaBaseDataSourceImpl(this.supabaseClient);
  
  @override
  Session? get currentUsersession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailPassword({required String email, required String password}) async{
     try {
      final response = await supabaseClient.auth.signInWithPassword(password: password, email: email);
      if (response.user == null) {
        throw ServerException("User is null!");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> singUpWithEmailPassword({required String name,
   required String email,
  required String password})async {
    try {
      final response = await supabaseClient.auth.signUp(password: password, email: email, data:{
        'name' : name
        }
      );
      if (response.user == null) {
        throw ServerException("User is null!");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<UserModel?> getCurrentUserData() async{
   try {
    if (currentUsersession != null) {
      final userData = await supabaseClient.from('profiles').select().eq('id', currentUsersession!.user.id);
      return UserModel.fromJson(userData.first).copyWith(
        email: currentUsersession!.user.email
      );
    }
    return null;
   } catch (e) {
     throw ServerException(e.toString());
   }
  }
}