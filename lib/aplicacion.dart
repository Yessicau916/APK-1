import 'package:consumir_api_2/listar.dart';
import 'package:consumir_api_2/onfiguracion.dart';
import 'package:consumir_api_2/registrar.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'roles.dart';

class Aplicacion extends StatelessWidget {
  const Aplicacion({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('The Warrior Barber Shop', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 25))),
        backgroundColor: const Color.fromARGB(255, 100, 0, 0),
      ),
      body: ListView(
        children: [
          
          ListTile(
            leading: const Icon(Icons.add_shopping_cart_outlined, color:Color.fromARGB(255, 100, 0, 0),),
            title: const Text('Proveedores', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            subtitle: const Text('Lista de proveedores'),
            trailing: const Icon(Icons.arrow_drop_down_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListaProveedor()),
              );
            },
          ),

                    
            ListTile(
            leading: const Icon(Icons.category_rounded, color: Color.fromARGB(255, 100, 0, 0),),
            title: const Text('Registrar', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            subtitle: const Text('Registrar un proveedor'),
            trailing: const Icon(Icons.arrow_drop_down_sharp),
            onTap: () {
              final route = MaterialPageRoute(
                builder: (context) => const RegistrarProveedor(),
              );
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag, color: Color.fromARGB(255, 100, 0, 0),),
            title: const Text('Roles', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            subtitle: const Text('Administrador, empleados y usuarios'),
            trailing: const Icon(Icons.arrow_drop_down_sharp),
            onTap: () {
              final route = MaterialPageRoute(
                builder: (context) => const Roles(),
              );
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle_outlined, color:Color.fromARGB(255, 100, 0, 0),),
            title: const Text('Configuración',  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            subtitle: const Text('Configuración de la cuenta'),
            trailing: const Icon(Icons.arrow_drop_down_sharp),
            onTap: () {
              final route = MaterialPageRoute(
                builder: (context) =>  const Configuracion(),
              );
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.gps_fixed_sharp, color:Color.fromARGB(255, 100, 0, 0),),
            title: const Text('Salir', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            subtitle: const Text('Iniciar con otra cuenta'),
            trailing: const Icon(Icons.exit_to_app),
            onTap: () {
              final route = MaterialPageRoute(
                builder: (context) => const Login(),
              );
              Navigator.push(context, route);
            },
          )
        ],
      ),
    );
  }
}