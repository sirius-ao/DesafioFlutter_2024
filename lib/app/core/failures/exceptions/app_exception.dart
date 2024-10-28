import 'package:project_management_app/app/core/failures/exceptions/exception_interface.dart';

class AppException extends IException{
  AppException([super.message = "Occorreu uma excepção do app"]);
}