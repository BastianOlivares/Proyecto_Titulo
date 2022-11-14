
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';

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

  final _formKey = GlobalKey<FormState>();

  static Future<QuerySnapshot> getCategorias() async {
    final refCategorias = FirebaseFirestore.instance.collection("categorias");
    
    return refCategorias.get();
  }



  //VARIABLES DE IMAGENES
  var _imagenSeleccionada;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),

      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget> [
      
            //---ENCABEZADO---///
            //TITULO DE LA VISTA VENDER
            const Center(
              child: Text(
                "PUBLICAR", 
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
              ),
            ),
      
            //DESCRIPCION DE LA VIEW VENDER
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Aquí podras realizar tus publicaiones para poder visualizarlas en la aplicaión, y de esta forma los usurios puedan reservar sus preferencias.",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
      
            //----INPUTS----//
      
            //CATEGORIA
            Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(30.0),
                color: Theme.of(context).backgroundColor,
              ),
              
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: _categoriaController,
                  decoration: const InputDecoration(
                    border:  InputBorder.none,
                    hintText: "Categoria",
          
                  ),
                  onTap: () async {
                    await elegirCategoria();
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ((value){ 
                    if(value!.isEmpty) return 'La categoría no puede esatr vacia.';
                    return null;
                  }),
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
                        borderRadius:  BorderRadius.circular(30.0),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField (
                          controller: _fechaCaducidadController,               
                          decoration: const InputDecoration(
                            border:  InputBorder.none,
                            icon: Icon(Icons.calendar_month_rounded),
                            labelText: "FECHA DE CADUCIDAD"
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value){ 
                            if(value!.isEmpty) return 'La fecha no puede estar vacia';
                            return null;
                          }),
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
                        borderRadius:  BorderRadius.circular(30.0),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          enabled: false,
                          controller: _fechaMaxCaducidadController,
                          style: const TextStyle(color: Colors.grey),
                          decoration: const InputDecoration(
                            border:  InputBorder.none,
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
      
            //STOCK DE LA PUBLICAION
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(30.0),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _stockController,
                          decoration:  const InputDecoration(
                            border:  InputBorder.none,
                            hintText: "STOCK",
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value){ 
                            if(value!.isEmpty) return 'El stock no puede estar vacio';
                            return null;
                          }),
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
                          _imagenSeleccionada = camara ;
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
                          _imagenSeleccionada = galeria ;
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
                  if(_imagenSeleccionada == null) {
                    showDialog(
                      context: context, 
                      builder: ((context) {
                        return const AlertDialog(
                          title: Text("¡Atención!"),
                          content: Text("Es necesario que suba una foto del producto"),
                        );
                      })
                    );
                  }
                  else{
                    if(_formKey.currentState!.validate()){
                      var fechaPublicacion = DateTime.now(); //Desde esta var puedo sumar o restar horas
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
                    }   
                  }    
                },
                child: const Text("AGREGAR PUBLICACIÓN"), 
              ),
            ),
            
            ],
        ),
      ),
    );
  }

  Widget _inputPublicacion(String texto, TextEditingController controlador, int cantidadLineas, TextInputType tipoTexto) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(30.0),
          color: Theme.of(context).backgroundColor,
        ),
        
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            maxLines: cantidadLineas,
            keyboardType: tipoTexto,
            controller: controlador,
            decoration:  InputDecoration(
              border:  InputBorder.none,
              hintText: texto,
 
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: ((value){ 
              if(value!.isEmpty) return 'Este campo no puede estar vacio';
              return null;
            }),
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


