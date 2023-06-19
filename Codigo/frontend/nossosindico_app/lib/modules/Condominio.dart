import 'dart:convert';

class Condominio{
  int id = 0;
  String chave;
  String nome;
  String cep;
  String rua;
  int numero;
  String bairro;
  String cidade;

  Condominio(this.chave, this.nome, this.cep, this.rua, this.numero, this.bairro, this.cidade);

  Condominio.fromJson(Map<String, dynamic> json)
    : id = json['id'],
        chave = json['code'],
      nome = json['nome'],
      cep = json['cep'],
      rua = json['rua'],
      numero = json['numero'],
      bairro = json['bairro'],
      cidade = json['cidade'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'chave': chave,
    'nome': nome,
    'cep': cep,
    'rua': rua,
    'numero': numero,
    'bairro': bairro,
    'cidade': cidade,
  };

  @override
  String toString() {
    Map<String, dynamic> json = toJson();
    return jsonEncode(json);
  }

  void setNull(){
    this.id = 0;
    this.chave = "a";
    this.nome = "a";
    this.cep = "a";
    this.rua = "a";
    this.numero = 0;
    this.bairro = "a";
    this.cidade = "a";
    this.id = 0;
  }
}