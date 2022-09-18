import 'package:flutter/material.dart';
import 'package:market_place/views/buscarView.dart';
import 'package:market_place/views/menuView.dart';
import 'package:market_place/views/venderView.dart';
import 'package:market_place/widgets/appBar.dart';
import 'package:market_place/widgets/navitaroBar.dart';
import 'package:market_place/widgets/publicidadMenu.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {

  int _paginaActual = 1;
  List <Widget> paginas = [
    venderView(),
    menuView(),
    buscarView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR
      appBar: AppBar(
      /////////////////////////////////////////////// INTENTAR MODULAR EN appBar
        backgroundColor: Colors.redAccent,
        //automaticallyImplyLeading: false,
        title: Text("EXFood"),
        actions: <Widget> [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: ()=>{}
          ), 
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: ()=>{}
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: ()=>{}
          ),
        ],
      ),
      /////////////////////////////////////////////////
      
      //BODY
      body: paginas[_paginaActual],

      //NAVITATORBART Falta linkear
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _paginaActual = index;
          });
          print(_paginaActual);
        },
        //pasar por parametro al modular  
        currentIndex: _paginaActual, //Es  donde comienza seleccionado el botton del navigationbar
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: 'Vender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 250, 71, 71),
      ),
    );
  }
}
