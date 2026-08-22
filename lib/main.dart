import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_wise/core/di/injection_container.dart' as di;
import 'package:pocket_wise/core/theme/app_theme.dart';
import 'package:pocket_wise/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:pocket_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pocket_wise/firebase_options.dart';
import 'package:pocket_wise/features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const PocketWiseApp());
}

class PocketWiseApp extends StatelessWidget {
  const PocketWiseApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(di.sl<SignInWithGoogleUseCase>()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        home: LoginPage(),
      ),
    );
  }
}




