import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_resumo_caixa.dart';
import 'package:loja_carrinhos/view/shared/messages/idDocs.dart';

import '../../../view/screens/models/modelsOfDB/m_DB_entradas_cash.dart';

class ReadMovimento{
   
   Future<List<MDBEntradasCash>> readDados()async{

       DocumentReference docReference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("registroContas").collection("2022-1").doc("combustivel");
        List<MDBEntradasCash> entradas = [];
      await docReference.get().then((value) {     
        
        Map<String , dynamic> valuesBanco = value.data();

        valuesBanco.forEach((key, val) {
          
          
            for (var item in val) {
              entradas.add(MDBEntradasCash.fromMap(key, item));
              
            }
          
          
        });
            
    });
    return entradas;

   }

   Future<Map<String, dynamic>> readResumoCaixa()async{
     DateTime data = DateTime.now();
     IdDocs ids = IdDocs.ids(data: data);
      DocumentReference listDB = FirebaseFirestore.instance.collection("MovimentoCaixa").doc('registroContas');
      Map<String ,dynamic>  map;

      await listDB.get().then((value)  {
        
        map =  value.data();
        
      });

        if (ids.diaDoc == "11" ){
        if (map['verificador'] == true){ 
          WriteResumoCaixa().resetarValores(); 
        }
      } else if(ids.diaDoc =="12"){
          WriteResumoCaixa().ativarVerificador();
      }
      
      return map;

  }


   }
