import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class buscarView extends StatefulWidget {
  const buscarView({super.key});

  @override
  State<buscarView> createState() => _buscarViewState();
}

class _buscarViewState extends State<buscarView> {

  final ScrollController _scrollController = ScrollController();
  List<String> items = [];
  bool loading = false, allLoaded = false;

  Future getData() async {
    await Future.delayed(Duration(seconds: 4));
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("publicaciones").get();
    return qn;
  }  


  //ENCARGADO DE TRAER LOS DATOS CAUNDO CORRESPONDA
  mockFetch () async {
    if(allLoaded) {
      return;
    }

    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    List<String> newData = items.length >=30 ? [] : List.generate(5, (index) => "List ${index + items.length}");
    if(newData.isNotEmpty) {
      items.addAll(newData);
    }

    setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    mockFetch();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !loading) {
        print("NUEVAS LLAMADAS"); //SE PUEDE BORRAR ES SOLO UN AVISA QUE FUNCIONA
        mockFetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if(items.isNotEmpty){
      return Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              if(index < items.length) {
                return Container(
                  margin: EdgeInsets.all(20.0),
                  height: 400.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey, //PROBAR CON WHITE54 PERO CON UN BACKGROUND DE FONDO
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(items[index], style: TextStyle(fontSize: 30.0),),
                );
              }
              else {
                return Container(
                  width: double.infinity,
                  height: 50.0,
                  child: const Center(
                    child:  Text("HASTA AQUI LLEGAN LAS PUBLICACIONES"),
                  ),

                );
              }
            }, 
            itemCount: items.length + (allLoaded?1:0),
          ),

          if(loading)...{
            Positioned(
              left: 10.0,
              bottom: 0.0,
              child:  Container(
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 80.0,
                width: 80.0,
                child: const Center(child: CircularProgressIndicator()),
              )
            )
          } 
        ],
      );
      
      
      
    }
    else {
      return Container (
        child: const Center (
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}