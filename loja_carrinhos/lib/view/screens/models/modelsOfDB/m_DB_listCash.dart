
class ListCashDB{
  
  String title;
  double total;
  

  ListCashDB({this.title, this.total});

ListCashDB.fromMap(String key, dynamic value){
  
    print(key);
    this.title = key;
    this.total= value['total'];
  
  
}
ListCashDB.fromList(String title){
this.title = title;
this.total = 0;
}
}