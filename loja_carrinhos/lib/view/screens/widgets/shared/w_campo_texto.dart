import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/shared/fonts/style.dart';


class WcampoTexto extends StatefulWidget {
  final variavel;
  final String rotulo;
  final bool senha;
  final IconButton icon;
  final  validator;
  bool enable = true; 

  WcampoTexto({ this.variavel, this.rotulo, this.senha, this.icon, this.validator, this.enable });

  @override
  State<WcampoTexto> createState() => _WcampoTextoState();
}

class _WcampoTextoState extends State<WcampoTexto> {
  Style style = new Style();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.all(2),
      child: TextFormField(
        
        controller: widget.variavel,
        style: style.style(),
        obscureText: widget.senha,
        validator: widget.validator,
        enabled: widget.enable,
        decoration: InputDecoration(
          labelText: widget.rotulo,
          labelStyle: TextStyle(fontSize: 16),
          filled: true,
          fillColor: Colors.grey[300],
          suffixIcon: widget.icon !=null ? widget.icon : null
        ),
      ),
    );
  }
}