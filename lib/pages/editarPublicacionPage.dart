import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';

class editarPublicacionPage extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> publicacion;
  const editarPublicacionPage(this.publicacion,{super.key});

  @override
  State<editarPublicacionPage> createState() => _editarPublicacionPageState();
}

class _editarPublicacionPageState extends State<editarPublicacionPage> {
  
  @override
  Widget build(BuildContext context) {
    
    TextEditingController _nombreController = TextEditingController();
    TextEditingController _categoriaController = TextEditingController();
    TextEditingController _descripcionController = TextEditingController();
    TextEditingController _precioController = TextEditingController();
    _nombreController.text = widget.publicacion['nombre'];
    _categoriaController.text = widget.publicacion['categoria'];
    _descripcionController.text = widget.publicacion['descripcion'];
    _precioController.text = widget.publicacion['precio'].toString();

    @override
    void initState() {
      super.initState();
      setState(() {
        
      });
    }
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
                                //NOMBRE DEL PRODUCTO
                                inputEditar(_nombreController, "NOMBRE : ", TextInputType.text, 1),
                                const SizedBox(height: 20.0,),

                                //CATEGORIA DEL PRODUCTO
                                inputEditar(_categoriaController, "CATEGORIA : ", TextInputType.text, 1),
                                const SizedBox(height: 20.0,),

                                //DESCRIPCION DEL PRODUCTO
                                inputEditar(_descripcionController, "DESCRIPCION : ", TextInputType.text, 10),
                                const SizedBox(height: 20.0,),

                                //PRECIO DEL PRODUCTO
                                inputEditar(_precioController, "PRECIO : ", TextInputType.number, 1),
                                const SizedBox(height: 20.0,),

                                //BOTON EDITAR
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color> (Theme.of(context).focusColor)
                                  ),
                                  onPressed: (){
                                    FirestoreHelper.editarPublicacion(
                                      widget.publicacion, 
                                      _nombreController.text,
                                      _categoriaController.text, 
                                      _descripcionController.text,
                                      int.parse(_precioController.text)
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
}