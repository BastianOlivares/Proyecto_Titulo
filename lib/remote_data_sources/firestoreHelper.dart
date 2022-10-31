import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:market_place/main.dart';
import 'package:market_place/model/publicacionesModel.dart';
import 'package:market_place/model/usuariosModel.dart';
import 'package:market_place/pages/menu.dart';
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

  static Future<QuerySnapshot> getCategorias() async {
    final refCategorias = FirebaseFirestore.instance.collection("categorias");
    
    return refCategorias.get();
  }

  static Future crearUsuario(BuildContext context, String id, UsuarioModel usuario) async {

    showDialog(
      context: context, 
      builder: ((context) {
        return const Center(
          child: SizedBox(
            width: 40.0,
            height: 40.0,
            child:  CircularProgressIndicator(),
          ),
        );
      })
    );

    final coleccionUsarios = FirebaseFirestore.instance.collection('usuarios');

    final docRef = coleccionUsarios.doc(id);

    final nuevoUsuario = UsuarioModel(
      nombre: usuario.nombre, 
      apellido: usuario.apellido, 
      numeroTelefonico: usuario.numeroTelefonico
    ).toJson();

    try{
      await docRef.set(nuevoUsuario);
      Navigator.pop(context);
    }catch(e){
      print("ha ocurrido el error $e");
    }
  }


  static Future crearPublicacion(BuildContext context, File imagenSeleccionada /*FILE*/, PublicacionModel publicacion) async{
    showDialog(
      context: context, 
      builder: ((context) {
        return const Center(
          child: SizedBox(
            width: 40.0,
            height: 40.0,
            child:  CircularProgressIndicator(),
          ),
        );
      })
    );
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
      fechaPublicacion: publicacion.fechaPublicacion,
      fechaCaducidad:  publicacion.fechaCaducidad,
      fechaMaximaPublicacion: publicacion.fechaMaximaPublicacion,
      stock: publicacion.stock
    ).toJson();

    try{
      await docRef.set(nuevaPublicacion);
      Navigator.pop(context);
      showDialog(
        context: context, 
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                height: 100.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 93, 162, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child:  Center(
                    child: Text(
                      "Los datos han sido Publicaods exitosamente!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0
                      ),
                    )
                  ),
                ),
              ),
            ),
          );
        },
      );
    }catch(e){
      print("ha ocurrido el error $e");
    }   

    

    
  }
}