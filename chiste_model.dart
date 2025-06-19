//..lib/model/chiste_model.dart
class Chiste {
  final int? id;
  final String texto;
  final String categoria;

  Chiste({this.id, required this.texto, required this.categoria});

  factory Chiste.fromMap(Map<String, dynamic> map) {
    return Chiste(
      id: map['id'],
      texto: map['texto'],
      categoria: map['categoria'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'texto': texto,
      'categoria': categoria,
    };
  }
}
