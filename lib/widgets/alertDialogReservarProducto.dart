import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';

void alertDialogReservarPorducto(BuildContext context, QueryDocumentSnapshot<Object?> publicacion){
  TextEditingController _stockController = TextEditingController();
  User auth = FirebaseAuth.instance.currentUser!;
  late String uid;

  void inputUidUser() {
    uid = (auth.uid).toString();
  }
  
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      inputUidUser();
      return Form(
        child: AlertDialog(
          title: const Text("Cauntos productos desea reservar"),
          content: TextFormField(
            keyboardType: TextInputType.number,
            controller: _stockController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: ((value) => 
              value != null && int.parse(value) > publicacion['stock']
              ? 'Ingresar un numero menos al stock '
              : null
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Cancelar")
            ),
      
            TextButton(
              onPressed: () {
                FirestoreHelper.crearReservaProducto(
                  publicacion,
                  uid, 
                  int.parse(_stockController.text), 
                  publicacion.id, 
                  publicacion['id_user']
                );
                Navigator.pop(context); //SALE DE LA ALERTA
                Navigator.pop(context); //SALE DE LA PUBLICACION
                showDialog(
                  context: context, 
                  builder: ((context) => const AlertDialog(title:  Text("¡EL PRODUCTO SE RESERVO EXITOSAMENTE!"),))
                );
              }, 
              child:const Text("Reservar")
            )
          ],
        ),
      );
    }
  );
}