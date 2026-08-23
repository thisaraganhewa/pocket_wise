import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_wise/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:pocket_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pocket_wise/features/dashboard/presentation/pages/dashboard_page.dart';


class LoginPage extends StatefulWidget {


  const LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state){
          if(state is AuthSuccess){

            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Welcome ${state.user.name}"))
            );

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardPage()));
          }

          if(state is AuthError){

            if (!context.mounted) return;

             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message))
            );
          }
        }, 
        builder: (context, state){
          if(state is AuthLoading){
            return Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleSignInButton(onPressed: (){context.read<AuthBloc>().add(SignInWithGoogleEvent());}),
              ],
            ),
          );

        }
      
      )
    );
  }
}