import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_carrinhos/CRUD.dart';
import 'package:loja_carrinhos/TratarDadosBanco.dart';

class MostraDetalheMes extends StatefulWidget {
  @override
  _MostraDetalheMesState createState() => _MostraDetalheMesState();
}

class _MostraDetalheMesState extends State<MostraDetalheMes> {
  String categoria = "combustivel";
  int selectMes = 1;
  SelecionaDados selecionaDados ;
  var anoCtrl = TextEditingController();
   List<TratarDados> dado = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Verificar Detalhamento de contas"),
      ),
      body: Container(
        child: Column(
          children: [
          Row(
            children: [
              Text("Escolha uma categoria: "),
              SizedBox(width: 20,),
               DropdownButton(
                          value: categoria,
                
                items:<String> ["combustivel" , "padaria", "mercado", "servicos",
                 "estudo", "lazer","doacao", "emergencia","emprestimo", "contas" , "vendaItem" ,"compraItem"
                ].map<DropdownMenuItem<String>>((value){
                  return DropdownMenuItem(
                    
                    value:value ,
                    child: Text(value),
                   );
                   
                }).toList(),
                onChanged: (String newValue){
                  setState(() {
                    categoria = newValue;
                   
                  });
                }
        ),
            ],
          ),
        Row(
          children: [
            Text("Escolha um mes: "),
            SizedBox(width: 20,),
            DropdownButton(
              value : selectMes,
              items: <int>[1 , 2 ,3 , 4 ,5, 6 ,7,8,9,10,11,12
              ].map<DropdownMenuItem<int>>((value){
                 return DropdownMenuItem(
                   value: value,
                   child: Text("$value"),
                 );
              } ).toList(),
               onChanged: (int newvalue){
                 setState(() {
                     selectMes = newvalue;           
                              });
                        
               },
            ),
          ],
        ),

        TextField(
          decoration: InputDecoration(
            labelText: 'Digite o ano'
          ),
          keyboardType: TextInputType.number,
          controller: anoCtrl,
          expands: false,
        ),
        Row(
          children: [
            ElevatedButton(
              child: Text("Pesquisar"),
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
              onPressed: ()async{
                if(anoCtrl.text == null || anoCtrl.text ==""){
                  return showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Faltando Informaçoes"),
                        content: Text("Verificar se todas as informaçoes estao preenchidas!"),
                       );
                    }
                  );  
                }
                String periodo = "${anoCtrl.text}-$selectMes";
selecionaDados =   SelecionaDados(categoria , periodo);
 dado = await selecionaDados.coleta();

 print (selecionaDados.sumTotEnt);
 print (selecionaDados.sumTotSai);
 print (selecionaDados.sumCatSai);
 print (selecionaDados.sumCatEnt);
setState(() {
  // ignore: unnecessary_statements
  dado;
});

              }
            ),
            Visibility(
              visible: dado.length>0,
              child: ElevatedButton(
                style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
                child: Text("Relatorio"),
                onPressed: (){
                  return showDialog(
context: context,
builder: (context){
  return AlertDialog(
    title: Text("Relatorio dos Gastos: $selectMes de ${anoCtrl.text}"),
    content: Column(
      children: [

      Text("Soma Total Entrada: ${selecionaDados.sumTotEnt.toStringAsFixed(2)}"),  
      Text("Soma Total Saida: ${selecionaDados.sumTotSai.toStringAsFixed(2)}"),
      Text("Soma Entrada $categoria: ${selecionaDados.sumCatEnt.toStringAsFixed(2)}"),
      Text("Soma Saida $categoria: ${selecionaDados.sumCatSai.toStringAsFixed(2)}"),              
                            
      
      ],
    ),
    actions: [
      ElevatedButton(
              child: Text("Ok"),
              onPressed: (){
                Navigator.pop(context);
              },
      )
    ],
  );
}
);
                },
              ),
            )
          ],
        ),

        Visibility(
          visible: dado.length > 0 ,
          child: Expanded(
           //scrollDirection: Axis.vertical,
            child: ListView.builder(
              itemCount: dado.length,
              
              itemBuilder: (context , index){
                return Container(

                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      ),
                       color: dado[index].operacao == 'e'?
                  Colors.blue[100]:
                  Colors.yellow[100],

                  ),
                 
                  child: Column(
                    
                    children: [
                    dado[index].operacao == 'e'?
                    Text("Entrada: R\$ ${dado[index].valor}"):
                    Text("Saida: R\$ ${dado[index].valor}"),                    
                    Text("${dado[index].chave} , ${dado[index].detalhe}"),
                    Text("${dado[index].tipoTransacao}"),
                    Text("Dia:${dado[index].dia}")

                    ],),

                  );
              },
            ),
          ),
        ),
             
        ] 
        )
      ),     
    );
  }
  }
