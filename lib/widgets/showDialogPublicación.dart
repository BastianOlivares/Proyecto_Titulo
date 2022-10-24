import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void showDialogPublicacion (BuildContext context, QueryDocumentSnapshot<Object?> documentSnapshot) {
  
  var snapshotUser = getUsuario(documentSnapshot['id_user']);



  showDialog(
    barrierDismissible: true,
    context: context, 
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [

              //IMAGEN DEL PRODUCTO
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0), 
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        documentSnapshot['idImagen'],
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffDAEC8B),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0), 
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(
                      children: [
                        //SECCION DEL PRODUCTO
                        Container(
                          color: Theme.of(context).primaryColor,
                          child: const Center(
                            child: Text(
                              "DATOS DEL PRODUCTO",
                              style:  TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            "${documentSnapshot['nombre']}".toUpperCase(),
                            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(103, 171, 185, 109),
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const Text(
                                    "Categoria: ",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),

                                  Text(
                                    "${documentSnapshot['categoria']}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 300.0,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(103, 171, 185, 109),
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView(
                                children: [
                                  const Text(
                                    "Descripción: ",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "${documentSnapshot['descripcion']}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(103, 171, 185, 109),
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const Text(
                                    "Precio: ",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),

                                  Text(
                                    "\$${documentSnapshot['precio']}",
                                    style: const  TextStyle(fontSize: 25),
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 50.0,),
                        //SECCION DE PROVEEDOR
                        Container(
                          color: Theme.of(context).primaryColor,
                          child: const Center(
                            child: Text(
                              "DATOS DEL PROVEEDOR",
                              style:  TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                          

                        StreamBuilder(
                          stream:  FirebaseFirestore.instance.collection("users").where(FieldPath.documentId, isEqualTo: documentSnapshot['id_user']).snapshots(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData) {
                              return const Center(
                                child:  SizedBox(
                                  width: 40.0,
                                  height: 40.0,
                                  child:  CircularProgressIndicator(),
                                ),
                              );
                            }
                            final doc = (snapshot.data as QuerySnapshot).docs[0];

                            return Container(
                              height: 300.0,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(103, 171, 185, 109),
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              //ARREGLAR CON LOS PARAMETROS QUE CORRESPONDAN
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Text(doc['nombre']),
                                  ),
                                  Expanded(
                                    child: Text(doc['correo']),
                                  ),
                                  Expanded(
                                    child: Text(doc['contraseña']),
                                  )

                                ],
                              )

                            );
                          },
                        )

                      ],
                    ),
                  ),
                ),
                
              )

            ],
          )
        ),
      );
    },
  );
}

getUsuario(String idUser) async{
  var firestore = FirebaseFirestore.instance;
  return firestore.collection("users")
                  .where(FieldPath.documentId, isEqualTo: idUser)
                  .snapshots();
}