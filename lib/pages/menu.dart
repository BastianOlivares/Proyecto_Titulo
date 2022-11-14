import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/pages/perfilPage.dart';
import 'package:market_place/pages/personalRegister.dart';
import 'package:market_place/views/buscarView.dart';
import 'package:market_place/views/menuView.dart';
import 'package:market_place/views/venderView.dart';
import 'package:market_place/widgets/publicidadMenu.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  
  //RESCATAR DATOS DEL USUARIO Q ENTRO
  User auth = FirebaseAuth.instance.currentUser!;
  late String uid;

  //VARIABLES PARA EL GNAV
  int _paginaActual = 1;
  late List <Widget> paginas = [
    venderView(uid),
    const menuView(),
    const buscarView()
  ];




  @override
  Widget build(BuildContext context) {
    inputUidUser();  
    esUsuarioNuevo(uid);
    return Scaffold(
      //APPBAR
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: ()=> FirebaseAuth.instance.signOut(),
            );
          },
        ),
      /////////////////////////////////////////////// INTENTAR MODULAR EN appBar
        backgroundColor: Theme.of(context).primaryColor,
        //automaticallyImplyLeading: false,
        title: const Center(child: Text(/*uid*/ 'ExFoof')),//Text("ExFood"),
        actions: <Widget> [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: ()=>{
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  perfilPage(uid)))
            }
          )
          , 
        ],
      ),
      /////////////////////////////////////////////////
      
      //BODY
      body: paginas[_paginaActual],


      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: const Color.fromARGB(255, 173, 10, 81),
              color: Colors.white,
              tabs: const [
                GButton(
                  icon:  Icons.sell,
                  text: 'VENDER',
                ),
                GButton(
                  icon: Icons.home,
                  text: 'MENU',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'BUSCAR',
                ),
              ],
              selectedIndex: _paginaActual,
              onTabChange: (index) {
                setState(() {
                  _paginaActual = index;
                });
                print(_paginaActual);
              },
            ),
          ),
        ),
      ), 
    );
  }

  void inputUidUser() {
    uid = (auth.uid).toString();
  }

  void esUsuarioNuevo(String uid) async {

    final snapshot= await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
    
    if(!snapshot.exists){
      
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => personalRegisterPage(uid),)
      );
    }
  }

  usuarioLogeadoCompleto(String uid) async {

    final snapshot= await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
    
    if(!snapshot.exists){
      return false;
    }

    return true;
  }
}




