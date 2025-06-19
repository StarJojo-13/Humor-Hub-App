//..lib/screens/chiste_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:particles_flutter/particles_flutter.dart';
import '../data/db_helper.dart';
import '../models/chiste_model.dart';
import '../data/chistes_defecto.dart';

class ChistePage extends StatefulWidget {
  final String categoria;

  const ChistePage({Key? key, required this.categoria}) : super(key: key);

  @override
  _ChistePageState createState() => _ChistePageState();
}

class _ChistePageState extends State<ChistePage> {
  List<Chiste> chistesDisponibles = [];
  List<Chiste> chistesMostrados = [];
  String chisteActual = '';
  String origenChiste = '';
  String gifActual = 'assets/gifts/1.gif';
  late AudioPlayer audioPlayer;
  final List<String> gifs = List.generate(
    25,
    (index) => 'assets/gifts/${index + 1}.gif',
  );

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    cargarChistes();
  }

  Future<void> cargarChistes() async {
    List<Chiste> chistes = await DBHelper().obtenerChistesPorCategoria(
      widget.categoria,
    );

    if (chistes.isEmpty) {
      final chistesDefectoList = chistesPorDefecto[widget.categoria] ?? [];
      for (var texto in chistesDefectoList) {
        await DBHelper().insertarChiste(
          Chiste(texto: texto, categoria: widget.categoria),
        );
      }
      chistes = await DBHelper().obtenerChistesPorCategoria(widget.categoria);
    }

    setState(() {
      chistesDisponibles = List.from(chistes)..shuffle();
      chistesMostrados.clear();
    });

    generarChiste();
  }

  Future<void> generarChiste() async {
    if (chistesDisponibles.isEmpty) {
      setState(() {
        chisteActual =
            '¡Oh no! Ya viste todos los chistes de esta categoría :c\n Ayudanos a mejorar,\n comparte tus chistes y continua divirtiendote';
        origenChiste = '';
        gifActual = gifs[Random().nextInt(gifs.length)];
      });
      return;
    }

    final chiste = chistesDisponibles.removeAt(0);
    chistesMostrados.add(chiste);

    final esPorDefecto = (chistesPorDefecto[widget.categoria] ?? []).contains(
      chiste.texto,
    );

    setState(() {
      chisteActual = chiste.texto;
      origenChiste = esPorDefecto
          ? '(chiste por defecto)'
          : '(chiste agregado)';
      gifActual = gifs[Random().nextInt(gifs.length)];
    });

    await audioPlayer.play(AssetSource('sounds/sonido_chiste.mp3'));
  }

  void reiniciarChistes() {
    setState(() {
      chistesDisponibles = List.from(chistesDisponibles + chistesMostrados)
        ..shuffle();
      chistesMostrados.clear();
      chisteActual =
          '¡Chistes reiniciados! Presiona el botón de refresh para comenzar.';
      origenChiste = '';
      gifActual = gifs[Random().nextInt(gifs.length)];
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categoría: ${widget.categoria}'),
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.45, // Fondo más visible
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
            numberOfParticles: 150,
            speedOfParticles: 1.5,
            maxParticleSize: 5,
            awayRadius: 60,
            isRandSize: true,
            isRandomColor: true,
            randColorList: [Colors.white, Colors.purpleAccent],
            awayAnimationDuration: Duration(milliseconds: 600),
            enableHover: false,
            connectDots: false,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purple, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          chisteActual,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        if (origenChiste.isNotEmpty) ...[
                          SizedBox(height: 10),
                          Text(
                            origenChiste,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(gifActual, height: 200, fit: BoxFit.contain),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.purple,
                          elevation: 6,
                        ),
                        child: Icon(Icons.home, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.purple,
                          elevation: 6,
                        ),
                        child: Icon(Icons.refresh, color: Colors.white),
                        onPressed: generarChiste,
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.purple,
                          elevation: 6,
                        ),
                        child: Icon(Icons.restart_alt, color: Colors.white),
                        onPressed: reiniciarChistes,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
