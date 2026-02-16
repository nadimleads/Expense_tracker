import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
//import 'package:flutter/services.dart'; //locking screen orientation

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 255, 192, 32),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
  //   fn,
  // ) { //to make the app un rotateable (screen lock orienation, etar jonno upore Import ache)
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: kColorScheme,

        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),

        textTheme: ThemeData().textTheme.copyWith(
          headlineLarge: ThemeData().textTheme.headlineLarge,
        ),
      ),
      home: const Expenses(),
    ),
  );
  // });
}
