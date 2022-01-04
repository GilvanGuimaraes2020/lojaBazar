class MClientes{
  String id;
  String codigo;
  String endereco;
  String bairro;
  String nome; 
  String telefone;

  MClientes(this.id, this.codigo, this.endereco, this.bairro, this.nome,  this.telefone);

  MClientes.fromMap(Map<String , dynamic>map , String id) {
    this.id = id ?? '';
    this.codigo = map['codigo'];
    this.endereco = map['endereco'];
    this.bairro = map['bairro'];
    this.nome = map['nome'];    
    this.telefone = map['telefone'];

  }
}