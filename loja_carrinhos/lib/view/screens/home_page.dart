import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key, this.title }) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var ctrlLogin = TextEditingController();
  var ctrlSenha = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}