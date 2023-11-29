import 'package:flutter/material.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        backgroundColor:const Color.fromARGB(255, 100, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Idioma y Región',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
              subtitle: const Text('Selecciona tu idioma y región preferidos'),
              trailing: const Icon(Icons.language,color: Color.fromARGB(255, 100, 0, 0),),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('Notificaciones',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
              subtitle: const Text('Habilita o deshabilita las notificaciones'),
              trailing: const Icon(Icons.notifications,color: Color.fromARGB(255, 100, 0, 0),),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('Cuenta de Usuario',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
              subtitle: const Text('Administra tu cuenta y tu información de contacto'),
              trailing: const Icon(Icons.account_circle,color: Color.fromARGB(255, 100, 0, 0),),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('Privacidad y Seguridad',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
              subtitle: const Text('Ajusta la seguridad de tu cuenta y contraseña'),
              trailing: const Icon(Icons.lock,color: Color.fromARGB(255, 100, 0, 0),),
              onTap: () {
               
              },
            ),
          ],
        ),
      ),
    );
  }
}

