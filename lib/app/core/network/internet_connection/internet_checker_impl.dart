import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:project_management_app/app/core/network/internet_connection/internet_checker_interface.dart';

class ConnectionCheckerImpl implements IConnectionChecker{
  final InternetConnection internetConnection;
  ConnectionCheckerImpl(this.internetConnection);
  @override
  Future<bool> get isConnected async =>  await internetConnection.hasInternetAccess;

}

class ConnectionChecker2Impl implements IConnectionChecker{
  final InternetConnectionChecker internetConnection;
  ConnectionChecker2Impl(this.internetConnection);
  @override
  Future<bool> get isConnected async =>  await internetConnection.hasConnection;

}