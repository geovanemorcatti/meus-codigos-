import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/modules/FieldValidator.dart';
import 'package:http/http.dart' as http;
import 'package:nossosindico_app/screens/Layout.dart';
import 'package:nossosindico_app/screens/Login.dart';
import 'package:intl/intl.dart';
import '../modules/MenuPage.dart';
import '../screens/Layout.dart';
import '../screens/Login.dart';
import 'Invoice.dart';

class InvoiceRegister extends StatefulWidget {
  const InvoiceRegister();
  @override
  State<InvoiceRegister> createState() => _InvoiceRegisterState();
}

class _InvoiceRegisterState extends State<InvoiceRegister> {
  final _formKey = GlobalKey<FormState>();

  final format = DateFormat("yyyy-MM-dd");

  final TextEditingController _controladorNome = TextEditingController(),
      _controladorData = TextEditingController(),
      _controladorValor = TextEditingController(),
      _controladorDescricao = TextEditingController();

  onPressed(String titulo, String descricao, String valor, String data) async {
    var response;
    var Url = 'http://localhost:8080/cadDespessa';
    response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "id_condominio": condominio.id.toString(), "titulo": titulo, "descricao": descricao, "valor": valor, "data_referente": data
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _goToInvoice();
    }
  }

  void _goToInvoice() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
            title: "Quadro de Avisos",
            body: Invoice(),
            menuPage: MenuPage.Invoice,
            register: true,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          width: SizeConfig.safeBlockHorizontal! * 85 < SizeConfig.screenWidth!
              ? SizeConfig.safeBlockHorizontal! * 85
              : SizeConfig.screenWidth!,
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(children: <Widget>[
                    Text('Insira a data (${format.pattern})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    DateTimeField(
                      controller: _controladorData,
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ])
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: _controladorNome,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'Nome',
                      hintText: 'Nome do Item',
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                  keyboardType: TextInputType.name,
                  validator: FieldValidator.ValidarSenha,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: _controladorDescricao,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'Descrição',
                      hintText: 'Descrição da Despesa',
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                  keyboardType: TextInputType.name,
                  validator: FieldValidator.ValidarSenha,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: _controladorValor,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'Valor',
                      hintText: 'usuario@mail.com',
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                  keyboardType: TextInputType.number,
                  validator: FieldValidator.ValidarSenha,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: ElevatedButton(
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'Sign-up',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onPressed: () => { onPressed(_controladorNome.text, _controladorDescricao.text, _controladorValor.text, _controladorData.text) },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}