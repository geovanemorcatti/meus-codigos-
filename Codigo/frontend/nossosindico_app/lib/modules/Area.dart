import 'dart:convert';

class Area{
  int id = 0;
  int idCondominio = 0;
  int capacidade = 0;
  String descricao = "Salão com 5 mesas e 20 cadeiras";
  String nome = "Salão de Festas";

  Area(this.idCondominio, this.nome, this.descricao, this.capacidade);

  Area.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idCondominio = json['id_condominio'],
        descricao = json['descricao'],
        capacidade = json['capacidadeMax'],
        nome = json['nome'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'idCondominio': idCondominio,
    "descricao": descricao,
    'capacidade': capacidade,
    "nome": nome
  };

  void setId(int id){
    this.id = id;
  }

  @override
  String toString(){
    Map<String, dynamic> json = toJson();
    return jsonEncode(json);
  }
}
