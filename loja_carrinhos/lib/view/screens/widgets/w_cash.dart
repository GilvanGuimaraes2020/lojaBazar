import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/detail_cash_page.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_dialogs.dart';
import 'package:loja_carrinhos/view/screens/form_cash.dart';

class InOrOut{
  String retorno;
}

class Wcash extends StatefulWidget {
  final String title;
  final double total;
  

  const Wcash({ Key key , this.title, this.total}) ;

  @override
  State<Wcash> createState() => _WcashState();
}

class _WcashState extends State<Wcash> {
 InOrOut retorno = new InOrOut();
 bool  status ;
 
  

  @override
  Widget build(BuildContext context) {
    if(widget.total > 0){
      status = true;} else {status = false;}
    return InkWell(
      onTap: (){
        //navegar para pagina detailcash para apresentar detalhes daquela categoria
        Navigator.push(
          context, PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 100),
            pageBuilder:(_ , __ , ___) => DetailCashPage(categoria: widget.title,)));
       
      },
      onLongPress: () async{
      
       await showDialog<String>(
        context: context, 
        builder: (context)=>
          WDialogs(
          title: "Tipo de movimento",
          content: "Entrada ou Saida?",
          retorno: retorno,
        ) ) ;
        
        print(retorno.retorno);
        if (retorno.retorno != null){
          Navigator.push(context,
         PageRouteBuilder(
           transitionDuration: Duration(milliseconds: 100),
           pageBuilder: (_ , __, ___) =>FormCash(title: widget.title,inOrOut: retorno.retorno,)));
        }
        
           
      },
      child: Hero(
        tag: widget.title, 
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
              Text(widget.title , style: TextStyle(color: Colors.black
              , fontSize: MediaQuery.of(context).size.height / 30 ,
              fontWeight: FontWeight.bold ),),
              Text("Total: R\$ ${widget.total}", style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height / 50),
                 ),
               
            ],
          ),
        )),
    );
  }
}