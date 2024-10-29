import 'package:fpdart/fpdart.dart';
import 'package:project_management_app/app/core/failures/failure.dart';
import 'package:project_management_app/app/core/usecases/usecase.dart';
import 'package:project_management_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:project_management_app/app/features/auth/domain/respository/auth_repository.dart';

class UserSignIn implements UseCase<User, UserSignInParams>{
  final AuthRepository authRepository;
  const UserSignIn(this.authRepository);
  
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async{
   return await authRepository.loginpWithEmailPassword(
      email: params.email, 
      password: params.password
    );
  }
 
}
class UserSignInParams{
  final String email;
  final String password;
  UserSignInParams({
    required this.email, 
    required this.password
    });
  }