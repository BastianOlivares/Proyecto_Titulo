import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:market_place/widgets/showDialogPublicaci%C3%B3n.dart';


//widget
class publicidadMenu extends StatefulWidget {
  const publicidadMenu({super.key});

  @override
  State<publicidadMenu> createState() => _publicidadMenuState();
}

class _publicidadMenuState extends State<publicidadMenu> {
  
  ///Extrae todos los datos dela BD sin ninguna query
  getData()  {
    var firestore = FirebaseFirestore.instance;
    return firestore.collection("publicaciones").snapshots();
    
  }  
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getData(),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          return Swiper(
            viewportFraction: 0.8,
            scale: 0.9,
            itemCount: snapshot.data.size <= 3
              ? snapshot.data.size
              : 3, ///EL SWIPER SE ENCARGA DE  SOLO MOSTRAR LOS PRIMEROS 3 ELEMNTOS DE TODAS LAS PUBLICAIONES
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
            itemBuilder: (BuildContext context,int index){
              final documentSnapshot = (snapshot.data! as QuerySnapshot).docs[index];
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                        // Text("CATEGORIA: ${documentSnapshot['categoria']}"),
                        // Text("NOMBRE: ${documentSnapshot['nombre']}"),
                        // Text("DESCRIPCION: ${documentSnapshot['descripcion']}"),
                        // Text("PRECIO: \$${documentSnapshot['precio']}"),
                      ],
                    ),
                  ),
                )
              );
            },
          );
        }else {
          return const Center(
            child: SizedBox(
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