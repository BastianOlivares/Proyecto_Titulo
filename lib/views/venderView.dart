
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';
import 'package:market_place/widgets/publicidadMenu.dart';
import 'package:image_picker/image_picker.dart';

import '../model/publicacionesModel.dart';
import 'package:uuid/uuid.dart';

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
  final TextEditingController _fechaCaducidadController = TextEditingController();

  final TextInputType _textoType =TextInputType.text;
  final TextInputType _numeroType = TextInputType.number;
  final TextInputType _multiLineType = TextInputType.multiline;
  final TextInputType _dataType = TextInputType.datetime;

  //VARIABLES DE IMAGENES
  var _imagenSeleccionada = null;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),

      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: <Widget> [

          //---ENCABEZADO---///
          //TITULO DE LA VISTA VENDER
          const Center(
            child: Text("PUBLICAR", style: TextStyle(fontSize: 50.0),),
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

          //PRECIO   ---AQUI VALIDAR Q SEA SOLONUMERO
          _inputPublicacion("PRECIO", _precioController, 1, _numeroType), 

          //NOMBRE
          _inputPublicacion("NOMBRE", _nombreController, 1, _textoType),

          //DESCRPCION
          _inputPublicacion("DESCRIPCION", _descripcionController, 10, _multiLineType),

          //FECHA CADUDIDAD
          _inputPublicacion("FECHA CADUCIDAD DESHABILITADO", _fechaCaducidadController, 1, _dataType),
          
          if(_imagenSeleccionada != null) 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200.0,
                width: 100.0,
                child: Image.file(_imagenSeleccionada)
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    onPressed: ()async{
                      var camara = await ImagePicker.pickImage(source: ImageSource.camera);
                      //final XFile? galeria = await _picker.pickImage(source: ImageSource.gallery);         AQUI EL DE LA GALERIA HACER UN FI
                      setState(() {
                        _imagenSeleccionada = camara as File ;
                      });
                    },
                    icon: const Icon(Icons.camera_alt_rounded),
                    color: Colors.white,
                  ),
                ),


                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    onPressed: ()async{
                      //var camara = await ImagePicker.pickImage(source: ImageSource.camera);
                      var galeria = await ImagePicker.pickImage(source: ImageSource.gallery);         
                      setState(() {
                        _imagenSeleccionada = galeria as File ;
                      });
                    },
                    icon: const Icon(Icons.add_photo_alternate_rounded),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          



          //BOTON PARA AGREGAR A LA BD
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 100.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor)
              ),
              onPressed: (){
                var imageId = const   Uuid().v1();
                FirestoreHelper.crearPublicacion(_imagenSeleccionada ,PublicacionModel(
                  categoria : _categoriaController.text,
                  descripcion : _descripcionController.text,
                  id_user : idUsuario,
                  nombre : _nombreController.text,
                  precio : int.parse(_precioController.text),
                  idImagen: imageId
                ));
              },
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
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          color: Theme.of(context).backgroundColor,
        ),
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextFormField(
            maxLines: cantidadLineas,
            keyboardType: tipoTexto,
            controller: controlador,
            decoration:  InputDecoration(
              border: const UnderlineInputBorder(),
              hintText: texto,
 
            ),
          ),
        ),
      ),
    );
  }

}

