//..lib/widgets/creditos_dialog.dart
import 'package:flutter/material.dart';

void mostrarCreditos(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.grey.shade900,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo centrado arriba
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Texto principal centrado y con FittedBox para escalar
                  Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'HumorHub',
                        style: TextStyle(
                          fontSize:
                              40, // más grande para que FittedBox reduzca si hace falta
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Versión 1.0.0',
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  // Resto de textos centrados
                  Text(
                    'PROGRAMACIÓN',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 20,
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '2022 - 2025',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Generación',
                    style: TextStyle(
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    'Jennifer Abril Gonzalez Victoria',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Desarrollador',
                    style: TextStyle(
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    'Desarrolla Aplicaciones Móviles Para IOS',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Submódulo',
                    style: TextStyle(
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    'Alberto Hugo Parraguirre Covarrubias',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Profesor',
                    style: TextStyle(color: Colors.purpleAccent, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cerrar',
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => showLicensePage(context: context),
                        child: Text(
                          'Ver licencias',
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
