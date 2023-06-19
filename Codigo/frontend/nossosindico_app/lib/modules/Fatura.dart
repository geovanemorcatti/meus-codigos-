import 'dart:convert';

import 'Condominio.dart';

class Fatura{
  int id = 000;
  DateTime data = DateTime.now();
  String nome = "Nome";
  String descricao = "descricao";
  double valor = 0.00;
  Condominio condominio;

  Fatura(this. data, this.nome, this.valor, this.condominio);

  Fatura.fromJson(Map<String, dynamic> json)
      :id = json['id'],
        data = DateTime.parse(json['data_referente']),
        nome = json['titulo'],
        valor = json['valor'],
        descricao = json['descricao'],
        condominio = Condominio.fromJson(json["condominio"]);



  Map<String, dynamic> toJson() => {
    'id': id,
    'data': data,
    'nome': nome,
    'valor': valor,
  };

  void setId(int id) {
    this.id = id;
  }

  @override
  String toString() {
    Map<String, dynamic> json = toJson();
    return jsonEncode(json);
  }

  void setNull(){
    nome = "Cringe";
    data = DateTime(0);
    valor = 1.00;
    id = 0;
  }
}