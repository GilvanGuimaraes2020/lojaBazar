import 'package:loja_carrinhos/view/shared/messages/retornoEventos.dart';

class Validation{

  String campoNome(String value){
    print(value);
    String pattern = r"(?=^.{2,60}$)^[A-ZÀÁÂĖÈÉÊÌÍÒÓÔÕÙÚÛÇ][a-zàáâãèéêìíóôõùúç]+(?:[ ](?:das?|dos?|de|e|[A-Z][a-z]+))*$";
    RegExp regexp = new RegExp(pattern);

    if (value.length<=0){
      return RetornoEventos().campoSemDados;      
    } else if(!regexp.hasMatch(value)){
      return RetornoEventos().dadosIncorretos;
    } 
    return null;
  }

  String campoTexto(String value){
    print(value);
    String pattern = r"^[A-Z]{1}.*$";
    RegExp regexp = new RegExp(pattern);

    if (value.length<=0){
      return RetornoEventos().campoSemDados;      
    } else if(!regexp.hasMatch(value)){
      return RetornoEventos().dadosIncorretos;
    } 
    return null;
  }

  String campoTelefone(String value){
    String pattern = r"^([1-9]{2} [9]{0,1}[0-9]{4}[0-9]{4})$";
    RegExp regexp = new RegExp(pattern);

    if(value.length == 0){
      return null;
    }else if(!regexp.hasMatch(value)){
      return RetornoEventos().soNumeros;
    } 
    return null;
  }

  String campoNumero(dynamic value){
    String pattern = r"^[0-9]$";
    RegExp regexp = new RegExp(pattern);

    if (value.length<=0){
      return RetornoEventos().campoSemDados;      
    } else if(!regexp.hasMatch(value)){
      return RetornoEventos().soNumeros;
    } 
    return null;
  }

  String campoMoeda(String value){
    String pattern = r"^[0-9\.]*$";
    RegExp regexp = new RegExp(pattern);

    if (value.length<=0){
      return RetornoEventos().campoSemDados;      
    } else if(!regexp.hasMatch(value)){
      return RetornoEventos().soNumeros;
    } 
    return null;
  }
}