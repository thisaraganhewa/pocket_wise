import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pocket_wise/domain/usecases/user.dart';

class LoginPage extends StatefulWidget {

  User _userUseCase =GetIt.I<User>();

  LoginPage();

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
          kIsWeb 
          ? ElevatedButton(onPressed: (){
            widget._userUseCase.logOrRegister();
          }, child: Text("Log in With Google"))
          : ElevatedButton(onPressed: (){
            widget._userUseCase.logOrRegister();
          }, child: Text("Log in With Google"))
        ],
      ),
    );
  }
}