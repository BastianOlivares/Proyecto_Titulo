import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class buscarView extends StatefulWidget {
  const buscarView({super.key});

  @override
  State<buscarView> createState() => _buscarViewState();
}

class _buscarViewState extends State<buscarView> {
  double rating = 10;
  List<String> listaFiltros = [];

  static Future<QuerySnapshot> getPublicaiones(List<String> lista) async {
    final refPublicicacion  = FirebaseFirestore.instance.collection("publicaciones");

    if(lista.isEmpty){
      print("arreglo vacio");
      return refPublicicacion.get();
    }   
    else {
      print("arreglo no vacio");
      return refPublicicacion.where("categoria", whereIn: lista).get();
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
            child: Text("CATEGORIA"),
          ),

          Expanded(
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
                  return Center(
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),

          const Padding(
            padding:  EdgeInsets.all(8.0),
            child: Text("RANGO DE PRECIO"),
          ),

          Slider(
            value: rating,
            onChanged: (newRating) {
              setState(() => rating = newRating);
            },
            min: 0,
            max: 50000 ,
            divisions: 20,
            label: "\$${rating.toInt()}",
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).cardColor,
          ),
        ],
      ),
    );
  }

  Widget publicaiones() {
    return Expanded(
      child: FutureBuilder(
        future: getPublicaiones(listaFiltros),
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
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor
                      ),
                      child: Column(
                        children: [
                          Text(documentSnapshot['nombre']),
                          Text(documentSnapshot['categoria']),
                          Text(documentSnapshot['descripcion']),
                          Text(documentSnapshot['precio'].toString()),
                          
                          ElevatedButton(
                            onPressed: (){}, 
                            child: const Text("VER"),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else{
            return Center(
              child: Container(
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