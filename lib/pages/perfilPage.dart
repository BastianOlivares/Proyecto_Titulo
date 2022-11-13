import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/pages/agregarLocalAsociado.dart';
import 'package:market_place/pages/editarDatosEmpresa.dart';
import 'package:market_place/pages/editarPersonalPage.dart';
import 'package:market_place/pages/reservasPage.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';
import 'package:market_place/widgets/showDialogPublicaci%C3%B3n.dart';


//PUYOL

class perfilPage extends StatefulWidget {
  final String uid;
  const perfilPage(this.uid,{super.key});

  @override
  State<perfilPage> createState() => _perfilPageState();
}

class _perfilPageState extends State<perfilPage> {
  
  bool tieneLocalAsociado = false;


  @override
  void setState(VoidCallback fn) {
    
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    getDataUser(String uid) {
      var fireStore = FirebaseFirestore.instance;
      return fireStore.collection("usuarios").doc(uid).snapshots();
    }

    getLocalAsociado(String id) {
      var fireStore = FirebaseFirestore.instance;
      return fireStore.collection("localAsociado").doc(id).snapshots();
    }

    return  MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(255, 93, 162, 1),
        canvasColor: const Color.fromARGB(255, 173, 10, 81),
        cardColor: const Color.fromRGBO(218, 236, 139, 1),
        backgroundColor: const Color.fromRGBO(255, 253 , 214, 1),
        focusColor: const Color.fromRGBO(71, 208, 189, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(255, 253 , 214, 1),
      ),
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("PERFIL"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.messenger_outline_rounded),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => reservasPage(widget.uid),)),
            ),

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
                       

                        //TITULO PERFIL USUARIO
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Perfil Usuario",
                            style: TextStyle(color: Colors.white ,fontSize: 50, fontWeight: FontWeight.bold),

                          ),
                        ),
                         
                        //DATOS PERSONALES DEL USUARIO
                        Expanded(
                          flex: 4,
                          child: StreamBuilder(
                            stream: getDataUser(widget.uid),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if(! snapshot.data.data()['localAsociado'].isEmpty ) {
                                  tieneLocalAsociado = true;
                                } else {
                                  tieneLocalAsociado = false;
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 200.0,
                                    decoration: const  BoxDecoration(
                                      color: Color.fromARGB(255, 207, 74, 132),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                
                                          //TITULO DATOS PERSONALES
                                          Expanded(
                                            flex: 1,
                                            child:  mostrarLabelDatos('DATOS PERSONALES') 
                                          ),
                                
                                          //NOMBRE Y APELLIDO
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                mostrarLabelDatos('Nombre : '),
                                                mostrarDatosUsuario("${snapshot.data.data()['nombre']} "),
                                                mostrarDatosUsuario("${snapshot.data.data()['apellido']}")
                                              ],
                                            )
                                          ),
                        
                                          //TIPO DE USUARIO
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                mostrarLabelDatos('Tipo Usuario : '),
                                                mostrarDatosUsuario("${snapshot.data.data()['tipoUsuario']} ")
                                              ],
                                            )
                                          ),
                                
                                          //CORREO
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                mostrarLabelDatos('Correo : '),
                                                Flexible(child: mostrarDatosUsuario("${user.email} "))
                                                
                                              ],
                                            )
                                          ),
                                
                                          //NUMERO TELEFONICO
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                mostrarLabelDatos('Telefono : '),
                                                mostrarDatosUsuario("${snapshot.data.data()['numeroTelefonico']} ")
                                              ],
                                            )
                                          ),
                        
                                          
                                
                                          //BOTON EDITAR
                                          Expanded(
                                            flex: 1,
                                            child: FloatingActionButton.extended(
                                              elevation: 50.0,
                                              backgroundColor: const Color.fromRGBO(255, 93, 162, 1), 
                                              onPressed: () {
                                                Navigator.push(
                                                  context, 
                                                  MaterialPageRoute(builder: ((context) => editarPersonalPage(widget.uid, snapshot.data.data()['nombre'], snapshot.data.data()['apellido'], snapshot.data.data()['numeroTelefonico'])))
                                                );
                                              },
                                              label: const Text(
                                                'EDITAR',
                                                style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold)
                                              ),
                                              icon:  const Icon(Icons.edit_note_rounded),
                                            ),
                                          )
                                
                                
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const Text("Cargando...");
                              }
                            }
                          ),
                        ),

                        //DATOS DE LA EMPRESA
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: double.infinity,
                              height: 200.0,
                              decoration: const  BoxDecoration(
                                color: Color.fromARGB(255, 207, 74, 132),
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:  mostrarLabelDatos('DATOS DE LA EMPRESA'),
                                    ),
                                    Expanded(
                                      flex: 5,
                        
                                      /*
                                       *tuve que repetir el streambuilder debido a que si metia todo dentro del stream de arriba colapsaban los container
                                       *y la informacion quedaba desordenada.
                                       *Ademas la estructura que planteee en un principio con los container, no me dejaba mover mucho los widgets
                                       *y fue una de las soluciones mas rapidas que encontre
                                       *los async no dejaban hacer la sentencia del if para ver si existia o no (se stackean cuando terminan todos los procesos liberando toda la memoia)
                                      */
                                      child: StreamBuilder(
                                        stream: getDataUser(widget.uid),
                                        builder: (context, AsyncSnapshot usuario) {
                                          if(!usuario.hasData) return const Text("Cargando...");
                                          if(usuario.data.data()['localAsociado'].isEmpty) {
                                            return Center(
                                              child: Column(
                                                children: [
                                                  const Expanded(
                                                    flex: 2,
                                                    child:  Text(
                                                      "No hay Datos De Local",
                                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                                                      ),
                                                  ),
                        
                                                  Expanded(
                                                    flex: 1,
                                                    child: FloatingActionButton.extended(
                                                      elevation: 50.0,
                                                      backgroundColor: const Color.fromRGBO(255, 93, 162, 1), 
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: ((context) => const agregarLocalAsociado())));
                                                      },
                                                      label: const Text(
                                                        'Asociar un Local',
                                                        style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold)
                                                      ),
                                                      icon:  const Icon(Icons.edit_note_rounded),
                                                    ),
                                                  )
                                                ],
                                              )
                                            );
                                          }
                                          else {
                                            return StreamBuilder(
                                              stream: getLocalAsociado(usuario.data.data()['localAsociado']),
                                              builder: (context,AsyncSnapshot snapshot) {
                                                if(!snapshot.hasData) return const Center(child: Text('Cargando...'),);
                                                return Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                        children: [
                                                          mostrarLabelDatos('Nombre Local: '),
                                                          mostrarDatosUsuario("${snapshot.data.data()['nombre']} ")
                                                        ],
                                                      )
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                        children: [
                                                          mostrarLabelDatos('Dirección: '),
                                                          Flexible(child: mostrarDatosUsuario("${snapshot.data.data()['direccion']} "))
                                                        ],
                                                      )
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                        children: [
                                                          mostrarLabelDatos('Correo: '),
                                                          Flexible(child: mostrarDatosUsuario("${snapshot.data.data()['correo']} "))
                                                        ],
                                                      )
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                        children: [
                                                          mostrarLabelDatos('Contacto: '),
                                                          mostrarDatosUsuario("${snapshot.data.data()['contacto']} ")
                                                        ],
                                                      )
                                                    ),

                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          FloatingActionButton.extended(
                                                            elevation: 50.0,
                                                            backgroundColor: const Color.fromRGBO(255, 93, 162, 1), 
                                                            onPressed: () {
                                                              //print(snapshot.data.id);
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => editarDatosEmpresa(snapshot.data.data(), snapshot.data.id)));
                                                            },
                                                            label: const Text(
                                                              'EDITAR',
                                                              style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold)
                                                            ),
                                                            icon:  const Icon(Icons.edit_note_rounded),
                                                          ),

                                                          FloatingActionButton.extended(
                                                            elevation: 50.0,
                                                            backgroundColor: const Color.fromRGBO(255, 93, 162, 1), 
                                                            onPressed: () {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context, 
                                                                builder: (context) {
                                                                  return AlertDialog(
                                                                    title: const Text("¡ALERTA!"),
                                                                    content: const  Text("¿Seguro que quieres borrar los Datos de tu Local Asociado"),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(context), 
                                                                        child: const Text("No")
                                                                      ),

                                                                      TextButton(
                                                                        onPressed: () async {
                                                                          FirestoreHelper.eliminarLocalAsociado(snapshot.data.id, widget.uid);
                                                                          Navigator.pop(context);
                                                                          setState(() {});
                                                                          showDialog(
                                                                            context: context, 
                                                                            builder: ((context) {
                                                                              return const AlertDialog(
                                                                                title: Text("¡Atención!"),
                                                                                content: Text("Los datos del Local han sido eliminados exitosamente"),
                                                                              );
                                                                            })
                                                                          );
                                                                        }, 
                                                                        child:const Text("Si")
                                                                      )
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            label: const Text(
                                                              'Eliminar',
                                                              style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold)
                                                            ),
                                                            icon:  const Icon(Icons.delete),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }
                                            );
                                          }
                                        }
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                
                        //PUBLICACIONES DEL USUARIO
                        mostrarLabelDatos('TUS PUBLICACIONES'),
                        Expanded(
                          flex: 4,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('publicaciones').where('id_user', isEqualTo: widget.uid).snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ListView.builder(
                                    scrollDirection:  Axis.horizontal,
                                    itemCount: snapshot.data.size,
                                    itemBuilder: ((context, index) {
                                      final documentSnapshot = (snapshot.data as QuerySnapshot).docs[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: GestureDetector(
                                          onTap: ()=> showDialogPublicacion(context, documentSnapshot, true),
                                          child: SizedBox(
                                            width: 200.0,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex:2,
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: const Color.fromARGB(255, 207, 74, 132),
                                                      borderRadius: const  BorderRadius.only(
                                                        topRight: Radius.circular(20.0),
                                                        topLeft: Radius.circular(20.0),
                                                      ),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          documentSnapshot['idImagen'],
                                                        ), 
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),                  
                                                  )
                                                ),

                                                Expanded(
                                                  flex:1,
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.only(
                                                        bottomLeft: Radius.circular(20.0),
                                                        bottomRight: Radius.circular(20.0),
                                                      )
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            documentSnapshot['nombre'],
                                                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                                                          ),
                                                        ),

                                                        Expanded(
                                                          child: Text(
                                                            "\$${documentSnapshot['precio'].toString()}",
                                                            style: const  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                  ),
                                );
                              } else {
                                return const Text("Cargando...");
                              }
                            }
                          )
                        ),
                      ],
                    ),
                  ),
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
          )
        ),
      ),
    );
  }

  Widget mostrarLabelDatos(String label) {
    return Text(
      label,
      style: const TextStyle(color: Colors.white ,fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget mostrarDatosUsuario(String dato) {
    return Text(
      dato,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      maxLines: 1,
      
    );
  }


}