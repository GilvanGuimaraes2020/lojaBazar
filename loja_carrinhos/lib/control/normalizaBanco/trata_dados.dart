import 'package:loja_carrinhos/control/normalizaBanco/normaliza_bd.dart';
import 'package:loja_carrinhos/control/normalizaBanco/model_banco.dart';

class TrataDados{

  Future<List> dadosAntigo(DateTime data)async{
      Map<String , dynamic> map = await NormalizaBd().registroAntigo(data);
      List<Modelo> lista = [];
    map['dados'].forEach((key, value) {
      Map<String , dynamic> dados = value;
      dados.forEach((k , v){
        lista.add(Modelo.tratar(k ,v, key));
      });
      
    });

      for (var item in lista) {

        //NormalizaBd().registraNovo(item.categoria, item.fieldArray , data, item.diaId);
        print("${item.categoria}:");
        print("\t${item.diaId}:");
        print("\t\t ${item.fieldArray}");
        
        print("***************");

      }
    

  }
}