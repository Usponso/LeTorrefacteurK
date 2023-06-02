import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:torrefacteurk/providers/FieldProvider.dart';
import 'package:torrefacteurk/providers/UserProvider.dart';
import 'package:torrefacteurk/screen/HomePage.dart';
import 'package:torrefacteurk/utils/materialColorFromHex.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FieldProvider(),),
      ChangeNotifierProvider(create: (context) => UserProvider(),),
    ],
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Le Torréfacteur K',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff766c42, color),
      ),
      home: const HomePage(title: 'Le Torréfacteur K'),
    );
  }
}
