
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';
import 'package:market_place/widgets/navitaroBar.dart';

import '../model/publicacionesModel.dart';
import 'package:uuid/uuid.dart';

class venderView extends StatefulWidget {
  final String idUser;
  const venderView(this.idUser,{super.key});

  @override
  State<venderView> createState() => _venderViewState();
}

class _venderViewState extends State<venderView> {

  //VARIABLES LOCALES PARA LOS CONTROLERS
  TextEditingController _categoriaController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _precioController = TextEditingController();
  TextEditingController _fechaCaducidadController = TextEditingController();
  TextEditingController _fechaMaxCaducidadController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  final TextInputType _textoType =TextInputType.text;
  final TextInputType _numeroType = TextInputType.number;
  final TextInputType _multiLineType = TextInputType.multiline;

  static Future<QuerySnapshot> getCategorias() async {
    final refCategorias = FirebaseFirestore.instance.collection("categorias");
    
    return refCategorias.get();
  }



  //VARIABLES DE IMAGENES
  var _imagenSeleccionada;

  //VARIABLES CATEGORIA
  String _categoria = "seleccione su categoria";

  

  @override
  Widget build(BuildContext context) {
    print(widget.idUser);
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
          Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
              color: Theme.of(context).backgroundColor,
            ),
            
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.text,
                controller: _categoriaController,
                decoration: const InputDecoration(
                  border:  UnderlineInputBorder(),
                  hintText: "Categoria",
    
                ),
                onTap: () async {
                  String elegido = await elegirCategoria();
                },
              ),
            ),
          ),
        ),

          //PRECIO   ---AQUI VALIDAR Q SEA SOLONUMERO
          _inputPublicacion("PRECIO", _precioController, 1, _numeroType), 

          //NOMBRE
          _inputPublicacion("NOMBRE", _nombreController, 1, _textoType),

          //DESCRPCION
          _inputPublicacion("DESCRIPCION", _descripcionController, 10, _multiLineType),

          //FECHA CADUDIDAD
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField (
                        controller: _fechaCaducidadController,               
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_month_rounded),
                          labelText: "FECHA DE CADUCIDAD"
                        ),
                        onTap: () async{
                          DateTime? fecha = await showDatePicker(
                            context: context, 
                            initialDate: DateTime.now(), 
                            firstDate: DateTime(2000), 
                            lastDate: DateTime(2101),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary:  Color.fromRGBO(255, 93, 162, 1),// <-- SEE HERE
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface:  Colors.black, 
                                  ),
                                ),
                                child: child!,
                              ); 
                            },
                          );

                          if(fecha != null) {
                            setState(() {
                              _fechaCaducidadController.text = DateFormat('yyyy-MM-dd').format(fecha);
                              var pivoteFechaMaxima = fecha.subtract(const Duration(hours: 24));
                              _fechaMaxCaducidadController.text = DateFormat('yyyy-MM-dd').format(pivoteFechaMaxima);
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
                
                const Expanded(child: SizedBox())
              ],
            ),
          ),

          //FFECHA MAXIMA DE PUBLICACION
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        enabled: false,
                        controller: _fechaMaxCaducidadController,
                        style: const TextStyle(color: Colors.grey),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_month_rounded),
                          labelText: "FECHA MAXIMA PUBLICACIÓN"
                        ),
                      ),
                    ),
                  ),
                ),

                const Expanded(child: SizedBox())
              ],
            ),
          ),

          //STOCK DE L A PUBLICAION
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _stockController,
                        decoration:  const InputDecoration(
                          border:  UnderlineInputBorder(),
                          hintText: "STOCK",
                        ),
                      ),
                    ),
                  ),
                ),

                const Expanded(child: SizedBox())
              ],
            ),
          ),

          
              
          
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
                var fechaPublicacion = DateTime.now(); //Desde esta var puedo sumar o restar horas
                //var fechaMaximaPublicacio =fechaPublicacion.add(const Duration(hours: 24));
                var imageId = const   Uuid().v1();
                FirestoreHelper.crearPublicacion(context,_imagenSeleccionada ,PublicacionModel(
                  categoria : _categoriaController.text,
                  descripcion : _descripcionController.text,
                  id_user : widget.idUser,
                  nombre : _nombreController.text,
                  precio : int.parse(_precioController.text),
                  idImagen: imageId,
                  imagenPath: '',
                  fechaPublicacion : fechaPublicacion,
                  fechaCaducidad: DateTime.parse(_fechaCaducidadController.text),
                  fechaMaximaPublicacion: DateTime.parse(_fechaMaxCaducidadController.text),
                  stock: int.parse(_stockController.text),
                )); 
                setState(() {
                  _categoriaController = TextEditingController();
                  _nombreController = TextEditingController();
                  _descripcionController = TextEditingController();
                  _precioController = TextEditingController();
                  _fechaCaducidadController = TextEditingController();
                  _fechaMaxCaducidadController = TextEditingController();
                });               
              },
              child: Container(
                child: const Text("AGREGAR PUBLICACIÓN")
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
          padding: const EdgeInsets.all(10.0),
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

  elegirCategoria() {
    showDialog(
      context: context, 
      builder: (context) {
        return  Padding(
          padding: const EdgeInsets.fromLTRB(30, 400, 30, 400),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Expanded(
                    child: Text('CATEGORIA')
                  ),

                  const Expanded(
                    child: Text('Elija su categoria')
                  ),

                  FutureBuilder(
                    future: getCategorias(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(!snapshot.hasData) {
                        return const Center(
                          child:  SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child:  CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.size,
                          itemBuilder: (context, index) {
                            final documentSnapshot = (snapshot.data as QuerySnapshot).docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton.extended(
                                backgroundColor: Theme.of(context).primaryColor,
                                onPressed: (){
                                  Navigator.pop(context);
                                  setState(() {
                                    _categoriaController.text = documentSnapshot['nombre'];
                                  });
                                },
                                label: Text(
                                  documentSnapshot['nombre'],
                                  style: const TextStyle(color: Colors.white , fontWeight: FontWeight.bold)
                                ),
                              ),
                            );
                          }
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

}


