import 'package:cloud_firestore/cloud_firestore.dart';

class PublicacionModel {
  final String categoria;
  final String descripcion;
  final String id_user;
  final String nombre;
  final int precio;
  final String idImagen;
  final String imagenPath;
  final DateTime fechaPublicacion;
  final DateTime fechaCaducidad;
  final DateTime fechaMaximaPublicacion;
  final int stock;

  const PublicacionModel({
    required this.categoria, 
    required this.descripcion, 
    required this.id_user, 
    required this.nombre, 
    required this.precio,
    required this.idImagen,
    required this.imagenPath,
    required this.fechaPublicacion,
    required this.fechaCaducidad,
    required this.fechaMaximaPublicacion,
    required this.stock,
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
      imagenPath: snapshot['imagenPath'],
      fechaPublicacion: snapshot['fechaPublicacion'],
      fechaCaducidad: snapshot['fechaCaducidad'],
      fechaMaximaPublicacion: snapshot['fechaMaximaPublicacion'],
      stock: snapshot['stock'],
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
      imagenPath: json['imagenPath'] as String,
      fechaPublicacion: json['fechaPublicacion'] as DateTime,
      fechaCaducidad: json['fechaCaducidad'] as DateTime,
      fechaMaximaPublicacion: json['fechaMaximaPublicacion'] as DateTime,
      stock: json['stock'] as int,
    );

  Map<String, Object?> toJson() => {
    "categoria" : categoria,
    "descripcion" : descripcion,
    "id_user" : id_user,
    "nombre" : nombre,
    "precio" : precio,
    "idImagen" : idImagen,
    "imagenPath" : imagenPath,
    "fechaPublicacion" : fechaPublicacion,
    "fechaCaducidad": fechaCaducidad,
    "fechaMaximaPublicacion": fechaMaximaPublicacion,
    "stock" : stock,
  };
}