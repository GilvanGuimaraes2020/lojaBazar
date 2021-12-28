class MDBEntradasCash{
  String id;
  String dia;
  String categoria;
  Map<String , dynamic> dados;

  MDBEntradasCash({this.id, this.dia, this.categoria, this.dados});

  MDBEntradasCash.fromMap(String id , Map<String, dynamic> map){
    this.id = id ?? " ";
    
  }
}