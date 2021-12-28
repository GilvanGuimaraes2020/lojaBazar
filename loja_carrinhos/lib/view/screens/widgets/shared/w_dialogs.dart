import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_cash.dart';

// ignore: must_be_immutable
class WDialogs extends StatefulWidget {
  String title;
  String content;
  InOrOut retorno = new InOrOut();
   WDialogs({ Key key, this.title, this.content, this.retorno}) ;

  @override
  State<WDialogs> createState() => _WDialogsState();
}

class _WDialogsState extends State<WDialogs> {
  @override
  Widget build(BuildContext context)  {
    return AlertDialog(
      title: Text(widget.title) ,
      content: Text(widget.content),
      backgroundColor: Colors.purple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 30,
      actions: [
        ElevatedButton(
          
          style: ButtonStyle(
          
             backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 123, 39, 202)) ,
          ),
          onPressed: (){
            setState(() {
              widget.retorno.retorno = "Entrada";
              Navigator.pop(context);
            });
          }, 
          child: Text("Entrada")),
           ElevatedButton(
             style: ButtonStyle(
          
             backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 123, 39, 202)) ,
          ),
          onPressed: (){
            setState(() {
              widget.retorno.retorno = "Saida";
              Navigator.pop(context);
            });
          }, 
          child: Text("Saida")),
      ],
    );
    
  }
}