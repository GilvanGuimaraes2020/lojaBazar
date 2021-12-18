
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'Models.dart';


class TelaAgendamento extends StatefulWidget {
  

  @override
  _TelaAgendamentoState createState() => _TelaAgendamentoState();

}

class _TelaAgendamentoState extends State<TelaAgendamento> {

int selectedRadio;
String operacao;
String tipoProduto = "Carrinho";
var opcontrol = TextEditingController();
var endcontrol = TextEditingController();
var nomeControl = TextEditingController();
var telefoneControl = TextEditingController();
var detalheControl = TextEditingController();
var _scaffoldKey = GlobalKey<ScaffoldState>();

var valorControl = TextEditingController();
var dataControl = TextEditingController();
var bairrocontrol = TextEditingController();
var db = FirebaseFirestore.instance;

DateTime data;
DateFormat formatter = DateFormat('yyyy-MM-dd');

//***************************************Retorna dado especifico do banco************************************* */
void  getDocumentId(String id){
  int value;
 db.collection('agenda').doc(id).get().
 then((doc) {
   operacao = doc.data()['operacao'];
   nomeControl.text = doc.data()['nome'];
   endcontrol.text = doc.data()['endereco'];
   bairrocontrol.text = doc.data()['bairro'];
   telefoneControl.text = doc.data()['telefone'];
   detalheControl.text = doc.data()['detalheProduto'];
   valorControl.text = doc.data()['preValor'];
   dataControl.text = doc.data()['data'];
  
 });

 if (operacao == 'compra'){
   value =1;

 } else if(operacao == 'venda'){
   value =2;
 }
 setState(() {
   selectedRadio = value;
 });


}





  @override
  Widget build(BuildContext context) {

    Map dadosRetorno   = ModalRoute.of(context).settings.arguments;
    String id;
    //String idProduto;
    


   //****************************Recebe dado de agenda para modificar informaçoes********************* */ 
  if (dadosRetorno !=null){
    if(dadosRetorno['adressRoute']== "/agenda"){
      id = dadosRetorno['idAgenda'];
      getDocumentId(id);
    } /* else if(dadosRetorno['adressRoute']== "/agendamento"){
      detalheControl.text = dadosRetorno['detalhe'];
     
    } */
    

  }

//*************************Cria lista do estoque quando for venda************************************** */
Widget agendamento(){
  var db = FirebaseFirestore.instance;
  // ignore: unused_local_variable
  String idProduto;
  List<Estoque> estoque = [];

  db.collection("estoque")        
        .get().then((doc) {
          estoque = doc.docs.map((e) => Estoque.fromMap(e.data(), e.id)).toList();
        } );

   
   return StreamBuilder<QuerySnapshot>(
     stream: db.collection('estoque').snapshots(),
     builder: (context , snapshots){
       switch(snapshots.connectionState){
         case (ConnectionState.none):
         return Center(child: Text("Erro ao conectar"),);
         case(ConnectionState.waiting) :
         return Center(child: CircularProgressIndicator());
         default : return ListView.builder(
           itemCount: estoque.length,
           itemBuilder: (context , index){
             return ListTile(
               title: Text("${estoque[index].resProduto}, ${estoque[index].resCliente}"
               , style: TextStyle(fontSize: 14),),
               subtitle: Text("R\$ ${estoque[index].valor}",style: TextStyle(fontSize: 12),),
              onTap: (){
                setState(() {
                 // idProduto = estoque[index].id;
                  detalheControl.text = detalheControl.text + "-" + estoque[index].id ;
                  Navigator.of(context).pop();
                
                
                });
                
              },
             
               
             );
           },
         );
       }
     },
   );
}

  void openDrawer(){
    _scaffoldKey.currentState.openDrawer();
  }

  void closeDrawer(){
    Navigator.of(context).pop();
    
  }

    return Scaffold(

      appBar: AppBar(
        title: Text('Agendar Compra / venda'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
       actions: [
         Container(
           padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          
          //********Informar data */
           child: IconButton(
             icon: Icon(Icons.calendar_today,
             size: 30,),
              onPressed: () async {
                  data = await showDatePicker(
                   context: context,
                   initialDate: DateTime.now(),
                   firstDate: DateTime(2018),
                   lastDate: DateTime(2030),
                   
                   builder: (context , child) {
                     return Theme(
                       data: ThemeData.dark(),
                       child: child,
                     );
                   }
                 );
                  setState(() {
                   
                   dataControl.text = formatter.format(data);
                   print(formatter.format(data));
                  
                  });
               
               
               },
           ),
         ),
       
       ]
      ),
      key: _scaffoldKey,

      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.fromLTRB(10,0,10,50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            //***apresenta os dois radioList ********* */

             RadioListTile(
               value: 1,
               groupValue: selectedRadio,
               title: Text("Compra", style: TextStyle(fontSize: 14 ),),
               onChanged: (val){
                 setState(() {
                   selectedRadio = val;
                    print(selectedRadio);
                    operacao = "compra";
                 });

               },

             ),
               RadioListTile(
                 
               value: 2,
               groupValue: selectedRadio,
               title: Text("Venda", style: TextStyle(fontSize: 14 ),),
               onChanged: (val){
                 setState(() {
                   selectedRadio = val;
                   print(selectedRadio);
                   operacao = "venda";
                 });

               },


             ),

             Divider(
               thickness: 2,
               color: Colors.brown,
               
             ),

            TextField(
              style: TextStyle(fontSize: 14),
               decoration: InputDecoration(
                 labelText: 'Nome'
               ),
               controller: nomeControl,
             ),
             TextField(
               style: TextStyle(fontSize: 14),
               decoration: InputDecoration(
                 labelText: 'Telefone'
               ),
               controller: telefoneControl,
             ),
              TextField(
                style: TextStyle(fontSize: 14),
               decoration: InputDecoration(
                 labelText: 'Endereço'
               ),
               controller: endcontrol,
             ),
              TextField(
                style: TextStyle(fontSize: 14),
               decoration: InputDecoration(
                 labelText: 'Bairro'
               ),
               controller: bairrocontrol,
             ),

            //********Apresenta o dropdown com o tipo de produto */ 

               DropdownButton<String>(
                              value: tipoProduto,
                              items: <String>['Carrinho' , 'Banheira','Eletronico', 'Andador', 'Berço','Chiqueirinho'
                        ,'Conjunto','Bebe Conf c base','Bebe Conf s base' ,'Cadeira p auto', 'Cadeirinha',
                        'Cadeirão','tapete educ','Triciclo','Kit Berço','Kit Higiene', 'Lote Roupas' ]
                              .map<DropdownMenuItem <String>>((String value){
                                return DropdownMenuItem <String>(
                                  value: value,
                                  child: Text(
                                    value , style: TextStyle(fontSize: 16),
                                  ));
                              } ).toList(), 
                              isExpanded: true,
                                       
                              onChanged: (String newValue){
                                setState(() {
                                  tipoProduto = newValue;
                                  print(tipoProduto);
                                });
                              }),


              TextField(
                style: TextStyle(fontSize: 14),
               decoration: InputDecoration(

                 labelText: 
                  'Detalhe da negociaçao '
               ),
               controller: detalheControl,
               
             ),


              TextField(
                style: TextStyle(fontSize: 14),
               decoration: InputDecoration(
                 labelText: 'Valor Produto'
               ),
               controller: valorControl,
               onTap: (){
                 if(operacao == "venda"){
                  

                    openDrawer();
                 }
               },
             ),
             TextField(
               style: TextStyle(fontSize: 14),
               decoration: InputDecoration(
                 labelText: 'Data Agendada'
               ),
               controller: dataControl,
               enabled: false,
             ),
              

            ],
          ),
        ),
      ),

drawer: Drawer(
  child: Scaffold(
appBar: AppBar(
  title: Text("Filtro do estoque"),
  leading: IconButton(
    icon: Icon(Icons.keyboard_backspace),
    onPressed: (){
      closeDrawer();
    },
  ),
),
body: agendamento()
,
  ),
),


