import 'package:firebase_chat/firebase_options.dart';
import 'package:firebase_chat/providers/user_provider.dart';
import 'package:firebase_chat/screens/splash_screen.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: "Poppins",
      ),
      home: SplashScreen(),
    );
  }
}
