import 'package:flutter/material.dart';
import 'login.dart'; // LoginPage dosyasını import ediyoruz

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // Uygulama LoginPage ile başlar
    );
  }
}
