import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pocket_wise/domain/usecases/sign_in_with_google_use_case.dart';


class LoginPage extends StatefulWidget {

  SignInWithGoogleUseCase _userUseCase =GetIt.I<SignInWithGoogleUseCase>();

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
          ElevatedButton(onPressed: (){
            widget._userUseCase.logOrRegister();
          }, child: Text("Log in With Google"))
        ],
      ),
    );
  }
}