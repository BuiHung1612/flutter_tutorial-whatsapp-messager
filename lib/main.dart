import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/common/routes/routes.dart';
import 'package:whatsapp_messenger/common/themes/dark_theme.dart';
import 'package:whatsapp_messenger/common/themes/light_theme.dart';
import 'package:whatsapp_messenger/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_messenger/feature/home/pages/home_page.dart';
import 'package:whatsapp_messenger/feature/welcome/pages/welcome_page.dart';
import 'package:whatsapp_messenger/firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // these keeps the splash screen on untill it loaded up all neccessary data
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Whatsapp',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: ref.watch(userInfoAuthProvider).when(data: (user) {
        FlutterNativeSplash.remove();
        if (user == null) return const WelcomePage();
        return const HomePage();
      }, error: (error, trace) {
        return const Scaffold(
          body: Center(child: Text("Something wrong happened!")),
        );
      }, loading: () {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
