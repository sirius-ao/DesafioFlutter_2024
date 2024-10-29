import 'package:fpdart/fpdart.dart';
import 'package:project_management_app/app/core/failures/failure.dart';
import 'package:project_management_app/app/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository{
  Future<Either<Failure, User>> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginpWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> getCurrentUser();
}