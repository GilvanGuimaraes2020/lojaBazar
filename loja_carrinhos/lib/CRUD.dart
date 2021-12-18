import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/TratarDadosBanco.dart';

class SelecionaDados{
String categoria;
String periodo;
double sumCatEnt;
double sumCatSai;
double sumTotSai;
double sumTotEnt;





CollectionReference< Map> mensal =  FirebaseFirestore.instance.collection('MovimentoCaixa').
 doc('48yPK84Rbpi307lcrUBq').collection('contasVariadas');

SelecionaDados( this.categoria, this.periodo);

Future<List<TratarDados>> coleta() async {
List<TratarDados> gastosMes =[];
List<TratarDados> gastosFilter =[];

try{
  
 await  mensal.doc(periodo).get().then((value){
   
     value.data().keys.forEach((element) {
       
          Map extrairDadosMes = Map();
          extrairDadosMes = value.data()[element];
          extrairDadosMes.forEach((key, value) {
            gastosMes.add(TratarDados.banco(value , key, element));
          });
  }
  );
});

  double somatotalEnt = 0;
  double somatotalSai = 0;
  double somacatSai =0;
  double somacatEnt =0;
 for (TratarDados value in gastosMes) {
   //print(value.operacao);
   if(value.operacao == "e"){
    somatotalEnt = somatotalEnt + double.tryParse(value.valor);
   } else if(value.operacao == "s"){
    somatotalSai = somatotalSai + double.tryParse(value.valor);
   }

   if(value.chave.contains(this.categoria)){
    gastosFilter.add(value);
     if(value.operacao == "e"){
     somacatEnt = somacatEnt + double.tryParse(value.valor);
    
   } else if(value.operacao == "s"){
     somacatSai= somacatSai + double.tryParse(value.valor);
   }
   }
}
 
/* gastosMes.forEach((e){
  if(e.operacao == "e"){
    somatotal = somatotal + double.tryParse(e.valor);
  } /* else {
    sumTotEnt = sumTotEnt + double.tryParse(e.valor);
  } */
}); */

this.sumTotEnt = somatotalEnt;
this.sumTotSai = somatotalSai;
this.sumCatEnt = somacatEnt;
this.sumCatSai = somacatSai;
print ("Valor total entrada: $somatotalEnt ");
print ("Valor total saida: $somatotalSai ");
print ("Valor Categoria saida: $somacatSai ");
print ("Valor Categoria entrada: $somacatEnt ");

} on Error catch(e) {
print("$e");
}

  return Future.value(gastosFilter);
}



}

