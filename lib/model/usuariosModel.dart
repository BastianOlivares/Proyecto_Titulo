import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioModel {
  final String nombre;
  final String apellido;
  final String numeroTelefonico;
  final String tipoUsuario;
  final String localAsociado;


  const UsuarioModel({
    required this.nombre,
    required this.apellido,
    required this.numeroTelefonico,
    required this.tipoUsuario,
    required this.localAsociado,
  });

  factory UsuarioModel.fromSnapShot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UsuarioModel(
      nombre: snapshot['nombre'], 
      apellido: snapshot['apellido'], 
      numeroTelefonico: snapshot['numeroTelefonico'], 
      tipoUsuario: snapshot['tipoUsuario'], 
      localAsociado: snapshot['localAsociado'], 
    );
  }

  UsuarioModel.fromJson(Map<String, Object> json)
    :this (
      nombre: json['nombre'] as String, 
      apellido: json['apellido'] as String, 
      numeroTelefonico: json['numeroTelefonico'] as String, 
      tipoUsuario: json['tipoUsuario'] as String,  
      localAsociado: json['localAsociado'] as String, 
    );

  Map<String, Object> toJson() => {
    "nombre" : nombre,
    "apellido" : apellido,
    "numeroTelefonico" : numeroTelefonico,
    "tipoUsuario" : tipoUsuario,
    "localAsociado" : localAsociado

  };

}