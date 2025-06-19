//..lib/widgets/agregar_chiste_bottomsheet.dart
import 'package:flutter/material.dart';
import '../data/db_helper.dart';
import '../models/chiste_model.dart'; // <- este era necesario

class AgregarChisteBottomSheet extends StatefulWidget {
  final List<Map<String, dynamic>> categorias;

  const AgregarChisteBottomSheet({required this.categorias});

  @override
  _AgregarChisteBottomSheetState createState() => _AgregarChisteBottomSheetState();
}

class _AgregarChisteBottomSheetState extends State<AgregarChisteBottomSheet> {
  String? categoriaSeleccionada;
  final TextEditingController chisteController = TextEditingController();

  @override
  void dispose() {
    chisteController.dispose();
    super.dispose();
  }

  void guardarChiste() async {
    if (categoriaSeleccionada != null && chisteController.text.trim().isNotEmpty) {
      final nuevoChiste = Chiste(
        texto: chisteController.text.trim(),
        categoria: categoriaSeleccionada!,
      );

      await DBHelper().insertarChiste(nuevoChiste);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Chiste guardado exitosamente."),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Completa todos los campos."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Agregar Chiste", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: categoriaSeleccionada,
              decoration: InputDecoration(
                labelText: "Selecciona una categoría",
                border: OutlineInputBorder(),
              ),
              items: widget.categorias.map((categoria) {
                return DropdownMenuItem<String>(
                  value: categoria['nombre'],
                  child: Text(categoria['nombre']),
                );
              }).toList(),
              onChanged: (value) => setState(() => categoriaSeleccionada = value),
            ),
            SizedBox(height: 10),
            TextField(
              controller: chisteController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Escribe tu chiste",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text("Guardar"),
              onPressed: guardarChiste,
            ),
          ],
        ),
      ),
    );
  }
}
