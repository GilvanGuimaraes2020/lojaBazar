import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/data/connDataBase/readInitial/read_values_contas.dart';
import 'package:loja_carrinhos/view/shared/messages/retornoEventos.dart';

import '../../../view/shared/messages/idDocs.dart';

class WriteControle{

  Future<String> writeDados(String confirmRegister, DateTime data, List lista)async{
    

    if (confirmRegister == RetornoEventos().salvo){
      IdDocs ids = IdDocs.ids(data: data);
      
      for (var item in lista) {
         
          
        DocumentReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("CContas").collection(ids.anoDoc).doc(item['banco']);
        
        //Lê os valores do caixa total e mensal no controle de contas      
        Map<String , dynamic> value = await ReadValuesContas().readValuesContas(data , item['banco']);
          double status;
          //para saida multiplica por -1 o valor corrente
          item['status'] == 'Entrada' ? 
          status = item['valor'] * 1:
          status = -1 * item['valor'] ;
          //atualiza os dados do banco add ou subtraindo os valores
         reference.set(
          {
          ids.idDoc:value[ids.idDoc] + status,
          'registros':FieldValue.arrayUnion([
            {'data' : data,
            'status':item['status'],
            'valor':item['valor']
            }
            ]) ,
            'total':value['total'] + status
        },
          SetOptions(merge: true)
        ).catchError((onError){
          print("erro salvamento: CContas> ${item['banco']}");
          return RetornoEventos().erro;
        });
         
      }
     
      return RetornoEventos().salvo;
    
    } else{
      return RetornoEventos().funcao;
    }
  }
 
}