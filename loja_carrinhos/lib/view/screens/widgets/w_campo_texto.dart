import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/shared/fonts/style.dart';
import 'package:loja_carrinhos/view/shared/messages/messages.dart';

class WcampoTexto extends StatefulWidget {
  final variavel;
  final String rotulo;
  final bool senha;
  final IconButton icon;
  final FormFieldValidator<String> validator;

  WcampoTexto({ this.variavel, this.rotulo, this.senha, this.icon, this.validator });

  @override
  State<WcampoTexto> createState() => _WcampoTextoState();
}

class _WcampoTextoState extends State<WcampoTexto> {
  Style style = new Style();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: widget.variavel,
        style: style.style(),
        obscureText: widget.senha,
        validator: widget.validator,

        decoration: InputDecoration(
          labelText: widget.rotulo,
          labelStyle: TextStyle(fontSize: 16),
          hintText: Messages("informacao").returnMessage()
        ),
      ),
    );
  }
}