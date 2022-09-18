import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place/main.dart';
import 'package:market_place/model/publicacionesModel.dart';
import 'package:market_place/widgets/publicidadMenu.dart';

class FirestoreHelper {

  static Stream<List<PublicacionModel>> read(){
    final coleccionPublicaciones = FirebaseFirestore.instance.collection('publicaciones'); //nombre de la coleccion de la BD
    return coleccionPublicaciones.snapshots().map((snapshot) => snapshot.docs.map((doc) => PublicacionModel.fromSnapShot(doc)).toList());
  }


  static Future crearPublicacion(PublicacionModel publicacion) async{
    final coleccionPublicaciones = FirebaseFirestore.instance.collection('publicaciones'); //nombre de la coleccion de la BD
    
    final docRef = coleccionPublicaciones.doc(); //nombre del documento dentro de la coleccion de la BD

    final nuevaPublicacion = PublicacionModel(
      categoria : publicacion.categoria,
      descripcion : publicacion.descripcion,
      id_user : publicacion.id_user,
      nombre : publicacion.nombre,
      precio : publicacion.precio,
    ).toJson();

    try{
      await docRef.set(nuevaPublicacion);
    }catch(e){
      print("ha ocurrido el error $e");
    }   
    
  }
}