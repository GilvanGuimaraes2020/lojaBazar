import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_dialog_cash.dart';

class Wcash extends StatelessWidget {
  final String title;
  final double input , output, mes;
  final bool status;

  const Wcash({ Key key , this.title, this.input, this.output, this.status, this.mes}) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print("Voce clicou");
      },
      onLongPress: (){
        Navigator.push(context,
         PageRouteBuilder(
           transitionDuration: Duration(milliseconds: 100),
           pageBuilder: (_ , __, ___) =>WDialogCash(title: title,)));
           
      },
      child: Hero(
        tag: title, 
        child: Container(
          margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            color: status ? Colors.green[300] :
            Colors.red[200],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 4,
                offset: Offset(2 , 4)
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(title , style: TextStyle(color: Colors.black
              , fontSize: MediaQuery.of(context).size.height / 30 ,
              fontWeight: FontWeight.bold ),),
              Text("Entrada: $input", style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height / 50),
                 ),
                Text("Saida: $output", style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height / 50),
                 ),
            ],
          ),
        )),
    );
  }
}