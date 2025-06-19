import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';
import '../widgets/creditos_dialog.dart';
import '../widgets/agregar_chiste_bottomsheet.dart';
import 'chiste_page.dart';

class MenuPrincipal extends StatelessWidget {
  final List<Map<String, dynamic>> categorias = [
    {'nombre': 'Animales', 'icono': Icons.pets},
    {'nombre': 'Tecnología', 'icono': Icons.computer},
    {'nombre': 'Escuela', 'icono': Icons.school},
    {'nombre': 'Parejas', 'icono': Icons.favorite},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HumorHub', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo.png', height: 40, width: 40),
          ),
        ],
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.100,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/paisaje.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          CircularParticle(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            particleColor: Colors.white.withAlpha(150),
            numberOfParticles: 200,
            speedOfParticles: 1.5,
            maxParticleSize: 4,
            awayRadius: 80,
            isRandSize: true,
            isRandomColor: true,
            randColorList: [Colors.white, Colors.purpleAccent],
            awayAnimationDuration: Duration(milliseconds: 600),
            enableHover: false,
            connectDots: false,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¡Chistes Sin Fin, Risas Sin Parar!',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Categorías',
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'ComicNeue',
                    color: Colors.purple.shade800,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.black26,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ...categorias.map((categoria) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 250, maxWidth: 300),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          backgroundColor: Colors.purple.shade400,
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.purple, width: 2),
                          ),
                          shadowColor: Colors.black,
                        ),
                        icon: Icon(categoria['icono'], size: 28),
                        label: Text(
                          categoria['nombre'],
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChistePage(categoria: categoria['nombre']),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
                SizedBox(height: 30),
                Text(
                  '@2025 Abril Gv/Programación6A',
                  style: TextStyle(color: Colors.purple.shade800),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 70, // ✅ Más centrado
            child: FloatingActionButton(
              heroTag: 'addJokeBtn',
              backgroundColor: Colors.purple,
              child: Icon(Icons.add, color: Colors.white), // ✅ Ícono blanco
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  builder: (context) =>
                      AgregarChisteBottomSheet(categorias: categorias),
                );
              },
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: 'creditosBtn',
              onPressed: () => mostrarCreditos(context),
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Icon(
                Icons.info_outline,
                color: Colors.purpleAccent,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
