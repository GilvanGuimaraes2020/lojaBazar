class Messages{
  String type;
  
  String message;

  Messages(this.type);

String returnMessage(){
  switch (type) {
  case "informacao":
    message = "Insira suas Informaçoes aqui";
    return message;
    break;
  case "login":
    message = "Insira sua senha";
    return message;
    break;
  default:
    message = "";
    return message;
}
}



}