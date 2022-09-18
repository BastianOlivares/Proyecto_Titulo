
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_place/widgets/publicidadMenu.dart';

class menuView extends StatefulWidget {
  const menuView({super.key});

  @override
  State<menuView> createState() => _menuViewState();
}

class _menuViewState extends State<menuView> {

  getDataCategoria(String categoria) {
    var firestore = FirebaseFirestore.instance;
    return firestore.collection("publicaciones").where('categoria', isEqualTo: categoria).get();
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
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
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
      child:  Text("CATEGORIA ${categoria.toUpperCase()}")
    );
  }

  //WIDGET CON LAS PUBLICACIONES HORIZAONTALES POR CATEGORIA
  /*
  *Comentarios: revisar si es necesario el FUTURE
  */
  Widget _publicaionesCateoria(String categoria) {
    return FutureBuilder(
      future: getDataCategoria(categoria),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              height: 200.0,
              width: 500.0,
              child: ListView.builder( 
                itemCount: 3,
                scrollDirection:  Axis.horizontal,
                itemBuilder: (BuildContext context,int index) {
                  final documentSnapshot = (snapshot.data! as QuerySnapshot).docs[index];
                  return Container(
                    width: 250.0,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text("CATEGORIA: ${documentSnapshot['categoria']}"),
                        Text("NOMBRE: ${documentSnapshot['nombre']}"),
                        Text("DESCRIPCION: ${documentSnapshot['descripcion']}"),
                        Text("PRECIO: \$${documentSnapshot['precio']}"),
                      ],
                    )
                  );
                }//convertirlo a .builder
              ),
            ),
          );
        }
        else {
          return Center(
            child: Container(
              width: 40.0,
              height: 40.0,
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    );
  }
}