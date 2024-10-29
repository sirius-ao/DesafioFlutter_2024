import 'package:flutter/material.dart';

enum RoutePath {
  home('/home'),
  signIn('/signIn'),
  signUp('/signUp'),
  forgotPassword('/forgot/password'),
  verifyCode('/verify/code'),
  resetPassWord('/reset/password'),
  contact('/contact'),
  showProject('show/project');

  const RoutePath(
    this.path,
  );

  final String path;

  void push(BuildContext context, {Object? extra}) => Navigator.of(context).pushNamed(path, arguments: extra);

  void pushAndRemoveUntil(BuildContext context, {Object? extra}) => Navigator.of(context).pushNamedAndRemoveUntil(path, (route) => false, arguments: extra);
  
  void pushReplacement(BuildContext context, {Object? extra}) => Navigator.of(context).pushReplacementNamed(path, arguments: extra);

  void popUntil(BuildContext context) => Navigator.of(context).popUntil(
    (Route<dynamic> route) => route.settings.name == path,
  );
}