import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:market_place/main.dart';
import 'package:market_place/model/publicacionesModel.dart';
import 'package:market_place/widgets/publicidadMenu.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

class FirestoreHelper {

  String pathImages = 'publicaciones/';
  

  static Stream<List<PublicacionModel>> read(){
    final coleccionPublicaciones = FirebaseFirestore.instance.collection('publicaciones'); //nombre de la coleccion de la BD
    return coleccionPublicaciones.snapshots().map((snapshot) => snapshot.docs.map((doc) => PublicacionModel.fromSnapShot(doc)).toList());
  }


  static Future crearPublicacion(File imagenSeleccionada /*FILE*/, PublicacionModel publicacion) async{
    String urlImage = '';

    if(imagenSeleccionada != null) {
      final  filePath = 'publicaciones/${publicacion.idImagen}.jpg';
 
      final storegeRef = FirebaseStorage.instance.ref();

      try {
        final uploadTask = storegeRef 
                          .child(filePath)
                          .putFile(imagenSeleccionada);

        //AQUI FALTA OBTENER AL URL YA Q NO ME LA ACEPTA :c
        var downUrl = await (await uploadTask).ref.getDownloadURL();
        urlImage = downUrl.toString();
        
        
      }
      catch(e) {
        print("OCURRIO EL ERRO: $e");
      }
  
    }
    

    final coleccionPublicaciones = FirebaseFirestore.instance.collection('publicaciones'); //nombre de la coleccion de la BD
    
    final docRef = coleccionPublicaciones.doc(); //nombre del documento dentro de la coleccion de la BD

    final nuevaPublicacion = PublicacionModel(
      categoria : publicacion.categoria,
      descripcion : publicacion.descripcion,
      id_user : publicacion.id_user,
      nombre : publicacion.nombre,
      precio : publicacion.precio,
      idImagen : urlImage,
    ).toJson();

    try{
      await docRef.set(nuevaPublicacion);
    }catch(e){
      print("ha ocurrido el error $e");
    }   

    

    
  }
}