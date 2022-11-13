import 'package:cloud_firestore/cloud_firestore.dart';

class LocalAsociadoModel {
  final String nombre;
  final String direccion;
  final int contacto;
  final String correo;

  const LocalAsociadoModel({
    required this.nombre,
    required this.direccion,
    required this.contacto,
    required this.correo,
  });

  factory LocalAsociadoModel.fromSnapShot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return LocalAsociadoModel(
      nombre: snapshot['nombre'], 
      direccion: snapshot['direccion'], 
      contacto: snapshot['contacto'], 
      correo: snapshot['correo'], 
    );
  }

  LocalAsociadoModel.fromJson(Map<String, Object> json)
    :this (
      nombre: json['nombre'] as String, 
      direccion: json['direccion'] as String, 
      contacto: json['contacto'] as int, 
      correo: json['correo'] as String,  
    );

    Map<String, Object> toJson() => {
    "nombre" : nombre,
    "direccion" : direccion,
    "contacto" : contacto,
    "correo" : correo,

  };
  
}