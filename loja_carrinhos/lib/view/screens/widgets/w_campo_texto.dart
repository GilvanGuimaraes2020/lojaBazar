import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/shared/fonts/style.dart';
import 'package:loja_carrinhos/view/shared/messages/messages.dart';

class WcampoTexto extends StatelessWidget {
  final variavel;
  final String rotulo;
  final bool senha;
  final IconButton icon;
  final FormFieldValidator<String> validator;
  Style style = new Style();
  WcampoTexto({ this.variavel, this.rotulo, this.senha, this.icon, this.validator });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: variavel,
        style: style.style(),
        obscureText: senha,

        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(fontSize: 16),
          hintText: Messages("informacao").returnMessage()
        ),
      ),
    );
  }
}