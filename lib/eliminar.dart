// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'package:consumir_api_2/listar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Eliminar extends StatefulWidget {
  final String texto;
  const Eliminar(
    this.texto, {
    super.key,
  });

  @override
  State<Eliminar> createState() => _EditarState();
}

class _EditarState extends State<Eliminar> {
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  final _formKey = GlobalKey<FormState>();
  var nombreProveedor= "";
  TextEditingController id = TextEditingController();

  @override
  void initState() {
    super.initState();
    nombreProveedor = widget.texto;
    getProveedor();
  }

  Future<void> getProveedor() async {
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
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al cargar los datos...')),
        );
      });
    }
    for (var i = 0; i < data.length; i++) {
      if (data[i]['nombreProveedor'] == nombreProveedor) {
        id.text = data[i]['_id'];
        break;
      }
    }
  }

  Future<void> _eliminarUsuario(String usu) async {
    if (_formKey.currentState?.validate() ?? false) {
      final Map<String, dynamic> data = {'_id': id.text};
      final response = await http.delete(
        Uri.parse('https://api-twbs.onrender.com/api/proveedor'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Eliminando Proveedor...')),
        );
        await Future.delayed(const Duration(seconds: 1));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ListaProveedor()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Error al eliminar el proveedor.. Código de error: ${response.statusCode}...')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 10,
              color: const Color.fromARGB(255, 255, 200, 200),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        '¿Seguro que desea eliminar el proveedor "$nombreProveedor"?',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _eliminarUsuario(nombreProveedor);
                                    },
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromARGB(
                                                    255, 100, 0, 0))),
                                    child: const Text('Eliminar proveedor'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
