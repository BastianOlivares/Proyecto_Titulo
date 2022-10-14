import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


//widget
class publicidadMenu extends StatefulWidget {
  const publicidadMenu({super.key});

  @override
  State<publicidadMenu> createState() => _publicidadMenuState();
}

class _publicidadMenuState extends State<publicidadMenu> {
  
  ///Extrae todos los datos dela BD sin ninguna query
  Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("publicaciones").get();
    return qn;
  }  
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return Swiper(
            viewportFraction: 0.8,
            scale: 0.9,
            itemCount: 3, ///EL SWIPER SE ENCARGA DE  SOLO MOSTRAR LOS PRIMEROS 3 ELEMNTOS DE TODAS LAS PUBLICAIONES
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
            itemBuilder: (BuildContext context,int index){
              final documentSnapshot = (snapshot.data! as QuerySnapshot).docs[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
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
            },
          );
        }else {
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