import 'package:flutter/material.dart';

class ConfirmarDados extends StatefulWidget {
  Map<String , dynamic> mapCash;
  String title;
  ConfirmarDados({ Key key, this.mapCash, this.title });

  @override
  _ConfirmarDadosState createState() => _ConfirmarDadosState();
}

class _ConfirmarDadosState extends State<ConfirmarDados> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber[200],
      title: Text(widget.title),
      content: verificaLista(widget.mapCash),
      actions: [
        ElevatedButton(
          onPressed: ()=>retornaValor(true), 
          child: Text("Sim")),
        ElevatedButton(
          onPressed: ()=>retornaValor(false), 
          child: Text("Não"))
      ],
      
    );
  }
  verificaLista(Map<String , dynamic> lista){
    List k = lista.keys.toList();
    List v = lista.values.toList();
    return Container(
      height: 300,
      width: 300,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(k.length,(index) {
            return Text("${k[index]} : ${v[index]}");
          }) ,
        ),
      ),
    );
  }
  retornaValor(bool status){
    Navigator.pop(context , [status]);
  }
}