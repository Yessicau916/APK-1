import 'package:flutter/material.dart';

// Widget principal para la pantalla de Roles
class Roles extends StatelessWidget {
  const Roles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 25)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tarjeta de Rol para el Administrador
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Administrador',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text('Rol con privilegios de administración.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),  // Separación entre tarjetas
            // Tarjeta de Rol para el Barbero
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Barbero',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text('Rol para los barberos de la empresa.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),  // Separación entre tarjetas
            // Tarjeta de Rol para el Usuario
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Usuario',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text('Rol para los usuarios generales.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
