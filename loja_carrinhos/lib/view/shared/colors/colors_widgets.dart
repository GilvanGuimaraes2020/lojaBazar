import 'package:flutter/material.dart';

class ColorsWidget{
  
  Color colorwidget(String item){
    
        return  item.contains('Andador')?
                Colors.green[900]:
                item.contains('Carrinho')?
                Colors.blue[200]:
                item.contains('Cadeirão')?
                Colors.red[700]:
                 item.contains('Banheira')?
                Colors.yellow[200]:
                 item.contains('Berço')?
                Colors.pink[200]:
                 item.contains('Cadeira')?
                Colors.brown:
                 item.contains('Cadeirinha')?
                Colors.yellow[600]:
                 item.contains('Bebe')?
                Colors.purple[700]:
                item.contains('Lote')?
                Colors.green[200]:
                Colors.transparent;
  }
}