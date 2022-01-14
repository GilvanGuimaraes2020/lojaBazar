
import '../../../shared/messages/idDocs.dart';

class ListCashDB{
  
  String title;
  double total;
  double atual;

  

  ListCashDB({this.title, this.total, this.atual});

ListCashDB.fromMap(String key, Map<String , dynamic> map){
  
  this.title = key;
  double soma = 0;
  

  map.forEach((key, value) {
    for (var item in value) {
      if(item['status']=="Entrada") {
        soma = soma +  item['valor'];
      } else{
        soma = soma +  (-1 * item['valor']);
      }      
    }
  });
    print("$key = $soma");
    this.total = soma;



   /*  print(key);
    this.title = key;
    this.total= value['total'];
   */
  
}

ListCashDB.viewConta(String title , Map<String , dynamic> map){
      DateTime data = DateTime.now();
      IdDocs ids = IdDocs.ids(data: data);
     print("$title , ${map[ids.idDoc]} , ${map["total"]}");
      this.title = title;
      this.atual = map[ids.idDoc];
      this.total = map["total"];

}

ListCashDB.fromList(String title){
this.title = title;
this.total = 0;
}
}