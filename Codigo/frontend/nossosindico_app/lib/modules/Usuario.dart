import 'dart:convert';

class Usuario{
  String nome = "Nome";
  String sobrenome = "Sobrenome";
  String email = "usuario@mail.com";
  String senha = "senha";
  int id = 0;
  bool sindico = false;

  Usuario(this.nome, this.sobrenome, this.email, this.senha);

  Usuario.fromJson(Map<String, dynamic> json)
    :id = json['id'],
        nome = json['nome'],
      sobrenome = json['sobrenome'],
      email = json['email'],
      senha = json['senha'];



  Map<String, dynamic> toJson() => {
    'nome': nome,
    'sobrenome': sobrenome,
    'email': email,
    'senha': senha,
  };

  void setId(int id) {
    this.id = id;
  }

  @override
  String toString() {
    Map<String, dynamic> json = toJson();
    return jsonEncode(json);
  }

  void setSindico(bool ehOuNumEH) {
    this.sindico = ehOuNumEH;
  }

  void setNull(){
    this.nome = "Cringe";
    this.sobrenome = "Poggers";
    this.email = "Lacrou";
    this.senha = "Nelson";
    this.id = 0;
  }
}