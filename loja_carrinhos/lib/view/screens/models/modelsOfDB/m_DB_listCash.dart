
class ListCashDB{
  
  String title;
  double inputValue;
  double mes;
  double outputValue;
  bool status;
  

  ListCashDB({this.title, this.inputValue, this.outputValue, this.status, this.mes});

ListCashDB.fromMap(String id, Map<String, dynamic> map){


this.title = id ?? "";
this.outputValue = map['output'];
this.mes = map['mesReferencia'];
this.inputValue = map['input'];
this.status =map['status'];
}
}