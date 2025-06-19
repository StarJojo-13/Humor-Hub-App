import 'package:flutter/material.dart';
import 'screens/menu_principal.dart';

void main() => runApp(ChistesApp());

class ChistesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chistes App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: MenuPrincipal(),
    );
  }
}