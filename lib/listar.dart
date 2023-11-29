// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:consumir_api_2/aplicacion.dart';
import 'package:consumir_api_2/editar.dart';
import 'package:consumir_api_2/eliminar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListaProveedor extends StatefulWidget {
  const ListaProveedor({Key? key}) : super(key: key);

  @override
  State<ListaProveedor> createState() => _ListaProveedorState();
}

class _ListaProveedorState extends State<ListaProveedor> {
  List<dynamic> data = [];
  // List<dynamic> prueba = [];
  List<dynamic> filteredData = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsuarios();
  }

  Future<void> getUsuarios() async {
    const Center(child: CircularProgressIndicator());
    final response =
        await http.get(Uri.parse('https://api-twbs.onrender.com/api/proveedor'));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);

      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Listando Proveedores...')),
        );
        data = decodedData['proveedores'] ?? [];
        filteredData
            .addAll(data); // Inicializar la lista filtrada con todos los datos
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al listar los Proveedores...')),
        );
      });
    }
  }

  void _filterList(String searchText) {
    setState(() {
      filteredData = data
          .where((user) =>
              user['nombreProveedor']
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              user['nombreContacto'].toLowerCase().contains(searchText.toLowerCase()) ||
              user['correo'].toLowerCase().contains(searchText.toLowerCase()) ||
              user['celular'].toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  var selUser = "";

  void editar() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Editar(selUser)));
  }

  void eliminar() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Eliminar(selUser)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Aplicacion()));
          },
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            child: Image.asset(
              'assets/logo-twbs-blanco.png', // Reemplaza con la URL de tu imagen
              fit: BoxFit.cover, // Ajusta la imagen al tamaño del Card
              width: 150,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 100, 0, 0),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _filterList(value);
              },
              decoration: const InputDecoration(
                labelText: 'Buscar...',
                labelStyle: TextStyle(color: Color.fromARGB(149, 255, 255, 255)),
                floatingLabelStyle:
                    TextStyle(color: Color.fromARGB(255, 100, 0, 0)),
                prefixIcon:
                    Icon(Icons.search, color: Color.fromARGB(255, 100, 0, 0)),
                // border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(3)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(98, 255, 255, 255), width: 1)),
                focusedBorder: UnderlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(3)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 100, 0, 0))),
                // fillColor: Color.fromARGB(255, 255, 200, 200),
                // filled: true,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Card(
                    elevation: 10,
                    color: const Color.fromARGB(255, 255, 200, 200),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10, bottom: 5),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.person_add_alt_1,
                                  color: Color.fromARGB(255, 100, 0, 0),
                                ),
                              ),
                              Text('Proveedor: ' +
                                  filteredData[index]['nombreProveedor']),
                            ],
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.person_2_rounded,
                                  color: Color.fromARGB(255, 100, 0, 0),
                                ),
                              ),
                              Text('Nombre de contacto:  ' + filteredData[index]['nombreContacto']),
                            ],
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.mail,
                                  color: Color.fromARGB(255, 100, 0, 0),
                                ),
                              ),
                              Text('Correo:  ' + filteredData[index]['correo']),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.phone_android,
                                  color: Color.fromARGB(255, 100, 0, 0),
                                ),
                              ),
                              Text('Celular:  ' +
                                  filteredData[index]['celular']),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          selUser =
                                              filteredData[index]['nombreProveedor'];
                                          editar();
                                        },
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                            Color.fromARGB(255, 100, 0, 0),
                                          ),
                                        ),
                                        child: const Text('Modificar'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          selUser =
                                              filteredData[index]['nombreProveedor'];
                                          eliminar();
                                        },
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                            Color.fromARGB(255, 100, 0, 0),
                                          ),
                                        ),
                                        child: const Text('Eliminar'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // GridView.count(crossAxisCount: 2),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}