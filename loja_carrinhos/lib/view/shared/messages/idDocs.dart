class IdDocs{
  String idDoc;
  String diaDoc;
  String anoDoc;
  

  
  IdDocs.ids({DateTime data}){
  this.idDoc = "${data.year}-${data.month}";
  this.diaDoc= "${data.day}";
  this.anoDoc = "${data.year}";
}
}