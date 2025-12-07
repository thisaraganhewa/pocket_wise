import 'package:flutter/material.dart';
import 'package:pocket_wise/domain/usecases/user.dart';

class LoginPage extends StatefulWidget {

  final User _userUseCase;

  LoginPage(this._userUseCase);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            widget._userUseCase.logOrRegister();
          }, child: Text("Log in With Google"))
        ],
      ),
    );
  }
}