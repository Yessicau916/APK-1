// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'package:consumir_api_2/aplicacion.dart';
import 'package:consumir_api_2/listar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrarProveedor extends StatefulWidget {
  const RegistrarProveedor({super.key});

  @override
  _RegistrarProveedor createState() => _RegistrarProveedor();
}

class _RegistrarProveedor extends State<RegistrarProveedor> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nombreProveedor = TextEditingController();
  TextEditingController nombreContacto = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController celular = TextEditingController();

  RegExp valEmail = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$');
  RegExp valCelular = RegExp(r'^\d{10}$');

  Future<void> _insertarProveedor() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (nombreProveedor.text.length < 5 ||
          nombreProveedor.text.length > 20 && nombreContacto.text.length < 3 ||
          nombreContacto.text.length > 25 && correo.text.length < 12 ||
          correo.text.length > 40 && celular.text.length < 12) {
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
      } else if (nombreProveedor.text.length < 5 ||
          nombreProveedor.text.length > 20) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error con el nombre de proveedor.'),
              content: const Text('Revise el nombre de proveedor ingresado.'),
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
      } else if (nombreContacto.text.length < 3 ||
          nombreContacto.text.length > 25) {
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
        final url = Uri.parse('https://api-twbs.onrender.com/api/proveedor');

        // Datos que quieres enviar al servidor
        final Map<String, dynamic> data = {
          'nombreProveedor': nombreProveedor.text,
          'nombreContacto': nombreContacto.text,
          'correo': correo.text,
          'celular': celular.text,
        };

        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Proveedor registrado...')),
          );
          await Future.delayed(const Duration(seconds: 1));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ListaProveedor()));
          nombreProveedor.clear();
          nombreContacto.clear();
          correo.clear();
          celular.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Error al registrar el Proveedor. Código de error: ${response.statusCode}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Aplicacion()));
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: TextFormField(
                        controller: nombreProveedor,
                        keyboardType: TextInputType.text,
                        maxLength: 20,
                        decoration: InputDecoration(
                          labelText: 'Nombre de Proveedor',
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 100, 0, 0))),
                          floatingLabelStyle: const TextStyle(
                              color: Color.fromARGB(255, 100, 0, 0)),
                          icon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 100, 0, 0),
                          ),
                          helperText:
                              'El nombre de proveedor debe ser entre 5 y 20 caracteres.',
                          counterText: '${nombreProveedor.text.length}/20',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese un proveedor!';
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
                        controller: nombreContacto,
                        keyboardType: TextInputType.name,
                        maxLength: 25,
                        decoration: InputDecoration(
                          labelText: 'nombre',
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 100, 0, 0))),
                          floatingLabelStyle: const TextStyle(
                              color: Color.fromARGB(255, 100, 0, 0)),
                          icon: const Icon(
                            Icons.photo_camera_front_rounded,
                            color: Color.fromARGB(255, 100, 0, 0),
                          ),
                          helperText:
                              'El nombre de debe ser entre 3 y 25 caracteres.',
                          counterText: '${nombreContacto.text.length}/25',
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
                      child: ElevatedButton(
                        onPressed: _insertarProveedor,
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 100, 0, 0))),
                        child: const Text('Registrar proveedor'),
                      ),
                    ),
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
