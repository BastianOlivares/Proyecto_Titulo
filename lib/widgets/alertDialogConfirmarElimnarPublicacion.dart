import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';

void alertDialogConfirmarElimnarPublicacion(BuildContext context, QueryDocumentSnapshot<Object?> publicacion) {
  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text("¡ALERTA!"),
        content: const  Text("¿Seguro que quieres borrar esta publicación?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("No")
          ),

          TextButton(
            onPressed: () async {
              FirestoreHelper.eliminarPublicacion(publicacion);
              Navigator.pop(context);
              Navigator.pop(context);
            }, 
            child:const Text("Si")
          )
        ],
      );
    },
  );
}