import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_auth/providers/setting_provider.dart';
import 'package:provider/provider.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingProvider(),
        )
      ],
      child: ThemeProvider(
        initTheme: kDarkTheme,
        child: Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeProvider.of(context),
              home: WelcomeScreen(),
              title: 'Eng Test',
            );
          },
        ),
      ),
    );
  }
}
