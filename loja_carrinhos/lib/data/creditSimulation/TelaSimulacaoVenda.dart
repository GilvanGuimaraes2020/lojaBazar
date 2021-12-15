import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimulacaoVenda extends StatefulWidget {
  @override
  _SimulacaoVendaState createState() => _SimulacaoVendaState();
}

class _SimulacaoVendaState extends State<SimulacaoVenda> {
 
  String operacao = "Credito";
  String valor = "Liquido";
  bool visLiquido = false;
  bool visBruto = false;
  double taxa;
  double result;
  double parcelas;
  var valorControl = TextEditingController();
  var parcelaControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simular Venda"),
      ),
          body: SingleChildScrollView(
                      child: Container(
              padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   DropdownButton<String>(
                            value: operacao,
                            items: <String>['Credito' , 'Debito' ]
                            .map<DropdownMenuItem <String>>((String value){
                              return DropdownMenuItem <String>(
                                value: value,
                                child: Text(
                                  value , style: TextStyle(fontSize: 16),
                                ));
                            } ).toList(), 
                            onTap: (){
                              setState(() {
                                valorControl.text = "";
                                parcelaControl.text = "";
                                visLiquido = false;
                                visBruto = false;
                              });
                            },                            
                            onChanged: (String newValue){
                              setState(() {
                                operacao = newValue;
                                print(operacao);
                              });
                            }),
                             DropdownButton<String>(
                            value: valor,
                            items: <String>['Liquido' , 'Bruto' ]
                            .map<DropdownMenuItem <String>>((String value){
                              return DropdownMenuItem <String>(
                                value: value,
                                child: Text(
                                  value , style: TextStyle(fontSize: 16),
                                ));
                            } ).toList(), 
                            onTap: (){
                              setState(() {
                                valorControl.text = "";
                                parcelaControl.text = "";
                                visLiquido = false;
                                visBruto = false;
                              });
                            },
                            onChanged: (String newValue){
                              setState(() {
                                valor = newValue;
                                print(valor);
                              });
                            }),

                 ],
               ),

              TextField(
                decoration: InputDecoration(
                  labelText: valor == "Liquido"?
                  'Digite valor que quer receber liquido' :
                  'Digite valor bruto da venda' ,
                ),
                controller: valorControl,
              
              ),
               TextField(
                decoration: InputDecoration(
                  labelText: 'Digite Quantidade de Parcelas' ,
                ),
                controller: parcelaControl,
                enabled: operacao=="Credito",
              
              ),

              ElevatedButton(
                child: Text("Calcular"),
                /* shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                    ),
                    color: Colors.blue[200], */
                style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
                onPressed: (){
                  setState(() {
                     if (valor=="Liquido"){
                    visLiquido = true;
                    visBruto = false;
                  } else if (valor == "Bruto"){
                     visLiquido = false;
                    visBruto = true;
                  }
                  });
                 
                 if(operacao == "Debito"){
                    taxa = 0.019;
                    visLiquido == true ?
                     result = double.parse(valorControl.text) * (taxa + 1):
                     result = double.parse(valorControl.text) * ( 1 - taxa)  ;

                  } else if (operacao == "Credito"){
                     if (int.parse(parcelaControl.text) > 1 ){

                    taxa = 0.039;
                     visLiquido == true ?
                     result = double.parse(valorControl.text) * (taxa + 1):
                     result = double.parse(valorControl.text) * ( 1 - taxa)  ;
                    
                    parcelas = result / double.parse(parcelaControl.text);

                   } else if(int.parse(parcelaControl.text) == 1 ){

                     taxa = 0.031;
                      visLiquido == true ?
                     result = double.parse(valorControl.text) * (taxa + 1):
                     result = double.parse(valorControl.text) * ( 1 - taxa)  ;
                     
                     parcelas = result;
                   } 
                  }

                },
              ),

              Visibility(
                visible: visLiquido,
                child: Container(
                  child: Column(
                    children: [
                                          
                      Text("Valor para passar no cartao: R\$ $result", 
                      style: TextStyle(
                        fontSize:18),),
                      operacao=="Credito"?
                      Text("Valor das Parcelas para o Cliente : R\$ $parcelas", 
                      style: TextStyle(
                        fontSize:18),):

                      Text(""),


                      
                    ],
                  ),
                ),

              ),

               Visibility(
                visible: visBruto,
                child: Container(
                  child: Column(
                    children: [
                     
                      Text("Valor que voce receberá: $result", style: TextStyle(
                        fontSize:18 
                      ),),
                     
                      
                    ],
                  ),
                ),

              ),
            ],

        ),
      ),
          ),
    );
  }
}