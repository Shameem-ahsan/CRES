import 'package:flutter/material.dart';
import 'package:xgensys_machine_test/_routes/route_names.dart';
import 'package:xgensys_machine_test/_routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: RouteNames.login,
      routes: Routes().buildRoutes(context),
    );
  }
}

