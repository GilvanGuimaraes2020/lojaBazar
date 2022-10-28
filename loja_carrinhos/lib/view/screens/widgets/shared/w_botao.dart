import 'package:flutter/material.dart';

class WBotao extends StatelessWidget {
  final String rotulo;
  final Color cor ;
  WBotao({this.rotulo,  this.cor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.all(2),
      height: MediaQuery.of(context).size.height/12,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [BoxShadow(
          color: Colors.blue[200],
          blurRadius: 4,
          offset: Offset(2 , 6)
        ),] 
      ),
      child: Center(
        child: Text(
          rotulo, style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}