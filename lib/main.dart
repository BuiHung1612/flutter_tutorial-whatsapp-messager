import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/routes/routes.dart';
import 'package:whatsapp_messenger/common/themes/dark_theme.dart';
import 'package:whatsapp_messenger/common/themes/light_theme.dart';
import 'package:whatsapp_messenger/feature/auth/pages/login_page.dart';
import 'package:whatsapp_messenger/feature/auth/pages/user_info_page.dart';
import 'package:whatsapp_messenger/feature/auth/pages/verification_page.dart';
import 'package:whatsapp_messenger/feature/welcome/pages/welcome_page.dart';
import 'package:whatsapp_messenger/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
