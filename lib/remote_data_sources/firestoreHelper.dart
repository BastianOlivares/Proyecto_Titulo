import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:market_place/model/localAsociadoModel.dart';
import 'package:market_place/model/publicacionesModel.dart';
import 'package:market_place/model/reservarProductoModel.dart';
import 'package:market_place/model/usuariosModel.dart';

class FirestoreHelper {

  String pathImages = 'publicaciones/';
  

  //DEVUELVE EN UNA LISTA LAS PUBLICAICONES
  static Stream<List<PublicacionModel>> read(){
    final coleccionPublicaciones = FirebaseFirestore.instance.collection('publicaciones'); //nombre de la coleccion de la BD
    return coleccionPublicaciones.snapshots().map((snapshot) => snapshot.docs.map((doc) => PublicacionModel.fromSnapShot(doc)).toList());
  }

  //DEVULVE TODAS LAS CATEGORIAS PARA UN FUTURE
  static Future<QuerySnapshot> getCategorias() async {
    final refCategorias = FirebaseFirestore.instance.collection("categorias");
    
    return refCategorias.get();
  }

  //CREA UN USUARIO NUEVO
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
      numeroTelefonico: usuario.numeroTelefonico,
      tipoUsuario: usuario.tipoUsuario,
      localAsociado: usuario.localAsociado
    ).toJson();

    try{
      await docRef.set(nuevoUsuario);
      Navigator.pop(context);
    }catch(e){
      print("ha ocurrido el error $e");
    }
  }

  //crea una publicaicon nueva
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
    final  filePath = 'publicaciones/${publicacion.idImagen}.jpg';

    if(imagenSeleccionada != null) {
      final storegeRef = FirebaseStorage.instance.ref();

      try {
        final uploadTask = storegeRef.child(filePath).putFile(imagenSeleccionada);
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
      imagenPath: filePath,
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
                      "Los datos han sido Publicados exitosamente!",
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

  //AGREGAR UNA RESERVA DE UN PRODUCTO
  static crearReservaProducto(QueryDocumentSnapshot<Object?> publicacion, String idComprador, int cantidad, String idPublicacion, String idVendedor, DateTime fechaReserva) async {
    final coleccionSolicitudes = FirebaseFirestore.instance.collection('solicitudReservaProducto'); //nombre de la coleccion de la BD
    final docRef = coleccionSolicitudes.doc();
    final nuevaSolicitud = ReservarProductoModel(
      idComprador: idComprador, 
      cantidad: cantidad, 
      idPublicacion: idPublicacion, 
      idVendedor: idVendedor,
      fechaReserva: fechaReserva
    ).toJson();
    try {
      await docRef.set(nuevaSolicitud);
    }
    catch (e) {
      print(e);
    }
    editarStock(publicacion, cantidad, 1);
  }

  static crearLocalAsociado(String uid, LocalAsociadoModel local) async {
    final coleccionLocalAsociado = FirebaseFirestore.instance.collection('localAsociado');
    final localRef = coleccionLocalAsociado.doc();
    final nuevoLocal = LocalAsociadoModel(
      nombre: local.nombre, 
      direccion: local.direccion, 
      contacto: local.contacto, 
      correo: local.correo
    ).toJson();

    try {
      await localRef.set(nuevoLocal);
    }
    catch (e) {
      print(e);
    }

    final coleccionUsarios = FirebaseFirestore.instance.collection('usuarios');
    final usuarioRef = coleccionUsarios.doc(uid);

    try {
      usuarioRef.update({
        "localAsociado" : localRef.id,
        "tipoUsuario" : 'proveedor'
      });
    }
    catch (e) {
      print(e);
    }
  }

  //EDITAR STOCK
  //0 => suma
  //1=> resta
  static editarStock(QueryDocumentSnapshot<Object?> publicacion, int cantidad, int operacion) async {

    var stockPublicacion = publicacion['stock'];

    late int stockTotal;

    if(operacion == 0) {
      stockTotal = (stockPublicacion + cantidad);
    }
    else {
      stockTotal = (stockPublicacion - cantidad);
    }
    final docRef = FirebaseFirestore.instance.collection('publicaciones').doc(publicacion.id);
    try {
      await docRef.update({
        "stock" : stockTotal,
      });
    }
    catch (e) {
      print("aaaaaaaa");
    }
    
  }


  //EDITAR STOCK PERO CON ASYNCSNAPSHOT COMO ENTRADA
  static editarStockAsyncSnapshot(AsyncSnapshot<dynamic> publicacion, String idPublicacion, int cantidad, int operacion) async {

    var stockPublicacion = publicacion.data.data()['stock'];

    late int stockTotal;

    if(operacion == 0) {
      stockTotal = (stockPublicacion + cantidad);
    }
    else {
      stockTotal = (stockPublicacion - cantidad);
    }
    final docRef = FirebaseFirestore.instance.collection('publicaciones').doc(idPublicacion);
    try {
      await docRef.update({
        "stock" : stockTotal,
      });
    }
    catch (e) {
      print("aaaaaaaa");
    }
    
  }

  //EDITAR DATOS DEL USUARIO
  static Future<void> editarDatosPersonales(
      String idUSer,
      String nombre,
      String apellido,
      int telefono
      )async {
    final docReff = FirebaseFirestore.instance.collection('usuarios').doc(idUSer);
    await docReff.update({
      'nombre': nombre,
      'apellido': apellido,
      'numeroTelefonico': telefono
    });
  }
  
  

  //EDITA UNA PUBLICAION SIN LA IMAGEN
  static Future<void> editarPublicacion(
  QueryDocumentSnapshot<Object?> publicacion, 
  String nombre,
  String categoria,
  String descripcion,
  DateTime fechaCaducidad,
  DateTime fechaMaximaPublicacion,
  int precio
  ) async {
    final docRef = FirebaseFirestore.instance.collection('publicaciones').doc(publicacion.id);
    await docRef.update({
      "nombre" : nombre,
      "descripcion" : descripcion,
      "categoria" : categoria,
      "precio" : precio,
      "fechaCaducidad" : fechaCaducidad,
      "fechaMaximaPublicacion" : fechaMaximaPublicacion
    });
  }

  //EDITAR IMAGEN
  static editarImagen( File imagen, QueryDocumentSnapshot<Object?> publicacion) async {
    final fotoRef = FirebaseStorage.instance.refFromURL(publicacion['idImagen']);
    print(publicacion['idImagen']);
    try {
      await fotoRef.putFile(imagen);
    }
    catch (error) {
      print(error);
    }
  }

  //EDITAR LOCAL ASOCIADO
  static editarLocalAsociado(String id, String nombre, String direccion, String correo,int contacto) async {
    final localRef = FirebaseFirestore.instance.collection('localAsociado').doc(id);
    await localRef.update({
      "nombre" : nombre, 
      "direccion" : direccion,
      "correo" : correo,
      "contacto" : contacto
    });
  }

  //ELIMINA UNA PUBLICAICON INCLUYENDO LA IMAGEN
  static eliminarPublicacion(QueryDocumentSnapshot<Object?> publicacion ) {
    eliminarImagnePublicacion(publicacion['imagenPath']);
    final docRef = FirebaseFirestore.instance.collection('publicaciones').doc(publicacion.id);
    docRef.delete().then((value) => {
      print("Eliminado Exitosamente")
    });
  }

  //ELIMINA UNA IMAGEN DEL STORAGE DE FIREBASE
  static eliminarImagnePublicacion(String path) async {
    final fotogeRef = FirebaseStorage.instance.ref().child(path);
    await fotogeRef.delete();
  }

  //ELINMINAR RESERVA
  static eliminarReserva(String idReserva) {
    final docRef = FirebaseFirestore.instance.collection('solicitudReservaProducto').doc(idReserva);
    docRef.delete().then((value) => {
      print('Eliminado Exitosamente'),
    });
  }

  static eliminarLocalAsociado(String idLocal, String idUsuario) async {
    final usuarioRef = FirebaseFirestore.instance.collection('usuarios').doc(idUsuario) ;
    await usuarioRef.update({
      "tipoUsuario" : 'cliente',
      "localAsociado" : '',
    });
    final localRef = FirebaseFirestore.instance.collection('localAsociado').doc(idLocal) ;
    localRef.delete().then((value) => {
      print('Eliminado correctamente')
    });
  }

}