      floatingActionButton: FloatingActionButton(
         
         child: Icon(Icons.perm_contact_calendar_rounded) ,
         tooltip: 'Registrar Agendamento',
         elevation: 5,         
         backgroundColor: Colors.blue,
         foregroundColor: Colors.white,
        onPressed: ()async{
          if (dataControl.text==""){
            return showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text("Faltando Data!!!"),
                  content: Text('Escolher data no icone acima'),
                  actions: [
                    ElevatedButton(
                      child: Text("Ok"),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              }
            );
          }

         /*  String idOrDetail;
          if (operacao == "venda"){
            idOrDetail = (detalheControl.text + "-" + idProduto);
          } else if (operacao == "compra"){
            idOrDetail = detalheControl.text;
          }  */

          if (id == null) {
            if (nomeControl.text != ""  ) {
              

                       await db.collection('agenda').add({
                        'nome': nomeControl.text,
                        'endereco' : endcontrol.text,
                        'bairro' : bairrocontrol.text,
                        'telefone' : telefoneControl.text,
                        'operacao' : operacao,
                        'tipoProduto' : tipoProduto,
                        'detalheProduto' : detalheControl.text,
                        'preValor' : valorControl.text,
                        'data' : dataControl.text
                      });

                      }
          } else {
           await db.collection('agenda').doc(id).update({
                        'nome': nomeControl.text,
                        'endereco' : endcontrol.text,
                        'bairro' : bairrocontrol.text,
                        'telefone' : telefoneControl.text,
                       // 'operacao' : operacao,
                        'tipoProduto' : tipoProduto,
                       // 'detalheProduto' : detalheControl.text,
                        'preValor' : valorControl.text,
                        'data' : dataControl.text
                      });
          }

          

          

          setState(() {
            nomeControl.text = "";
            telefoneControl.text = "";
            endcontrol.text = "";
            bairrocontrol.text = "";
            detalheControl.text = "";
            valorControl.text = "";
            dataControl.text = "";
            Navigator.of(context).pop();
          });
          
        }      
      ),
      backgroundColor: Colors.brown[100],
      

      
    );
  }
}