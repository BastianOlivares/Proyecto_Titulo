
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place/widgets/publicidadMenu.dart';

class PublicacionModel {
  final String? categoria;
  final String? descripcion;
  final String? id_user;
  final String? nombre;
  final String? precio;

  PublicacionModel({this.categoria, this.descripcion, this.id_user, this.nombre, this.precio});

  factory PublicacionModel.fromSnapShot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PublicacionModel(
      categoria : snapshot['categoria'],
      descripcion : snapshot['descripcion'],
      id_user : snapshot['id_user'],
      nombre : snapshot['nombre'],
      precio : snapshot['precio'],
    );
  }

  Map<String, dynamic> toJson() => {
    "categoria" : categoria,
    "descripcion" : descripcion,
    "id_user" : id_user,
    "nombre" : nombre,
    "precio" : precio,
  };
}