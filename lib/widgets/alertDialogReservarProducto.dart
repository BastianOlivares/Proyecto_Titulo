import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';

void alertDialogReservarPorducto(BuildContext context, QueryDocumentSnapshot<Object?> publicacion){
  TextEditingController _stockController = TextEditingController();
  User auth = FirebaseAuth.instance.currentUser!;
  late String uid;
  final _formKey = GlobalKey<FormState>();

  void inputUidUser() {
    uid = (auth.uid).toString();
  }
  
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      inputUidUser();
      return Form(
        key: _formKey,
        child: AlertDialog(
          title: const Text("Cuantos productos desea reservar"),
          content: TextFormField(
            keyboardType: TextInputType.number,
            controller: _stockController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: ((value) {
              if(value!.isEmpty ) return 'El campo no puede estar vacio';
              if(int.parse(value) > publicacion['stock']) return 'Ingresar un numero menor o igual al stock ';
              return null;
            }),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Cancelar")
            ),
      
            TextButton(
              onPressed: () {
                var fechaReserva = DateTime.now();
                if(_formKey.currentState!.validate()) {
                  FirestoreHelper.crearReservaProducto(
                    publicacion,
                    uid, 
                    int.parse(_stockController.text), 
                    publicacion.id, 
                    publicacion['id_user'],
                    fechaReserva
                  );
                  Navigator.pop(context); //SALE DE LA ALERTA
                  Navigator.pop(context); //SALE DE LA PUBLICACION
                  showDialog(
                    context: context, 
                    builder: ((context) => const AlertDialog(title:  Text("¡EL PRODUCTO SE RESERVO EXITOSAMENTE!"),))
                  );
                }
              }, 
              child:const Text("Reservar")
            )
          ],
        ),
      );
    }
  );
}