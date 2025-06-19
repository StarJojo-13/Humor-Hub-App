//..lib/screens/chiste_widget.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ChisteWidget extends StatefulWidget {
  final List<String> chistes;
  final Color colorPrimario;

  const ChisteWidget({
    Key? key,
    required this.chistes,
    this.colorPrimario = Colors.purple,
  }) : super(key: key);

  @override
  _ChisteWidgetState createState() => _ChisteWidgetState();
}

class _ChisteWidgetState extends State<ChisteWidget> {
  late List<String> chistesDisponibles;
  late List<String> chistesMostrados;
  String chisteActual = '';
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    chistesDisponibles = List.from(widget.chistes)..shuffle();
    chistesMostrados = [];
    audioPlayer = AudioPlayer();
    generarChiste();
  }

  void generarChiste() async {
    if (chistesDisponibles.isEmpty) {
      chistesDisponibles = List.from(widget.chistes)..shuffle();
      chistesMostrados.clear();
    }

    setState(() {
      chisteActual = chistesDisponibles.removeAt(0);
      chistesMostrados.add(chisteActual);
    });

    await audioPlayer.play(AssetSource('sounds/sonido_chiste.mp3'));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
            border: Border.all(color: widget.colorPrimario, width: 2),
          ),
          padding: EdgeInsets.all(20),
          child: Text(
            chisteActual,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: widget.colorPrimario,
            ),
          ),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(24),
            backgroundColor: widget.colorPrimario,
            elevation: 6,
          ),
          child: Icon(Icons.refresh, color: Colors.white),
          onPressed: generarChiste,
        ),
      ],
    );
  }
}
