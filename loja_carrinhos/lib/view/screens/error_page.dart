import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Erro conexao"),),
    );
  }
}