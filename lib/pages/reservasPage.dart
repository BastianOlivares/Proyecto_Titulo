import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class reservasPage extends StatefulWidget {
  final String uid;
  const reservasPage(this.uid,{super.key});

  @override
  State<reservasPage> createState() => _reservasPageState();
}

class _reservasPageState extends State<reservasPage> {
  getReservaciones(String uid) {
    var fireStore = FirebaseFirestore.instance;
    return fireStore.collection("solicitudReservaProducto").where("idVendedor", isEqualTo: uid).snapshots();
  }

  getPublicaion(String idPublicaion) {
    var fireStore = FirebaseFirestore.instance;
    return fireStore.collection("publicaciones").doc(idPublicaion).snapshots();
  }

  getComprador(String idComprador) {
    var fireStore = FirebaseFirestore.instance;
    return fireStore.collection("usuarios").doc(idComprador).snapshots();
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(255, 93, 162, 1),
        canvasColor: const Color.fromARGB(255, 173, 10, 81),
        cardColor: const Color.fromRGBO(218, 236, 139, 1),
        backgroundColor: const Color.fromRGBO(255, 253 , 214, 1),
        focusColor: const Color.fromRGBO(71, 208, 189, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(255, 253 , 214, 1),
      ),
      title: 'Reservas',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("RESERVAS"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () => Navigator.pop(context),
            ),
            
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [

                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const  BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Reservas",
                            style: TextStyle(color: Colors.white ,fontSize: 50, fontWeight: FontWeight.bold),

                          ),
                        ),

                        Expanded(
                          flex: 9,
                          child: StreamBuilder(
                            stream: getReservaciones(widget.uid),
                            builder: (context, AsyncSnapshot snapshot) {
                              if(!snapshot.hasData) {
                                return const Text("Cargando...");
                              }
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListView.builder(
                                  itemCount: snapshot.data.size,
                                  itemBuilder: (context, index) {
                                    final documentSnapshot = (snapshot.data as QuerySnapshot).docs[index];
                                    final fechaReserva = DateFormat('yyyy-MM-dd').format(documentSnapshot['fechaReserva'].toDate());
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 300.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration (
                                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                          color: Theme.of(context).cardColor
                                        ),
                                        child: StreamBuilder<Object>(
                                          stream: getPublicaion(documentSnapshot['idPublicacion']),
                                          builder: (context, AsyncSnapshot publicacion) {
                                            if(!publicacion.hasData) {
                                              return const Text("Cargando...");
                                            }
                                            return Row(
                                              children: [
                                        
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration (
                                                      color: Theme.of(context).canvasColor,
                                                      borderRadius: const  BorderRadius.only(
                                                        bottomLeft: Radius.circular(30.0),
                                                        topLeft: Radius.circular(30.0),
                                                      ),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          publicacion.data.data()['idImagen'],
                                                        ),
                                                        fit: BoxFit.cover
                                                      )
                                                    ),
                                                  )
                                                ),
                                        
                                                Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: StreamBuilder(
                                                          stream: getComprador(documentSnapshot['idComprador']),
                                                          builder: (context, AsyncSnapshot usuario) {
                                                            if(!usuario.hasData) {
                                                              return const Text("Cargando...");
                                                            }
                                                            return Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.all(10.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Center(
                                                                          child: Row(
                                                                            children: [
                                                                              Text(
                                                                                "${usuario.data.data()['nombre']} ",
                                                                                style: const  TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Text(
                                                                                usuario.data.data()['apellido'],
                                                                                style: const  TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child: Center(
                                                                          child: Row(
                                                                            children: [
                                                                              CircleAvatar(
                                                                                radius: 30,
                                                                                backgroundColor: Theme.of(context).primaryColor,
                                                                                child: IconButton(
                                                                                  onPressed: () async {
                                                                                    final Uri llamarLaunchUri = Uri(
                                                                                      scheme: 'tel',
                                                                                      path: "+569${usuario.data.data()['numeroTelefonico']}"
                                                                                    );

                                                                                    if(await canLaunchUrl(llamarLaunchUri)) {
                                                                                      await launchUrl(llamarLaunchUri);
                                                                                    }
                                                                                  }, 
                                                                                  iconSize: 30 ,
                                                                                  icon: Icon(Icons.call_outlined),
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),

                                                                              Text(
                                                                                "+569 ${usuario.data.data()['numeroTelefonico']}",
                                                                                style: const  TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      Expanded(
                                                                        child: Center(
                                                                          child: Text(
                                                                            "Reservado: $fechaReserva",
                                                                            style: const  TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        )
                                                      ),

                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(10.0),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'Ha reservado :',
                                                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                              ),

                                                              Text(
                                                                documentSnapshot['cantidad'].toString(),
                                                                style: const TextStyle(fontSize: 25),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ),

                                                      Expanded(
                                                        child: Text(
                                                          publicacion.data.data()['nombre'],
                                                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                        )
                                                      ),

                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(10.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              FloatingActionButton.extended(
                                                                elevation: 50.0,
                                                                backgroundColor: Theme.of(context).primaryColor,
                                                                onPressed: (){
                                                                  FirestoreHelper.eliminarReserva(documentSnapshot.id);
                                                                  showDialog(
                                                                    context: context, 
                                                                    builder: ((context) => const AlertDialog(title:  Text("¡LA RESERVACIÓN FUE ACEPTADA"),))
                                                                  );
                                                                },
                                                                label: const Text(
                                                                  'Aceptar ',
                                                                  style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)
                                                                ),
                                                                icon: const Icon(Icons.check),
                                                              ),

                                                              FloatingActionButton.extended(
                                                                elevation: 50.0,
                                                                backgroundColor: Theme.of(context).primaryColor,
                                                                onPressed: (){
                                                                  FirestoreHelper.editarStockAsyncSnapshot(publicacion, documentSnapshot['idPublicacion'], documentSnapshot['cantidad'], 0);
                                                                  FirestoreHelper.eliminarReserva(documentSnapshot.id);
                                                                  showDialog(
                                                                    context: context, 
                                                                    builder: ((context) => const AlertDialog(title:  Text("¡LA RESERVACIÓN FUE RECHAZADA!"),))
                                                                  );
                                                                },
                                                                label: const Text(
                                                                  'Rechazar ',
                                                                  style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)
                                                                ),
                                                                icon: const Icon(Icons.delete_rounded),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ),
                                                    ],
                                                  )
                                                )
                                              ],
                                            );
                                          }
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ),

                Expanded(
                  flex: 1,
                  child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}