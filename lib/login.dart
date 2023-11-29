// login_page.dart

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'aplicacion.dart';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  Logininicio createState() => Logininicio();
}

class Logininicio extends State<Login> {
  // Controladores para manejar la entrada de texto
  final TextEditingController correo= TextEditingController();
  final TextEditingController password = TextEditingController();
  
  // Clave global para el formulario, necesaria para validaciones
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Función llamada al presionar el botón "Iniciar Sesión"

void loginPressed(BuildContext context) async {
  if (formKey.currentState!.validate()) {
    try {
      final response = await http.post(
        Uri.parse('https://api-twbs.onrender.com/api/usuario'),
        body: {
          'correo': correo.text,
          'contrasena': password.text,
        },
      );

      if (response.statusCode == 200) {
        // Credenciales válidas, redirigir a la página "Aplicacion"
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Aplicacion()),
        );
      } else {
        // Credenciales incorrectas o error en el API, mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Correo y/o contraseña incorrectas'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // Manejar errores, como problemas de conexión o respuesta del servidor
      if (kDebugMode) {
        print('Error en la solicitud HTTP: $error');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error en la solicitud HTTP'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          color: const Color.fromARGB(100, 100, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  // Icono centrado encima del formulario
                    Container(
                      alignment: Alignment.center,
                      width:270,
                      height: 100,
                      child: Image.asset('logo-twbs-blanco.png'),
                      
                    ),


                  const SizedBox(height: 20),
                  // Campo de texto para el correo con validación
                  TextFormField(
                    controller: correo,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),iconColor: Color.fromARGB(255, 100, 0, 0),
                      labelText: 'Correo',
                      labelStyle: TextStyle(color:Color.fromARGB(255, 255, 255, 255)),
                       hintText: 'Ejemplo@gmail.com',
                      ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu correo';
                      }
                      return null;  // Retornar null indica que la validación es exitosa
                    },
                  ),
                  // Campo de texto para la contraseña con validación
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),iconColor: Color.fromARGB(255, 100, 0, 0),
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color:Color.fromARGB(255, 255, 255, 255)),
                       hintText: 'escriba aqui',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu contraseña';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Botón para iniciar sesión
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 100, 0, 0))
                    ),
                    onPressed: () => loginPressed(context),
                  
                    child: const Text('Iniciar Sesión'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
