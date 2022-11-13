import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';


void showDialogEditarImagen(BuildContext context, QueryDocumentSnapshot<Object?> publicacion) {
  showDialog(
    context: context,
    builder: ((context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Editar Imagen",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Expanded(
                flex: 9,
                child: publicacion['idImagen'].isEmpty == true
                  ? const Center(child: Icon(Icons.image_not_supported_rounded, size: 50.0, color: Colors.white,))
                  : Image.network(
                    publicacion['idImagen'],
                    fit: BoxFit.contain,
                  )
                
                
              ),

              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingActionButton.extended(
                        elevation: 50.0,
                        backgroundColor: const Color.fromRGBO(255, 93, 162, 1), 
                        onPressed: () async{
                          var camara = await ImagePicker.pickImage(source: ImageSource.camera);
                          if(camara != null) {
                            FirestoreHelper.editarImagen(camara, publicacion);
                            Navigator.pop(context); //SALE DEL EDITAR
                            Navigator.pop(context); //SALE DE LA PUBLICAION COMPLETA
                            Navigator.pop(context);
                          }
                           //SALE DEL PERFIL

                          /*SE REALIZA DEBIDO A QUE AL ACTUALIZAR SOLO EL FILE DENTRO DEL STORAGE
                            LA URL NO CAMBIA POR LO QUE EL STREAMBUILDER NO ES CAPAZ DE SABER QUE HUBO
                            UN CAMBIO DENTRO DEL STORAGE LO QUE SE TRADUCE QUE NO CARGA LAIMAGEN.
                            POR ESTO DEVUELVE AL MENU PARA QUE EL USUARIO VUELVA AENTRAR EL PERFIL Y LA URL
                            CAMBIE TOTALMENTE DESDE 0 */
                        },
                        label: const Text(
                          'CÁMARA',
                          style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold)
                        ),
                        icon:  const Icon(Icons.camera_alt_rounded),
                      ),
              
              
                      FloatingActionButton.extended(
                        elevation: 50.0,
                        backgroundColor: const Color.fromRGBO(255, 93, 162, 1), 
                        onPressed: () async{
                          var galeria = await ImagePicker.pickImage(source: ImageSource.gallery);
                          if(galeria != null){
                            FirestoreHelper.editarImagen(galeria, publicacion);
                            Navigator.pop(context); //SALE DEL EDITAR
                            Navigator.pop(context); //SALE DE LA PUBLICAION COMPLETA
                            Navigator.pop(context); 
                          }//SALE DEL PERFIL

                          /*SE REALIZA DEBIDO A QUE AL ACTUALIZAR SOLO EL FILE DENTRO DEL STORAGE
                            LA URL NO CAMBIA POR LO QUE EL STREAMBUILDER NO ES CAPAZ DE SABER QUE HUBO
                            UN CAMBIO DENTRO DEL STORAGE LO QUE SE TRADUCE QUE NO CARGA LAIMAGEN.
                            POR ESTO DEVUELVE AL MENU PARA QUE EL USUARIO VUELVA AENTRAR EL PERFIL Y LA URL
                            CAMBIE TOTALMENTE DESDE 0 */
                        },
                        label: const Text(
                          'GALERÍA',
                          style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold)
                        ),
                        icon:  const Icon(Icons.add_photo_alternate_rounded),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    })
  );
}