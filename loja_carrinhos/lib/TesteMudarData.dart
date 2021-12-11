



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_carrinhos/Models.dart';



class TesteMudarData extends StatefulWidget {
  @override
  _TesteMudarDataState createState() => _TesteMudarDataState();
}

class _TesteMudarDataState extends State<TesteMudarData> {

   
  var dbEstoque = FirebaseFirestore.instance.collection('estoque');
  var detalhe = TextEditingController();
  var teste = TextEditingController();
  var conta = TextEditingController();
  List<String> datas = [];
  Map dado = Map();
  List<Estoque> estoque = []; 
//var dbestoque = FirebaseFirestore.instance;
var dbteste = FirebaseFirestore.instance.collection('teste');

  /*@override
  void initState(){
     super.initState();
  dbEstoque.snapshots().listen((res) {
 setState(() {
   
   estoque = res.docs.map((e) => Estoque.fromMap(e.data(), e.id)).toList();
 });
});  



/*
 dbteste.collection('teste').snapshots().listen((res) {
 setState(() {
   datas = res.docs.map((e) => e.id).toList();
 });
}); 
*/
  }*/
  
  
  

 /* DocumentReference caixa = FirebaseFirestore.instance.collection('MovimentoCaixa').
 doc('ControleContas');
 CollectionReference diario = FirebaseFirestore.instance.collection('MovimentoCaixa').
 doc('48yPK84Rbpi307lcrUBq').collection('contasVariadas'); */
 
  @override
  Widget build(BuildContext context) {


  
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste"),

      ),

      body: Container(
        child: Center(
          child: Column(
            children: [

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'valor'
                ),
                inputFormatters: <TextInputFormatter>[
        // ignore: deprecated_member_use
        WhitelistingTextInputFormatter.digitsOnly
    ],
    controller: teste,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'detalhe'
                ),
controller: detalhe,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'conta'
                ),
controller: conta,
              ),
              ElevatedButton(
                 child: Text("Teste"),
     
                onPressed: ()async{
      /*   for (int i = 1 ; i <= estoque.length ; i++){
          print(estoque[i].codCliente);          
         
          dbEstoque.doc(estoque[i].id).update({
           
            'data': DateTime.tryParse(estoque[i].data) 
          });*/ 
          
        }
          
             
   
   /*
   for (var e in estoque) {
      dbteste.collection("teste").add(
   {
     "data" : e.data
   }
 );
   }               
*/
 


 
 /*
 String valor;





Map dado = Map();
List<ControleGastos> valores = [];

/*
await diario.get().then((value)  {
valores = value.docs.map((e) => ControleGastos.fromMap(e.data(), e.id)).toList();
});
  */
  /*  diario.doc("2021-2").set({
              "13" : {conta.text : "${teste.text};Dinheiro;${detalhe.text}" }   
              }, SetOptions(merge: true) );
 */
for(final e in estoque){
   
}

//valor = dado['compra'];
print(dado.keys.toList());

dado.keys.toList().forEach((element) {
  if(element.toString().substring(0,5)=="tipo-"){

  } else if(element.toString().substring(0,5)=="detal"){

  } else{
    
  }

});

valor = dado.values.toList()[0] + ";" + dado.values.toList()[1] + ";" + dado.values.toList()[2];

print( valor);
*/



/* var teste = TratarDados.banco(dado['compra']);

print(teste.valor);
print(teste.tipoTransacao);
print(teste.detalhe);
 */


//print(historico.length);
/* print(estoque.length);
print (estoque); */
/* List idNaoEncontrado = List();


  for(int i = 0; i < estoque.length; i++){
  if(!historico.contains(estoque[i])){
idNaoEncontrado.add(estoque[i]);
  }
}
print(idNaoEncontrado);
dbEstoque.collection('estoque').doc(idNaoEncontrado[0]).get().then((value){
  print(value.data()['resCliente']);
  print(value.data()['resProduto']);
  print(value.data()['status']);
}
); */

/* dbEstoque.collection('estoque').doc(idNaoEncontrado[1]).get().then((value){
  print(value.data()['resCliente']);
  print(value.data()['resProduto']);
  print(value.data()['status']);
}
); */
 /* List<String> idPaula = List();
await dbEstoque.collection('estoque').where('resCliente' , isEqualTo: "Meire").get().then((value){
  value.docs.forEach((element) {idPaula.add(element.id); });
} );
 */
                
),
            ],
          )





            /*   print("Entrou em teste");


setState(() {     
if (lista!=null){
  print("Lista ${lista.length}");
  lista.forEach((element)async {
  await  db.collection('historicoVenda').doc(element).update({
  'transacao' : "N/D",
                     'detTransacao' :"N/D",
});
  });
} else{
  print("Lista Nula");
}

}); */

            
        )
        ),
      );
    

      
     
    
     
  }
}

class Teste{
String id;
Timestamp data;
String teste;
Teste(this.id, this.data, this.teste);
Teste.fromMap(String id, Map<String , dynamic> data){
this.id = id;
this.data = data['data'];
this.teste = data['teste'];
}
}