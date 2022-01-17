


import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowImages extends StatefulWidget {
  const ShowImages({ Key key });

  @override
  _ShowImagesState createState() => _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages> {
  FirebaseStorage storage = FirebaseStorage.instance;
  bool uploading = false;
  double total = 0 ;
  List<Reference> refs = [];
  List<String> arquivos = [];
  bool loading = true; 

  Future<TaskSnapshot> upload(String path)async{
    print("entrou em upload");
    File file = File(path);   
    
      try {
        String ref="images/img-${DateTime.now().toString()}.jpg";
        return storage.ref(ref).putFile(file);
      } on FirebaseException catch (e) {
        throw Exception("Erro no upload: ${e.code}");
      }
        
  }

  Future<XFile> getImage()async{
    print("entrou em getImage");
    final ImagePicker _picker = ImagePicker();
    XFile image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

   pickAndUploadImage()async{
     print("entrou em pickupload alterado");
    XFile file = await getImage();
    if(file != null){
      TaskSnapshot task = await upload(file.path);
      if (task.state == TaskState.running){
        setState(() {
            uploading = true;
            total = (task.bytesTransferred / task.totalBytes) * 100;
          });
      } else if(task.state == TaskState.success){
        arquivos.add(await task.ref.getDownloadURL());
          refs.add(task.ref);
          setState(() {
            uploading = false;
          });
      }
      
    }
  }

  deleteImage(int index) async {
    print("entrou em deleteImage");
    await storage.ref(refs[index].fullPath).delete();
    arquivos.removeAt(index);
    refs.removeAt(index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadImages();
   
    
  }

  loadImages() async{
    print("entrou em loadimages");
    //colocar a parte onde chama as referencia em um documento no firestore
    refs = (await storage.ref('images').listAll()).items;
    if (refs.isNotEmpty){
      for (var ref in refs){
            arquivos.add(await ref.getDownloadURL());
          }
    }
   
     setState(() {
      loading = false;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Navigator.popAndPushNamed(context , "/menu") ,
         icon: Icon(Icons.arrow_back)),
        title: uploading?
        Text("${total.round()}% Enviado"):
        Text("Foto"),
        actions: [
          uploading?
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),
            ),):
          IconButton(
            onPressed:pickAndUploadImage,
             icon: Icon(Icons.upload))
        ],
      ),
      body: loading ?
      Center(child: CircularProgressIndicator(),):
       Padding(
         padding: EdgeInsets.all(24),
         child: arquivos.isEmpty?
         Center(child: Text("Sem Dados"),):
         ListView.builder(
           
           itemBuilder: (context ,  index){
             return ListTile(
               leading: SizedBox(
                 height: 40,
                 width: 60,
                 child: Image.network(
                   arquivos[index],
                   fit: BoxFit.cover,
                 ),
               ),
               title: Text(refs[index].fullPath),
               trailing: IconButton(
                 onPressed:(){
                   deleteImage(index);
                 }, 
                 icon: Icon(Icons.delete)),
             );             
           },

           itemCount: arquivos.length,
           ),
       ),
    );
  }
}

/* class DeleteImage{

  Future<bool> delete(String path)async{
    bool deleta = false;
    FirebaseStorage storage = FirebaseStorage.instance;
    await storage.ref(path).delete().then((value) => deleta = true);  
    return deleta;
  }
} */