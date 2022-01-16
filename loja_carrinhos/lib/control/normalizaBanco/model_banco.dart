class Modelo{
  String categoria;
  String docId;
  String diaId;
 
  Map<String , dynamic> field;
  List<Map<String , dynamic>> fieldArray = [];

  Modelo(this.categoria, this.docId, this.diaId,
  this.field, this.fieldArray);

  Modelo.tratar(String categoria ,String dado, String diaId){
    this.diaId = diaId;    
    String valor;
    String detalhe;
    String pagamento;
    String parcela;
    String banco;
    String status;
      String sub = categoria.substring(0 , 5);
      

      if(sub == "compr" ){
        this.categoria = "compra";
        
      } else if(sub == "venda"){
        this.categoria = "venda";
        
      } 
      else{
         int ultimoCaracter = int.tryParse(categoria.substring(categoria.length - 1)) ;
        this.categoria = ultimoCaracter == null ?
                          categoria:
                          categoria.substring(0 , categoria.length - 1);

       
      }
     
    //utiliza um boleano para verificar se é uma venda
    //busca o '-' e utiliza somente a parte inicial
  
     int z = 0;
     String operacao;
     String termoSegundo;
  
    valor = dado.substring( z  , dado.indexOf(";" ,  z));
    z =dado.indexOf(";" , z) + 1;

      //verifica 2ºtermo para desmembrar detalhe e status
    termoSegundo = dado.substring( z  , dado.indexOf(";" ,  z));
    z =dado.indexOf(";" , z) + 1;

    detalhe = termoSegundo.substring(0 ,
      termoSegundo.indexOf("-"));

    status = termoSegundo.endsWith("s")  ? "Saida" : "Entrada";

   //variavel para desmembrar 3º parte da string 
    operacao = dado.substring( z  , dado.length );
    int verBanco = operacao.indexOf("-");
    parcela = "0";
    if (operacao.contains("Dinheiro")){
      pagamento = "dinheiro";
      
      banco = "Caixa Giro";
    } else if(operacao.contains("Maquina Cartao")){
      pagamento = operacao.substring(0 , verBanco).toLowerCase();
        banco = "Sumup";
        parcela =  operacao.substring(verBanco  + 1);
      
      }else if(operacao.contains("Transferencia")){
      pagamento = "transferencia"; 
      
      banco = verBanco > -1?
      operacao.substring(verBanco + 1) :
      null;
    }else{
      pagamento = "nao definida";
      banco = "nao definido";
    }

    fieldArray = [
      {
        "valor" : valor,
        "detalhe" : detalhe,
        "operacao" : pagamento,
        "parcelas" : double.tryParse(parcela) ,
        "banco" : banco,
        "status" : status
      }
    ];
    
  }
}

