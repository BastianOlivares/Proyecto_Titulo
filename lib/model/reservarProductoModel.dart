import 'package:cloud_firestore/cloud_firestore.dart';


class ReservarProductoModel {
  final String idComprador;
  final int cantidad;
  final String idPublicacion;
  final String idVendedor;

  const ReservarProductoModel({
    required this.idComprador,
    required this.cantidad,
    required this.idPublicacion,
    required this.idVendedor,
  });

  factory ReservarProductoModel.fromSnapShot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReservarProductoModel(
      idComprador: snapshot['idComprador'], 
      cantidad: snapshot['cantidad'], 
      idPublicacion: snapshot['idPublicacion'], 
      idVendedor: snapshot['idVendedor'], 

    );
  } 

  ReservarProductoModel.fromJson(Map<String, Object> json)
    :this(
      idComprador: json['idComprador'] as String, 
      cantidad: json['cantidad'] as int, 
      idPublicacion: json['idPublicacion']as String, 
      idVendedor: json['idVendedor']as String,
    );

  Map<String, Object> toJson() => {
    "idComprador" : idComprador,
    "cantidad" : cantidad,
    "idPublicacion" : idPublicacion,
    "idVendedor" : idVendedor
  };


}