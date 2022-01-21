import 'package:flutter/material.dart';
import 'package:loja_carrinhos/data/connDataBase/readInitial/read_movimentoCaixa.dart';

class DetailCashPage extends StatefulWidget {
  final String categoria;
  
  const DetailCashPage({ Key key, this.categoria }) ;

  @override
  State<DetailCashPage> createState() => _DetailCashPageState();
}

class _DetailCashPageState extends State<DetailCashPage> {
  
  readDetalhe()async{
    
    return ReadMovimento().readDados(widget.categoria);
  }
  
  @override
  Widget build(BuildContext context) {
   //List<MDBEntradasCash> entradas = ReadMovimento().readDados();
   return Scaffold(
      appBar: AppBar(
        title: Text("Detalhamento de conta #${widget.categoria}#"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Data"),
                    Text("Detalhe"),
                    Text("Tipo"),
                    Text("Valor")
                ],
              ),
              FutureBuilder(
                future: readDetalhe(),
                builder:(context , snapshot){
                  
                  if (snapshot.hasData){
                    
                     return ListView.builder(
                       itemCount: snapshot.data.length,
                       padding: EdgeInsets.all(5),          
                       shrinkWrap: true,
                       itemBuilder: (context , ind){
                         return Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.blue)),
                              color: snapshot.data[ind].status == "Entrada" 
                              ? Colors.blue[100]
                              : Colors.red[200]
                            ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               Text(snapshot.data[ind].dia),
                               Text("${snapshot.data[ind].detalhe}"),
                               Text("${snapshot.data[ind].operacao}"),
                               Text("R\$ ${snapshot.data[ind].valor}"),                          
                             ],
                           ),
                         );
                       });
                  } else if(snapshot.hasError){
                    return Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      );
                  } else{
                    return CircularProgressIndicator();
                  }
                  
                   
                }
              ),
            ],
          ),
        ),
      ),

    );
  }
}

 