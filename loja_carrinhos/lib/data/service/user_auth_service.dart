/* class Iauth{
 Future<String> login(String email ,String senha) async {}
} */



import 'package:firebase_auth/firebase_auth.dart';

class userAuthService{
  
     Future<String> login(String email , String senha) async {
    try {   
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword
    (email: email, password: senha);
    print(userCredential.user.email);
    return 'login efetuado com sucesso';
  } on FirebaseAuthException catch (e) {
    return e.code;
  } catch (e){
    print(e);
  }
  }

  Future<String> cadastro(String email , String senha) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: senha);
        return 'usuario cadastrado com sucesso';
    } on FirebaseAuthException catch (e) {
      if(e.code == "user-not-found"){
        print('No user found for that email.');
        return 'Nenhum usuário encontrado';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'Senha errada';
      }else if (e.code == 'email-already-in-use'){
        return 'Esse e-mail já está sendo usado';;
      }else{
        return e.code;
      }
      }
    
  }
  
 
}
