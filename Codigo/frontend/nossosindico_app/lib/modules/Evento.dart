import 'dart:convert';

class Evento{
  int id = 000;
  String data = "00/00/0000";
  String descricao = "descricao";

  Evento(this. data, this.descricao);

  Evento.fromJson(Map<String, dynamic> json)
      :id = json['id'],
        data = json['data'].toString(),
        descricao = json['descricao'];



  Map<String, dynamic> toJson() => {
    'id': id,
    'data': data,
    'descricao': descricao,
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
    descricao = "Cringe";
    data = "01/12/1989";
    id = 0;
  }
}