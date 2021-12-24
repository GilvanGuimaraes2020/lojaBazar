import 'package:flutter/material.dart';

class WCampoNumero extends StatefulWidget {
  final variavel;
  final String rotulo;
  final FormFieldValidator<String> validator;

  const WCampoNumero({ Key key, this.rotulo, this.variavel, this.validator });

  @override
  _WCampoNumeroState createState() => _WCampoNumeroState();
}

class _WCampoNumeroState extends State<WCampoNumero> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.all(2),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.variavel,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: widget.rotulo,
          labelStyle: TextStyle(fontSize: 16),
          filled:  true,
          fillColor: Colors.grey[300]
          
        ),
      ),

      
    );
  }
}