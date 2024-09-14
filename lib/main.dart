import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/auth/register/register_screen.dart';
import 'package:todo/home/home_screen.dart';
import 'package:todo/home/task_list/edit_task_screen.dart';
import 'package:todo/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo/provider/app_config_provider.dart';
import 'package:todo/provider/auth_provider.dart';
import 'package:todo/splash_screen/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyAGdC7FIoo-E_2QgCTXlkF7Oi0qozASxq0',
              appId: 'com.example.todo',
              messagingSenderId: '1076831558332',
              projectId: 'todo-624bf'),
        )
      : await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppConfigProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider1())
      ],
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
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: "ToDo App",
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        EditTaskScreen.routeName: (context) => const EditTaskScreen(),
      },
      initialRoute: SplashScreen.routeName,
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darkMode,
      themeMode: provider.appTheme,
      locale: Locale(provider.appLanguage),
    );
  }
}
