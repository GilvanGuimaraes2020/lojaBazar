/* class Iauth{
 Future<String> login(String email ,String senha) async {}
} */








import 'package:firebase_auth/firebase_auth.dart';

class userAuthService{
  
     Future<String> login(String email , String senha) async {
    try {   
    
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword
    (email: email, password: senha);
    print(userCredential.user.uid);
    
    return 'login efetuado com sucesso';
  } on FirebaseException catch (e) {
    print(e);
    print("Usuario nao cadastrado");
    return "Usuario nao cadastrado";
  } 
  }

  Future<String> cadastro(String email , String senha) async {
    try {
      print("$email , $senha");
      /* UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: senha);
       
        print(userCredential.user.uid); */
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword
        (email: email, password: senha);
        //print(teste);
        return 'usuario cadastrado com sucesso';
    } on FirebaseException catch (e) {
      print(e);

      if(e.code == "user-not-found"){
        print('No user found for that email.');
        return 'Nenhum usuário encontrado';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'Senha errada';
      }else if (e.code == 'email-already-in-use'){
        return 'Usuario já cadastrado';
      }else{
        return e.code;
      }
      }
    
  }
  
 
}
