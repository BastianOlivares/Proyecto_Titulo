import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsuarioModel {
  final String nombre;
  final String apellido;
  final String numeroTelefonico;

  const UsuarioModel({
    required this.nombre,
    required this.apellido,
    required this.numeroTelefonico,
  });

  factory UsuarioModel.fromSnapShot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UsuarioModel(
      nombre: snapshot['nombre'], 
      apellido: snapshot['apellido'], 
      numeroTelefonico: snapshot['numeroTelefonico'], 
    );
  }

  UsuarioModel.fromJson(Map<String, Object> json)
    :this (
      nombre: json['nombre'] as String, 
      apellido: json['apellido'] as String, 
      numeroTelefonico: json['numeroTelefonico'] as String, 
    );

  Map<String, Object> toJson() => {
    "nombre" : nombre,
    "apellido" : apellido,
    "numeroTelefonico" : numeroTelefonico,
  };

}