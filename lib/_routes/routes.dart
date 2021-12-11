import 'package:flutter/material.dart';
import 'package:xgensys_machine_test/_routes/route_names.dart';
import 'package:xgensys_machine_test/home/home_screen.dart';
import 'package:xgensys_machine_test/login/login_screen.dart';

class Routes {
  Map<String, WidgetBuilder> buildRoutes(BuildContext context) {
    return <String, WidgetBuilder>{
      RouteNames.login: (context) => LoginScreen(),
      RouteNames.main: (context) => HomeScreen(),
    };
  }
}