
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_place/widgets/publicidadMenu.dart';
import 'package:market_place/widgets/showDialogPublicaci%C3%B3n.dart';

class menuView extends StatefulWidget {
  const menuView({super.key});

  @override
  State<menuView> createState() => _menuViewState();
}

class _menuViewState extends State<menuView> {

  int limitePublicacionesVerticales = 4;

  getDataCategoria(String categoria) {
    var firestore = FirebaseFirestore.instance;
    return firestore.collection("publicaciones").where('categoria', isEqualTo: categoria).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          const SizedBox(height: 10.0),

          ///AQUI EL SWIPER CON LAS PUBLICIDADES
          Container(
            width: double.infinity,
            height: 250.0,
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: const publicidadMenu(),
          ),

          ///AQUI LAS PUBLICACIONES POR CATEGORIA
          _labelCategoria("verdura"),
          _publicaionesCateoria("verdura"),
          _labelCategoria("abarrote"),
          _publicaionesCateoria("abarrote"),
          _labelCategoria("fruta"),
          _publicaionesCateoria("fruta"),
          
        ]
    );
  }

  //WIDGET CON LAS PUBLICACIONES HORIZAONTALES POR CATEGORIA
  /*
  * Comentarios: ****
  */
  Widget _labelCategoria(String categoria){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child:  Text(
        "CATEGORIA ${categoria.toUpperCase()}",
        style: const TextStyle(color: Color.fromRGBO(255, 93, 162, 1),fontSize: 40.0, fontWeight: FontWeight.bold),
      )
    );
  }
  //WIDGET CON LAS PUBLICACIONES HORIZAONTALES POR CATEGORIA
  /*
  *Comentarios: revisar si es necesario el FUTURE
  */
  Widget _publicaionesCateoria(String categoria) {
    return StreamBuilder(
      stream: getDataCategoria(categoria),
      builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              height: 300.0,
              //width: 600.0,
              child: ListView.builder( 
                itemCount: snapshot.data!.size < 3
                ? snapshot.data!.size 
                : limitePublicacionesVerticales,
                scrollDirection:  Axis.horizontal,
                itemBuilder: (BuildContext context,int index) {
                  if(index == limitePublicacionesVerticales - 1) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: (){
                          //AQUI FALTA Q EL BOTON LLEVE AL BUSCAR CON EL FILTRO APLICADO
                        }, 
                        style: ButtonStyle (
                          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).cardColor),
                        ),
                        child: const Icon(
                          Icons.arrow_circle_right_rounded,
                          size: 50.0,
                        ),
                      ),
                    );
                  }
                  else
                  {  
                    final documentSnapshot = (snapshot.data! as QuerySnapshot).docs[index];
                    return Container(
                      width: 250.0,
                      margin:const  EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: const Offset(5, 5),
                          )
                        ]
                      ),
                      child: Column(
                        children: [

                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              decoration:  BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                image: DecorationImage(
                                  image: NetworkImage(documentSnapshot['idImagen']),
                                  fit: BoxFit.cover
                                )
                              ),  
                              child: documentSnapshot['idImagen'].isEmpty == true
                                  ? const Center(child: Icon(Icons.image_not_supported_rounded, size: 50.0, color: Colors.white,))
                                  : null,                            
                            ),
                            
                          ),

                          Expanded(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        documentSnapshot['nombre'],
                                        style: const TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                                      )
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "\$${documentSnapshot['precio']}",
                                            style: const TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                  
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            onPressed: () => showDialogPublicacion(context, documentSnapshot, false),
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(70.0),
                                                ),
                                              ),
                                              backgroundColor: MaterialStatePropertyAll<Color> (Theme.of(context).cardColor),
                                            ), 
                                            child: const Text("Ver"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    );
                  }
                }//convertirlo a .builder
              ),
            ),
          );
        }
        else {
          return const Center(
            child:  SizedBox(
              width: 40.0,
              height: 40.0,
              child:  CircularProgressIndicator(),
            ),
          );
        }

      }
    );
  }
}