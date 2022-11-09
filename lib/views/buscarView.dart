import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:market_place/widgets/showDialogPublicaci%C3%B3n.dart';
class buscarView extends StatefulWidget {
  const buscarView({super.key});

  @override
  State<buscarView> createState() => _buscarViewState();
}

class _buscarViewState extends State<buscarView> {
  double _currentValue = 50000;
  List<String> listaFiltros = [];

  //ORDENADO POR FECHA DE CADUCIDAD
  getPublicaiones(List<String> lista)  {
    final refPublicicacion  = FirebaseFirestore.instance.collection("publicaciones");

    if(lista.isEmpty){
      print("arreglo vacio");
      return refPublicicacion.orderBy("fechaCaducidad").snapshots();
    }   
    else {
      print("arreglo no vacio");
      return refPublicicacion.where("categoria", whereIn: lista).snapshots(); 
      // No puede ordenar su consulta por cualquier campo incluido en una cláusula de igualdad ( = ) o in .
      // https://firebase.google.com/docs/firestore/query-data/order-limit-data  [al final de las limitacion, final de pagina]
    }            
  }

  static Future<QuerySnapshot> getCategorias() async {
    final refCategorias = FirebaseFirestore.instance.collection("categorias");
    
    return refCategorias.get();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        filtros(),
        publicaiones(),
      ],
    );
  }


  Widget filtros() {
    return Container(
      height: 200.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(71, 208, 189, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
        ),
      ),
      child: Column(
        children: [

          const Padding(
            padding:  EdgeInsets.all(8.0),
            child: Text(
              "CATEGORIAS",
              style: TextStyle(color: Colors.white ,fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),

          Flexible(
            flex: 2,
            child: FutureBuilder(
              future: getCategorias(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.size,
                    itemBuilder: (context, index) {
                      bool presionado = false;
                      final documentSnapshot = (snapshot.data as QuerySnapshot).docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100.0,
                          child: ElevatedButton(
                            onPressed: (){
                              if(!include(listaFiltros, documentSnapshot['nombre'])) {
                                listaFiltros.add(documentSnapshot['nombre'].toString());
                                listaFiltros.forEach((element) => print(element));
                                setState(() {
                                  getPublicaiones(listaFiltros);
                                  }
                                );
                              }
                              else {
                                listaFiltros.remove(documentSnapshot['nombre'].toString());
                                listaFiltros.forEach((element) => print(element));
                                setState(() {
                                  getPublicaiones(listaFiltros);
                                  }
                                );
                              }
                              
                            }, 
                            child: Text(documentSnapshot['nombre'].toUpperCase()),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70.0),
                                ),
                              ),
                              backgroundColor: (include(listaFiltros, documentSnapshot['nombre'])) ? MaterialStatePropertyAll<Color>(Theme.of(context).canvasColor) : MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                else{
                  return const Center(
                    child:  SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child:  CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),


          Expanded(
            flex: 1,
            child: Container(),
          )
        ],
      ),
    );
  }

  Widget publicaiones() {
    return Expanded(
      child: StreamBuilder(
        stream: getPublicaiones(listaFiltros),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.size,
              itemBuilder: (context, index) {
                final documentSnapshot = (snapshot.data as QuerySnapshot).docs[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 500.0,
                    child: Container(
                      decoration: BoxDecoration(  //CAJA VERDE DE FONDO
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ]
                      ),
                      
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                        child: Row(
                          children: [

                            //MITAD DEL BOX DE LA IMAGEN
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                width: 100.0,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const  BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      documentSnapshot['idImagen'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            //MITAD DEL BOX DE LA INFORMACION
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                width: 100.0,
                                decoration: const  BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [

                                      //TITULO DEL PRODUCTO
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            documentSnapshot['nombre'],
                                            style: const  TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                          ),
                                        )
                                      ),

                                      //CATEGORÍA PERTENECIENTE
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Categoria: ",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),

                                            Text(
                                              documentSnapshot['categoria'],
                                            ),
                                          ],
                                        )
                                      ),

                                      //FECHA CADUCIDAD
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Fecha Caducidad: ",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),

                                            Text(
                                              DateFormat('dd-MM-yyyy').format(documentSnapshot['fechaCaducidad'].toDate())
                                            ),
                                          ],
                                        )
                                      ),

                                      //DESCRIPCION DEL PRODUCTO
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Descripción: ",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),

                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(                                                 
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    color: const Color.fromARGB(87, 158, 158, 158),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: ListView(
                                                      children: [
                                                        Text("${documentSnapshot['descripcion']}"),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ),

                                      //PRECIO Y BOTN PARA VER LA PUBLICACIÓN COMPLETA
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            //PRECIO
                                            Text(
                                              "\$${documentSnapshot['precio']}",
                                              style: const TextStyle(fontSize:20, fontWeight: FontWeight.bold),
                                            ),

                                            //BOTON
                                            ElevatedButton(
                                              onPressed: ()=> showDialogPublicacion(context, documentSnapshot, false),
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(70.0),
                                                  ),
                                                ),
                                                backgroundColor: MaterialStatePropertyAll<Color> (Theme.of(context).cardColor),
                                              ), 
                                              child: const Text("VER"),
                                            )
                                          ],
                                        ),
                                      ),
                                    

                                    ],
                                  ),
                                ),
                                
                              )
                            )
                          ]
                        ),
                      )
                    ),
                  ),
                );
              },
            );
          }
          else{
            return const Center(
              child:  SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  bool include(List<String> array, String elementoBuscado) {
    for (var objeto in array) {
      if(objeto == elementoBuscado) {
        return true;
      }
    }
    return false;
  }
}