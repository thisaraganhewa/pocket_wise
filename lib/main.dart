import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pocket_wise/core/di/injection_container.dart' as di;
import 'package:pocket_wise/firebase_options.dart';
import 'package:pocket_wise/features/auth/presentation/pages/home_page.dart';
import 'package:pocket_wise/features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginPage(),
    );
  }
}




