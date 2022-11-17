import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';


class editarPublicacionPage extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> publicacion;
  const editarPublicacionPage(this.publicacion,{super.key});

  @override
  State<editarPublicacionPage> createState() => _editarPublicacionPageState();
}

class _editarPublicacionPageState extends State<editarPublicacionPage> {
  
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _fechaCaducidadController = TextEditingController();
  final TextEditingController _fechaMaxPublicaionController = TextEditingController();
final TextEditingController _stockController = TextEditingController();
  
  
  Future<QuerySnapshot> getCategorias() async {
    final refCategorias = FirebaseFirestore.instance.collection("categorias");
    
    return refCategorias.get();
  }

  @override
  void initState() {
    _nombreController.text = widget.publicacion['nombre'];
    _categoriaController.text = widget.publicacion['categoria'];
    _descripcionController.text = widget.publicacion['descripcion'];
    _precioController.text = widget.publicacion['precio'].toString();
    _fechaCaducidadController.text = DateFormat('yyyy-MM-dd').format(widget.publicacion['fechaCaducidad'].toDate());
    _fechaMaxPublicaionController.text = DateFormat('yyyy-MM-dd').format(widget.publicacion['fechaMaximaPublicacion'].toDate());
    _stockController.text = widget.publicacion['stock'].toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(255, 93, 162, 1),
        canvasColor: const Color.fromARGB(255, 173, 10, 81),
        cardColor: const Color.fromRGBO(218, 236, 139, 1),
        backgroundColor: const Color.fromRGBO(255, 253 , 214, 1),
        focusColor: const Color.fromRGBO(71, 208, 189, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(255, 253 , 214, 1),
      ),
      title: "Editar Publicacion",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("EDITAR PUBLICACIÓN"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const  BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      children: [

                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Editar Publicación",
                            style: TextStyle(color: Colors.white ,fontSize: 50, fontWeight: FontWeight.bold),

                          ),
                        ),

                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView(
                              children: [

                                //FECHA DE CADUCIDAD
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      controller: _fechaCaducidadController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "Fecha Caducidad: ",
                                        labelStyle: TextStyle(
                                          color: Colors.white
                                        )
                                      ),
                                      style: const TextStyle(
                                        color:  Colors.white,
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
                                            _fechaMaxPublicaionController.text = DateFormat('yyyy-MM-dd').format(pivoteFechaMaxima);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0,),

                                //NOMBRE DEL PRODUCTO
                                inputEditar(_nombreController, "NOMBRE : ", TextInputType.text, 1),
                                const SizedBox(height: 20.0,),

                                //CATEGORIA DEL PRODUCTO
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      controller: _categoriaController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "CATEGORIA: ",
                                        labelStyle: TextStyle(
                                          color: Colors.white
                                        )
                                      ),
                                      style: const TextStyle(
                                        color:  Colors.white,
                                      ),
                                      onTap: () async {
                                        await elegirCategoria();
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0,),

                                //DESCRIPCION DEL PRODUCTO
                                inputEditar(_descripcionController, "DESCRIPCION : ", TextInputType.text, 10),
                                const SizedBox(height: 20.0,),

                                //PRECIO DEL PRODUCTO
                                inputEditar(_precioController, "PRECIO : ", TextInputType.number, 1),
                                const SizedBox(height: 20.0,),

                                //STOCK
                                inputEditar(_stockController, "STOCK : ", TextInputType.number, 1),
                                const SizedBox(height: 20.0,),

                                

                                //BOTON EDITAR
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color> (Theme.of(context).focusColor)
                                  ),
                                  onPressed: (){
                                    DateTime auxFechaCaducidad = DateTime.parse(_fechaCaducidadController.text);
                                    DateTime auxFechaMaximaPub = DateTime.parse(_fechaMaxPublicaionController.text);
                                    FirestoreHelper.editarPublicacion(
                                      widget.publicacion, 
                                      _nombreController.text,
                                      _categoriaController.text, 
                                      _descripcionController.text,
                                      auxFechaCaducidad,
                                      auxFechaMaximaPub,
                                      int.parse(_precioController.text), 
                                      int.parse(_stockController.text)
                                    );
                                    Navigator.pop(context);
                                    
                                  }, 
                                  child: const Text("EDITAR"),
                                )

                              ],
                            ),
                          ),
                        ),

                        
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
    
  }

  Widget inputEditar(TextEditingController controlador, String label, TextInputType inputType, int maxLineas) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          maxLines: maxLineas,
          keyboardType: inputType,
          controller: controlador,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.white
            )
          ),
          style: const TextStyle(
            color:  Colors.white,
          )
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
                    child: Text(
                      'CATEGORIA',
                      style: TextStyle(color: Colors.black, fontSize: 15,),
                    )
                  ),

                  const Expanded(
                    child: Text(
                      'Elija su categoria',
                      style: TextStyle(
                        color: Colors.black, fontSize: 15,
                        decoration: TextDecoration.underline
                      ), 
                    )
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