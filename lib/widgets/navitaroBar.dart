import 'package:flutter/material.dart';

class navigatorBar extends StatefulWidget {
  int _paginaActual;
  navigatorBar(this._paginaActual,{super.key});

  @override
  State<navigatorBar> createState() => _navigatorBarState();
}

class _navigatorBarState extends State<navigatorBar> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index){
          setState(() {
            widget._paginaActual = index;
          });
          print(widget._paginaActual);
        },
        //pasar por parametro al modular  
        currentIndex: widget._paginaActual, //Es el donde comienza seleccionado el botton del navigationbar
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
      );
  }
}