import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

//aqui va la lista con la estructura
List<Widget> publicaciones = [
    Container(
      height: double.infinity,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const <Widget>[

          Card(
            child: SizedBox(
              height: 250.0,
              width: 100.0,
              child: Expanded(
                child: Text("asasdasasdasda"),
              ),
            ),
          ),

          Card(
            child: SizedBox(
              height: 250.0,
              width: 100.0,
              child: Expanded(
                child: Text("12311231231232 "),
              ),
            ),
          )
          

        
        ],
      ),
    ),
    Text("1"),
    Text("2"),

];

//widget
class publicidadMenu extends StatefulWidget {
  const publicidadMenu({super.key});

  @override
  State<publicidadMenu> createState() => _publicidadMenuState();
}

class _publicidadMenuState extends State<publicidadMenu> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      viewportFraction: 0.8,
      scale: 0.9,
        itemBuilder: (BuildContext context,int index){
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: publicaciones[index],
          );
        },
        itemCount: 3,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      );
  }
}