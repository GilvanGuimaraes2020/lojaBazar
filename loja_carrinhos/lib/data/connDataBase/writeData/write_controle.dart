import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/data/connDataBase/readInitial/read_values_contas.dart';

import '../../../view/shared/messages/idDocs.dart';

class WriteControle{

  String writeDados(String confirmRegister, DateTime data, List listaDados){
    

    if (confirmRegister == "Salvo com Sucesso"){
      IdDocs ids = IdDocs.ids(data: data);
      DocumentReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("CContas").collection(ids.anoDoc).doc(listaDados[0]['banco']);

      //Lê os valores do BD no controle de contas      
      ReadValuesContas().readValuesContas(data , listaDados[0]['banco']).then((value) {
              
        double status;
        //para saida multiplica por -1 o valor corrente
        listaDados[0]['status'] == 'Entrada' ? 
        status = listaDados[0]['valor'] * 1:
        status = -1 * listaDados[0]['valor'] ;
        //atualiza os dados do banco add ou subtraindo os valores
      reference.set(
        {
        ids.idDoc:value[ids.idDoc] + status,
        'registros':FieldValue.arrayUnion([
          {'data' : data,
          'status':listaDados[0]['status'],
          'valor':listaDados[0]['valor']
          }
          ]) ,
          'total':value['total'] + status
      },
        SetOptions(merge: true)
      ).catchError((onError){
        return "Erro ao salvar";
      });
      });
      
      //String local =listaDados[0]['banco'];
      
      return "Salvo com Sucesso";
    
    } else{
      return "Erro ao Salvar";
    }
  }
 
}