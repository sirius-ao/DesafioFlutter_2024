import 'package:fpdart/fpdart.dart';
import 'package:project_management_app/app/core/failures/failure.dart';

abstract interface class UseCase<SuccessType, Params>{
  Future<Either<Failure, SuccessType>> call(Params params);
}