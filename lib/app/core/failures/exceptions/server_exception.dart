import 'package:project_management_app/app/core/failures/exceptions/exception_interface.dart';

class ServerException extends IException{
  ServerException([super.message = "Occorreu uma excepção de servidor"]);

}