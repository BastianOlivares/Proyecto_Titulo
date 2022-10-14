import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place/widgets/publicidadMenu.dart';

class PublicacionModel {
  final String categoria;
  final String descripcion;
  final String id_user;
  final String nombre;
  final int precio;
  final String idImagen;

  const PublicacionModel({
    required this.categoria, 
    required this.descripcion, 
    required this.id_user, 
    required this.nombre, 
    required this.precio,
    required this.idImagen,
  });

  factory PublicacionModel.fromSnapShot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PublicacionModel(
      categoria : snapshot['categoria'],
      descripcion : snapshot['descripcion'],
      id_user : snapshot['id_user'],
      nombre : snapshot['nombre'],
      precio : snapshot['precio'],
      idImagen: snapshot['idImagen'],
    );
  }

  PublicacionModel.fromJson(Map<String, Object?> json) 
    :this (
      categoria: json['categoria'] as String,
      descripcion: json['descripcion'] as String,
      id_user: json['id_user'] as String,
      nombre: json['nombre'] as String,
      precio: json['precio'] as int,
      idImagen: json['idImagen'] as String,
    );

  Map<String, Object?> toJson() => {
    "categoria" : categoria,
    "descripcion" : descripcion,
    "id_user" : id_user,
    "nombre" : nombre,
    "precio" : precio,
    "idImagen" : idImagen
  };
}