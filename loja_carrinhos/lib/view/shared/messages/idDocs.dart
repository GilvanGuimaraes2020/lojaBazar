class IdDocs{
  String idDoc;
  String diaDoc;
  

  
  IdDocs.ids({DateTime data}){
  this.idDoc = "${data.year}-${data.month}";
  this.diaDoc= "${data.day}";
}
}