import 'package:fpdart/fpdart.dart';
import 'package:project_management_app/app/core/failures/failure.dart';
import 'package:project_management_app/app/core/usecases/usecase.dart';
import 'package:project_management_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:project_management_app/app/features/auth/domain/respository/auth_repository.dart';
class CurrentUser implements UseCase<User, NoParams>{
  final AuthRepository authRepository; 
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams paurams) async {
   return await authRepository.getCurrentUser();
  }

}
class NoParams{}