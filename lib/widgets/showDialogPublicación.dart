import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market_place/pages/editarPublicacionPage.dart';
import 'package:market_place/widgets/alertDialogConfirmarElimnarPublicacion.dart';
import 'package:market_place/widgets/alertDialogReservarProducto.dart';
import 'package:market_place/widgets/showDialogEditarImagen.dart';
import 'package:url_launcher/url_launcher.dart';


/*El editar es para entregar un boton donde se permita editar y borrar la publicacion q se quiere mostra
solo se permitira editar al ingresar desde el perfil a las publicacions del usuario del perfil*/
void showDialogPublicacion (BuildContext context, QueryDocumentSnapshot<Object?> publicacion, bool editar) {
  
  var id= publicacion['id_user'];

  getLocalAsociado(String id) {
    var fireStore = FirebaseFirestore.instance;
    return fireStore.collection("localAsociado").doc(id).snapshots();
  }


  final docRef = FirebaseFirestore.instance.collection("usuarios").doc(id);
  docRef.get().then(
    (DocumentSnapshot doc) {
      final proveedor = doc.data() as Map<String, dynamic>;
        showDialog(
        barrierDismissible: true,
        context: context, 
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
            child: Container(
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
                            publicacion['idImagen'],
                          ),
                          fit: BoxFit.cover,
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: editar == true
                        ? FloatingActionButton.extended(
                            elevation: 50.0,
                            backgroundColor: const  Color.fromARGB(134, 255, 255, 255),
                            onPressed: (){
                              showDialogEditarImagen(context, publicacion);
                            },
                            label: const Text(
                              'EDITAR IMAGEN ',
                              style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold)
                            ),
                            icon: const Icon(
                              Icons.edit_note_rounded,
                              color: Colors.black,
                            ),
                          )
                        : null
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

                            //--SECCION DEL PRODUCTO--
                            Container(
                              color: Theme.of(context).primaryColor,
                              child:  Center(
                                child: tituloSeccion("DATOS DEL PRODUCTO")
                              ),
                            ),

                            //NOMBRE DEL PRODUCTO
                            Center(
                              child: Text(
                                "${publicacion['nombre']}".toUpperCase(),
                                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                            ),

                            //CATEGOR??A DEL PRODUCTO
                            seccionInformacion("Categor??a", publicacion['categoria']),

                            //DESCRIPCION DEL PRODUCTO
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
                                        "Descripci??n: ",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "${publicacion['descripcion']}",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //PRECIO DEL PRODUCTO
                            seccionInformacion("Precio", "\$${publicacion['precio']}"),
                            seccionInformacion("Fecha de publicaci??n", DateFormat('dd-MM-yy').format(publicacion['fechaPublicacion'].toDate())),
                            seccionInformacion("Fecha de caducidad", "${DateFormat('dd-MM-yy').format(publicacion['fechaCaducidad'].toDate())  }"),
                            seccionInformacion("Stock", "${publicacion['stock']}"),

                            editar == true 
                            ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  FloatingActionButton.extended(
                                    elevation: 50.0,
                                    backgroundColor: Theme.of(context).primaryColor,
                                    onPressed: (){
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => editarPublicacionPage(publicacion)));
                                       
                                    },
                                    label: const Text(
                                      'EDITAR ',
                                      style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)
                                    ),
                                    icon: const Icon(Icons.edit_note_rounded),
                                  ),

                                  FloatingActionButton.extended(
                                    elevation: 50.0,
                                    backgroundColor: Theme.of(context).primaryColor,
                                    onPressed: (){
                                      alertDialogConfirmarElimnarPublicacion(context, publicacion);
                                    },
                                    label: const Text(
                                      'ELIMINAR ',
                                      style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)
                                    ),
                                    icon: const Icon(Icons.delete_rounded),
                                  ),
                                ],
                              ),
                            )
                            : Visibility(
                              visible: publicacion['stock'] == 0 ?false :true,
                              child: FloatingActionButton.extended(
                                  elevation: 50.0,
                                  
                                  backgroundColor: Theme.of(context).primaryColor,
                                  onPressed: (){
                                    alertDialogReservarPorducto(context, publicacion);
                                  },
                                  label: const Text(
                                    'Reservar ',
                                    style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)
                                  ),
                                  icon: const Icon(Icons.check_circle_outline_rounded),
                                ),
                            ),
                              
                            const SizedBox(height: 20.0),


                            //--SECCION DE PROVEEDOR--

                            Container(
                              color: Theme.of(context).primaryColor,
                              child: Center(
                                child: tituloSeccion("DATOS DEL PROVEEDOR")
                              ),
                            ),

                            //NOMBRE DLE PROVEEDOR
                            seccionInformacion("Nombre", proveedor['nombre']),
                            //APELLIDO DEL PROVEEDOR
                            seccionInformacion("Apellido",proveedor['apellido'] ),
                            //NUMERO DEL PROVEEDOR
                            seccionInformacion("Telefono", proveedor['numeroTelefonico'].toString()),

                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: FloatingActionButton.extended(
                                elevation: 50.0,
                                
                                backgroundColor: Theme.of(context).primaryColor,
                                onPressed: () async {
                                  final Uri llamarLaunchUri = Uri(
                                    scheme: 'tel',
                                    path: "+569${proveedor['numeroTelefonico']}"
                                  );

                                  if(await canLaunchUrl(llamarLaunchUri)) {
                                    await launchUrl(llamarLaunchUri);
                                  }
                                },
                                label: const Text(
                                  'Llamar ',
                                  style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)
                                ),
                                icon: const Icon(Icons.call),
                              ),
                            ),


                            Container(
                              color: Theme.of(context).primaryColor,
                              child: Center(
                                child: tituloSeccion("DATOS DEL LOCAL ASOCIADO")
                              ),
                            ),

                            proveedor['localAsociado'].isEmpty == false
                            ? StreamBuilder(
                              stream: getLocalAsociado(proveedor['localAsociado']),
                              builder: (BuildContext context, AsyncSnapshot local) {
                                if(!local.hasData) return const Center(child: Text('Cargando...'));
                                return SizedBox(
                                  height: 400.0,
                                  child: Column(
                                    children: [
                                      Expanded(child: seccionInformacion("Nombre Local", local.data!.data()['nombre'])),
                                      Expanded(child: seccionInformacion("Direcci??n Local", local.data!.data()['direccion'])),
                                      Expanded(child: seccionInformacion("Contacto Local", local.data!.data()['contacto'].toString())),
                                      Expanded(child: seccionInformacion("Correo Local", local.data!.data()['correo'])),
                                    ],
                                  ),
                                );
                              },
                            )
                            : seccionInformacion("EL PROVEEDOR NO TIENE UN LOCAL ASOCIADO", ''),
                            
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
    },
    onError: (e) => print("Error getting document: $e"),
  );
}

Widget tituloSeccion(String titulo) {
  return Text(
    titulo,
    style:  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
  );
}

Widget seccionInformacion(String label, String info) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: double.infinity,
      height: 70.0,
      decoration: BoxDecoration(
        color: const Color.fromARGB(103, 171, 185, 109),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text(
              "$label: ",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Flexible(
              child: Text(
                info,
                style: const  TextStyle(fontSize: 25),
              ),
            ),
          ]
        ),
      ),
    ),
  );
}
