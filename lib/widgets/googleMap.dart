import 'dart:async';

import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapHelper {
  static double latitud = 0.0;
  static double longitud = 0.0;
  static final Completer<GoogleMapController> _controller = Completer();

  static CameraPosition direccionNueva =  const CameraPosition(
    target: LatLng(0, 0),
    zoom: 0,
  );

  static const CameraPosition poscionIncial = CameraPosition(
    target: LatLng(-33.04444479999999, -71.6058406),
    zoom: 14.4746,
  ); 

  static final geoMethods = GeoMethods(
    googleApiKey: 'AIzaSyBrVQpgmU6lo_zsSPoy5xxiSe90e2xy7Kw',
    language: 'es',
    countryCode: 'CL',
    country: 'Chile',
    city: 'Valaparaíso',
  );

  static Future<void> _goToTheLake(CameraPosition direccion) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(direccion));
  }

  static buscarDireccion(BuildContext context, TextEditingController direccion, var latitud, var longitud) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddressSearchDialog(
        geoMethods: geoMethods,
        controller: direccion,
        onDone: (Address address) {
          latitud = address.coords!.latitude;
          longitud = address.coords!.longitude;
        }
      ), 
    );
  }

  static panelGoogleMap(BuildContext context, TextEditingController direccionController) {
    double latitud = 0.0;
    double longitud = 0.0;
    showDialog(
      context: context, 
      builder: ((context) {
        return Padding(
          padding: const EdgeInsets.all(40.0),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: direccionController,
                              decoration: const InputDecoration(
                                labelText: "Direccion",
                              ),
                              onTap: () async { 
                                buscarDireccion(context, direccionController, latitud, longitud); 
                                direccionNueva = CameraPosition(
                                  target: LatLng(latitud, longitud),
                                  zoom: 17,
                                );
                              }
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final GoogleMapController controller = await _controller.future;
                            controller.animateCamera(CameraUpdate.newCameraPosition(direccionNueva));
                            print('-----------------------------------------------------------------------------------------------------');
                          }, 
                          child: Text("buscar")
                        )
                      ],
                    ),
                    Expanded(
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: poscionIncial,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        );
      })
    );
  }
}