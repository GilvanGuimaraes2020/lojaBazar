import 'package:cloud_firestore/cloud_firestore.dart';

class Usuarios{
  String id;
  String nome;
  String senha;
  

  Usuarios(this.id, this.nome, this.senha);

  Usuarios.fromMap(Map<String , dynamic>map , String id) {
    this.id = id ?? '';
    this.nome = map['nome'];
    this.senha = map['senha'];
    

  }
}

class Clientes{
  String id;
  String codigo;
  String endereco;
  String bairro;
  String nome; 
  String telefone;

  Clientes(this.id, this.codigo, this.endereco, this.bairro, this.nome,  this.telefone);

  Clientes.fromMap(Map<String , dynamic>map , String id) {
    this.id = id ?? '';
    this.codigo = map['codigo'];
    this.endereco = map['endereco'];
    this.bairro = map['bairro'];
    this.nome = map['nome'];    
    this.telefone = map['telefone'];

  }
}

class Estoque{
 String id;
  String resCliente;  
  String resProduto;
  String codCliente;
  String codProduto;
  String valor;
  String status;
  Timestamp data;
  String cor;
  

  Estoque(this.id, this.resCliente, this.resProduto, this.codCliente, this.codProduto, 
  this.valor, this.status, this.data, this.cor);

  Estoque.fromMap(Map<String , dynamic>map , String id) {
   this.id = id ?? '';
    this.resCliente = map['resCliente'];
    this.resProduto = map['resProduto'];    
    this.codCliente = map['codCliente'];
    this.codProduto = map['codProduto'];
    this.valor = map['valor'];
    this.status = map['status'];
    this.data = map['data'];
    this.cor = map['corProduto'];

  }
  
}

class Produtos{
  String id;
  String codigo;
  String marca;
  String modelo;
  String tipoProduto;


  Produtos(this.codigo, this.id ,  this.marca, this.modelo, this.tipoProduto,);

  Produtos.fromMap(Map<String , dynamic> map, String id){
    this.id = id ?? " ";
    this.codigo = map['codigo'];
    this.marca = map['marca'];
    this.modelo = map['modelo'];
    this.tipoProduto = map['tipoProduto'];
   
  }

  }

  class Agenda{
    String id;
    String detalheProduto;
    String tipoProduto;
    String preValor;
    String nome;
    String telefone;
    String endereco;
    String bairro;
    String data;
    String operacao;

    Agenda(this.id, this.detalheProduto, this.tipoProduto, this.preValor, this.nome, this.telefone, 
    this.endereco, this.bairro, this.data, this.operacao);

    Agenda.fromMap(Map<String , dynamic> map , String id){
      this.id = id ?? "";
      this.nome = map['nome'];
      this.endereco = map['endereco'];
      this.bairro = map['bairro'];
      this.telefone = map['telefone'];
      this.data = map['data'];
      this.detalheProduto = map['detalheProduto'];
      this.tipoProduto = map['tipoProduto'];
      this.preValor = map['preValor'];
      this.operacao = map['operacao'];
      
    }

  }

  class Venda{
    String id;
    String idProduto;
    String idCliente;
    String nomeProduto;
    String nomeCliente;
    String telefone;
    String valor;
    String data;

    Venda(this.id, this.idProduto , this.idCliente, this.nomeCliente, this.telefone,
    this.valor, this.data);

    Venda.fromMap(Map<String , dynamic> map, String id){
      this.id = id??"";
      this.idProduto = map['idProduto'];
      this.idCliente = map['idCliente'];
       this.nomeProduto = map['nomeProduto'];
      this.nomeCliente = map['nomeCliente'];
      this.telefone = map['telefone'];
      this.valor = map['valor'];
      this.data = map['data'];
      

    }
  }

  class Comentario{
    String data;
    String id;
    String status;
    String comentario;

    Comentario(this.id, this.data, this.comentario, this.status);

    Comentario.fromMap(Map<String , dynamic> map , String id){

      this.id = id??"";
      this.data = map['data'];
      this.comentario = map['comentario'];
      this.status = map['status'];

    }
  }

  class Historico{
    String id;
    Timestamp data;
    String dataCompra;
    String idProduto;
    String nomeProduto;
    String idCliente;
    String nomeCliente;
    String valor;
    String valorCompra;

    Historico(this.id, this.data, this.dataCompra, this.idCliente, this.nomeCliente ,this.idProduto,
    this.nomeProduto, this.valor, this.valorCompra);

    Historico.fromMap(Map<String , dynamic> map, String id){
      this.id = id??"";
      this.data = map['data'];
      this.dataCompra = map['dataCompra'];
      this.idCliente = map['idCliente'];
      this.nomeCliente = map['nomeCliente'];
      this.idProduto = map['idProduto'];
      this.nomeProduto = map['nomeProduto'];
      this.valor = map['valor'];
      this.valorCompra = map['valorCompra'];
    }
  }

  class ControleGastos{
    String id;
    //String mes;
    Map dias = Map() ;
    Map tipoMovimento;

    ControleGastos(this.id, this.dias, this.tipoMovimento);

    ControleGastos.fromMap(Map<String , dynamic> map , String id){
     this.id = id??"";
     this.dias = map;
    }
  }

  class AlertaLista{
    String id;
    Map produtos;
    Timestamp dataPrevista;
    int idCliente;
    String nomeFilho;
    String nomeMae;
    String sexo;
    bool status;
    bool vendaFeita;

    AlertaLista(this.produtos, this.dataPrevista, this.idCliente, this.nomeFilho,this.nomeMae, this.sexo, 
    this.status, this.vendaFeita, this.id);

    AlertaLista.fromMap(String id , Map<String , dynamic> dados){
      this.id = id??"";
      this.produtos = dados['produtos'];
      this.dataPrevista = dados['dataPrevista'];
      this.idCliente = dados['idCliente'];
      this.nomeFilho = dados['nomeFilho'];
      this.nomeMae = dados['nomeMae'];
      this.sexo = dados['sexo'];
      this.status = dados['status'];
      this.vendaFeita = dados['vendaFeita'];
    }
  }