import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_flutter/constants/all_constants.dart';
import 'package:evolve_flutter/features/login/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => ApiClientContext(
                  requestConfigurator: ApiRequestConfigurator()))
        ],
        child: MaterialApp(
          title: TextConstant.appName,
          theme: ThemeData(
            primarySwatch: Colors.red,
            primaryColor: ColorConstant.primary,
          ),
          home: const SplashPage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
