
import 'package:flutter/material.dart';
import 'package:market_place/widgets/publicidadMenu.dart';

class menuView extends StatefulWidget {
  const menuView({super.key});

  @override
  State<menuView> createState() => _menuViewState();
}

class _menuViewState extends State<menuView> {
  
  

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          const SizedBox(height: 10.0),
          Container(
            /*decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),*/
            width: double.infinity,
            height: 250.0,
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: const publicidadMenu(),
          ),



          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: const Text("CATEGORIA 1")
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              
              height: 140,
              child: ListView(
                scrollDirection:  Axis.horizontal,
                children: const [
                  
                  /////////////////////////////////////////////////MODULAR
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://static-sevilla.abc.es/media/gurmesevilla/2012/01/comida-rapida-casera.jpg")
                      )
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://s1.1zoom.me/b4857/620/Fast_food_Hamburger_Vegetables_Fire_Two_520128_1920x1080.jpg")
                      )
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://static-sevilla.abc.es/media/gurmesevilla/2012/01/comida-rapida-casera.jpg")
                      )
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://s1.1zoom.me/b5154/509/Fast_food_Sandwich_Vegetables_Wood_planks_536986_1920x1080.jpg")
                      )
                    ),
                  ),
                  /////////////////////////////////////////////////////MODULAR

                ],
              ),
            ),
          ),


          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: const Text("CATEGORIA 2")
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              
              height: 140,
              child: ListView(
                scrollDirection:  Axis.horizontal,
                children: const [
                  
                  /////////////////////////////////////////////////MODULAR
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://static-sevilla.abc.es/media/gurmesevilla/2012/01/comida-rapida-casera.jpg")
                      )
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://static-sevilla.abc.es/media/gurmesevilla/2012/01/comida-rapida-casera.jpg")
                      )
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://static-sevilla.abc.es/media/gurmesevilla/2012/01/comida-rapida-casera.jpg")
                      )
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://static-sevilla.abc.es/media/gurmesevilla/2012/01/comida-rapida-casera.jpg")
                      )
                    ),
                  ),
                  /////////////////////////////////////////////////////MODULAR

                ],
              ),
            ),
          ),




          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: const Text("CATEGORIA 3")
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              
              height: 140,
              child: ListView(
                scrollDirection:  Axis.horizontal,
                children: const [
                  
                  /////////////////////////////////////////////////MODULAR
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://static-sevilla.abc.es/media/gurmesevilla/2012/01/comida-rapida-casera.jpg")
                      )
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://static-sevilla.abc.es/media/gurmesevilla/2012/01/comida-rapida-casera.jpg")
                      )
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://static-sevilla.abc.es/media/gurmesevilla/2012/01/comida-rapida-casera.jpg")
                      )
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: SizedBox(
                      height:150.0,
                      width: 200.0,
                      child: Image(
                        image: NetworkImage("https://static-sevilla.abc.es/media/gurmesevilla/2012/01/comida-rapida-casera.jpg")
                      )
                    ),
                  ),
                  /////////////////////////////////////////////////////MODULAR

                ],
              ),
            ),
          )

        ]
    );
  }
}