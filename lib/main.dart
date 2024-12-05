import "package:flutter/material.dart";
import "package:forms_app/config/router/app_router.dart";
import "package:forms_app/config/theme/theme_app.dart";

void main(List<String> args) {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeApp().getTheme(),
    );
  }
}