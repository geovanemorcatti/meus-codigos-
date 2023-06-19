import 'dart:convert';

class Reserva{
  int id = 0;
  int idArea = 0;
  int idUsuario = 1;
  String data = "00/00/0000";

  Reserva(this.idArea, this.idUsuario, this.data);

  Reserva.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idArea = json['idArea'],
        idUsuario = json['idUsuario'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'idArea': idArea,
    'idUsuario': idUsuario,
    "data": data
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
