// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:consumir_api_2/listar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Editar extends StatefulWidget {
  final String texto;
  const Editar(
    this.texto, {
    super.key,
  });

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreProveedor = TextEditingController();
  TextEditingController nombreContacto = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController celular = TextEditingController();


  RegExp valEmail = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$');
  RegExp valCelular = RegExp(r'^\d{10}$');

  bool valIngreso = false;

  @override
  void initState() {
    super.initState();
    nombreProveedor.text = widget.texto;
    getUsuarios();
  }

  Future<void> getUsuarios() async {
    const Center(child: CircularProgressIndicator());
    final response =
        await http.get(Uri.parse('https://api-twbs.onrender.com/api/proveedor'));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);
      setState(() {
        data = decodedData['proveedores'] ?? [];
        filteredData.addAll(data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('cargando datos...')),
        );
      });

      for (var i = 0; i < data.length; i++) {
        if (data[i]['nombreProveedor'] == nombreProveedor.text) {
          nombreContacto.text = data[i]['nombreContacto'];
          correo.text = data[i]['correo'];
          celular.text = data[i]['celular'];
        }
      }
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al cargar los datos...')),
        );
      });
    }
  }

  Future<void> _modificarUsuario(String nom, String ema,
      String cel ) async {
    if (_formKey.currentState?.validate() ?? false) {
      if (nombreProveedor.text.length < 5 ||
          nombreProveedor.text.length > 20 && nombreContacto.text.length < 3 ||
          nombreContacto.text.length > 25 &&  correo.text.length < 12 ||
          correo.text.length > 40 && celular.text.length < 12 ||
          celular.text.length > 40) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error con los datos ingresado.'),
              content: const Text('Revise los datos ingresado.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Cerrar el mensaje emergente al hacer clic en el botón
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else if (nombreProveedor.text.length < 5 || nombreProveedor.text.length > 20) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error con el nombre de Proveedor.'),
              content: const Text('Revise el nombre de Proveedor ingresado.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Cerrar el mensaje emergente al hacer clic en el botón
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else if (nombreContacto.text.length < 3 || nombreContacto.text.length > 25) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error con el nombre.'),
              content: const Text('Revise el nombre ingresado.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Cerrar el mensaje emergente al hacer clic en el botón
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      
      } else if (correo.text.length < 12 ||
          correo.text.length > 40 ||
          !valEmail.hasMatch(correo.text)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error con el correo.'),
              content: const Text('Revise el correo ingresado.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Cerrar el mensaje emergente al hacer clic en el botón
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else if (celular.text.length != 10 ||
          !valCelular.hasMatch(celular.text)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error con el celular.'),
              content: const Text('Revise el celular ingresado.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Cerrar el mensaje emergente al hacer clic en el botón
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      
      } else {
        final Map<String, dynamic> data = {
          'nombreProveedor': nombreProveedor.text,
          'nombreContacto': nom,
          'correo': ema,
          'celular': cel,
        };

        final response = await http.put(
          Uri.parse('https://api-twbs.onrender.com/api/proveedor'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Proveedor modificado...')),
          );
          // const CircularProgressIndicator();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ListaProveedor()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al modificar el usuario...')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 5,
            color: const Color.fromARGB(255, 255, 200, 200),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nombreProveedor,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: 'Nombre de Proveedor',
                        border: InputBorder.none,
                        floatingLabelStyle: const TextStyle(
                            color: Color.fromARGB(255, 100, 0, 0)),
                        icon: const Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 100, 0, 0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          value = widget.texto;
                          return 'Ingrese un proveedor!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    
                    TextFormField(
                      controller: nombreContacto,
                      keyboardType: TextInputType.name,
                      readOnly: true,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: 'nombre',
                        border: InputBorder.none,
                        floatingLabelStyle: const TextStyle(
                            color: Color.fromARGB(255, 100, 0, 0)),
                        icon: const Icon(
                          Icons.photo_camera_front_rounded,
                          color: Color.fromARGB(255, 100, 0, 0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese un nombre!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: correo,
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 40,
                        decoration: InputDecoration(
                          labelText: 'correo',
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 100, 0, 0))),
                          floatingLabelStyle: const TextStyle(
                              color: Color.fromARGB(255, 100, 0, 0)),
                          icon: const Icon(
                            Icons.mail,
                            color: Color.fromARGB(255, 100, 0, 0),
                          ),
                          helperText:
                              'El correo debe ser entre 12 y 40 caracteres.',
                          counterText: '${correo.text.length}/40',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese un correo!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: celular,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: 'Celular',
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 100, 0, 0))),
                          floatingLabelStyle: const TextStyle(
                              color: Color.fromARGB(255, 100, 0, 0)),
                          icon: const Icon(
                            Icons.phone_android,
                            color: Color.fromARGB(255, 100, 0, 0),
                          ),
                          helperText:
                              'El número de celular debe ser de 10 números.',
                          counterText: '${celular.text.length}/10',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su número de celular!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
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
                                        _modificarUsuario(
                                            nombreContacto.text,
                                            correo.text,
                                            celular.text);
                                      },
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 100, 0, 0))),
                                      child: const Text('Modificar usuario'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ListaProveedor()));
                                      },
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 100, 0, 0))),
                                      child: const Text('Volver'),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
