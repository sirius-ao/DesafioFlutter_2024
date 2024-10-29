import 'package:fpdart/fpdart.dart';
import 'package:project_management_app/app/core/failures/failure.dart';
import 'package:project_management_app/app/core/usecases/usecase.dart';
import 'package:project_management_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:project_management_app/app/features/auth/domain/respository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams>{
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async{
   return await authRepository.singUpWithEmailPassword(
      name: params.name, 
      email: params.email, 
      password: params.password
    );
  }

}
class UserSignUpParams{
  final String name;
  final String email;
  final String password;
  UserSignUpParams({
    required this.name, 
    required this.email, 
    required this.password
    });
  }