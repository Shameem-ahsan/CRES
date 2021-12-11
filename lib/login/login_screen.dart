import 'package:flutter/material.dart';
import 'package:xgensys_machine_test/_routes/route_names.dart';
import 'package:xgensys_machine_test/common_widget/alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'CRES',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Log in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () {
                        // print(nameController.text);
                        // print(passwordController.text);
                        perform_login();
                      },
                    )),
              ],
            )));
  }

  void perform_login() {
    if(nameController.text=="admin"&&passwordController.text=="admin"){
      Navigator.pushNamed(context, RouteNames.main);
    }
    else{
      Alert.showSimpleAlert(context,
          title: 'Login Failed',
          message: "Invalid User Credentials",
          buttonTitle: 'Okay',
          onPressed: () =>  Navigator.pop(context));
    }

  }
}
