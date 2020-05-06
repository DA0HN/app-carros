import 'package:example/utils/database/entity.dart';

class Favorito extends Entity {
  int id;
  String nome;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }

  Favorito({
    this.id,
    this.nome,
  });

  Favorito.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }
}
