import 'dart:convert';

import 'package:nossosindico_app/modules/Condominio.dart';

class Aviso {
  int id;
  String titulo;
  String descricao;
  Condominio condominio;

  Aviso(this.id, this.titulo, this.descricao, this.condominio);

  Aviso.fromJson(Map<String, dynamic> json)
  :id = json['id'],
  titulo = json['titulo'],
  descricao = json['conteudo'],
  condominio = Condominio.fromJson(json['condominio']);

  @override
  String toString() {
    Map<String, dynamic> json = toJson();
    return jsonEncode(json);
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'titulo' : titulo,
    'descricao' : descricao,
    'condominio_id': condominio,
  };
}