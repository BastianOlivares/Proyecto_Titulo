import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';
import 'package:market_place/widgets/publicidadMenu.dart';

import '../model/publicacionesModel.dart';

class venderView extends StatefulWidget {
  const venderView({super.key});

  @override
  State<venderView> createState() => _venderViewState();
}

class _venderViewState extends State<venderView> {

  //VARIABLES PARA LOS DATOS DEL USUARIO
  String idUsuario = 'Q1mREi1iIhiW9b9vC3nM';
  String nombreUsuario = 'Bastian Olivares';
  

  //VARIABLES LOCALES PARA LOS CONTROLERS
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  final TextInputType _textoType =TextInputType.text;
  final TextInputType _numeroType = TextInputType.number;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: ListView(
        children:  [

          //---ENCABEZADO---///
          //TITULO DE LA VISTA VENDER
          const Center(
            child: Text("Publicaiones", style: TextStyle(fontSize: 50.0),),
          ),

          //DESCRIPCION DE LA VIEW VENDER
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("aqui podras realizar tuspublicaiones para subir a la base de datos las cuales seran guardas para una posterior revision",
              style: TextStyle(fontSize: 20.0),
            ),
          ),

          //----INPUTS----//
          //CATEGORIA
          _inputPublicacion("CATEGORIA", _categoriaController, 1, _textoType),

          //NOMBRE
          _inputPublicacion("NOMBRE", _nombreController, 1, _textoType),

          //DESCRPCION
          
          _inputPublicacion("DESCRIPCION", _descripcionController, 10, _textoType),

          //PRECIO   ---AQUI VALIDAR Q SEA SOLONUMERO
          _inputPublicacion("PRECIO", _precioController, 1, _numeroType), 


          //BOTON PARA AGREGAR A LA BD
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 100.0),
            child: MaterialButton(
              color: Colors.redAccent,
              onPressed: ()=> {FirestoreHelper.crearPublicacion(PublicacionModel(
                categoria : _categoriaController.text,
                descripcion : _descripcionController.text,
                id_user : idUsuario,
                nombre : _nombreController.text,
                precio : _precioController.text,
              ))},
              child: Container(
                child:const Text("AGREGAR PUBLICACIÓN")
              ), 
            ),
          ),
          
          ],
      ),
    );
  }

  Widget _inputPublicacion(String texto, TextEditingController controlador, int cantidadLineas, TextInputType tipoTexto) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
        child: TextFormField(
          maxLines: cantidadLineas,
          keyboardType: tipoTexto,
          controller: controlador,
          decoration:  InputDecoration(
            border: const OutlineInputBorder(),
            hintText: texto,
          ),
        ),
      ),
    );
  }

}

