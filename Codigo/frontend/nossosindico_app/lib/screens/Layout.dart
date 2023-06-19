import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nossosindico_app/modules/MenuPage.dart';
import 'package:nossosindico_app/screens/CadastroCondominio.dart';
import 'package:nossosindico_app/components/UserAccount.dart';
import 'package:nossosindico_app/components/Backboard.dart';
import 'package:nossosindico_app/components/BackboardRegister.dart';
import 'package:nossosindico_app/components/Invoice.dart';
import 'package:nossosindico_app/components/InvoiceRegister.dart';
import 'package:nossosindico_app/components/Message.dart';
import 'package:nossosindico_app/components/Reservation.dart';
import 'package:nossosindico_app/components/Schedule.dart';
import 'package:nossosindico_app/components/ScheduleRegister.dart';
import 'package:http/http.dart' as http;

import '../components/SharedArea.dart';
import '../components/SharedAreaRegister.dart';
import 'Login.dart';

class Layout extends StatefulWidget {
  const Layout(
      {Key? key,
        required this.body,
        this.title = "",
        this.register = false,
        this.menuIcon = true,
        this.accontIcon = true,
        this.menuPage = MenuPage.None})
      : super(key: key);
  final Widget body;
  final String title;
  final bool register;
  final bool menuIcon;
  final bool accontIcon;
  final MenuPage menuPage;
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  bool? register;
  bool? accontIcon;
  bool? menuIcon;
  MenuPage? menuPage;

  Color activeIcon(MenuPage activeMenuPage) {
    if (activeMenuPage == menuPage) {
      return Colors.green;
    }
    return Colors.black;
  }

  List<Widget> accont() {
    if (accontIcon!) {
      return [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Layout(
                    title: "Perfil",
                    body: UserAccount(),
                    accontIcon: false,
                    menuIcon: false,
                  )),
            );
          },
          icon: const Icon(Icons.account_circle),
          iconSize: 30,
        )
      ];
    }
    return [];
  }

  Widget floatingAction() {
    if (menuPage != MenuPage.None) {
      if (menuPage == MenuPage.Condominium) {
        return FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Layout(
                      title: "Cadastro de Condomínio",
                      body: CadastroCondominio(),
                      menuIcon: false,
                      accontIcon: false,
                    )),
              );
            },
            tooltip: 'Novo Elemento',
            child: const Icon(Icons.add));
      } else if (usuario.sindico && menuPage != MenuPage.Message) {
        return FloatingActionButton(
            onPressed: () {
              if (menuPage == MenuPage.Invoice) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Layout(
                        title: "Cadastro de Fatura",
                        body: InvoiceRegister(),
                        menuIcon: false,
                        accontIcon: false,
                      )),
                );
              } else if (menuPage == MenuPage.Schedule) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Layout(
                        title: "Cadastro de Evento",
                        body: ScheduleRegister(),
                        menuIcon: false,
                        accontIcon: false,
                      )),
                );
              } else if (menuPage == MenuPage.Reservation) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Layout(
                        title: "Cadastro de Area Compartilhada",
                        body: SheradAreaRegister(),
                        menuIcon: false,
                        accontIcon: false,
                      )),
                );
              }else if (menuPage == MenuPage.Backboard) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Layout(
                        title: "Cadastro de Aviso",
                        body: BackboardRegister(),
                        menuIcon: false,
                        accontIcon: false,
                      )),
                );
              }
            },
            tooltip: 'Novo Elemento',
            child: const Icon(Icons.add));
      }
    }
    return const Text("");
  }
  List<Widget> persistentFooterButtons() {
    if (menuIcon!) {
      return [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
            onPressed: () {
              if (menuPage! != MenuPage.Backboard) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Layout(
                        title: "Quadro de Avisos",
                        body: Backboard(),
                        menuPage: MenuPage.Backboard,
                        register: true,
                      )),
                );
              }
            },
            icon: const Icon(Icons.notifications_active_outlined),
            iconSize: 30,
            color: activeIcon(MenuPage.Backboard),
            tooltip: "Avisos",
          ),
          IconButton(
            onPressed: () {
              if (menuPage! != MenuPage.Reservation) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Layout(
                        title: "Área Compartilhada",
                        body: SheradArea(),
                        menuPage: MenuPage.Reservation,
                        register: true,
                      )),
                );
              }
            },
            icon: const Icon(Icons.deck_outlined),
            iconSize: 30,
            color: activeIcon(MenuPage.Reservation),
            tooltip: "Reserva",
          ),
          IconButton(
            onPressed: () {
              if (menuPage! != MenuPage.Schedule) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Layout(
                        title: "Agenda",
                        body: Schedule(),
                        menuPage: MenuPage.Schedule,
                        register: true,
                      )),
                );
              }
            },
            icon: const Icon(Icons.calendar_month),
            iconSize: 30,
            color: activeIcon(MenuPage.Schedule),
            tooltip: "Agenda",
          ),
          IconButton(
            onPressed: () {
              if (menuPage! != MenuPage.Invoice) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Layout(
                        title: "Faturamento",
                        body: Invoice(),
                        menuPage: MenuPage.Invoice,
                        register: true,
                      )),
                );
              }
            },
            icon: const Icon(Icons.content_paste_search),
            iconSize: 30,
            color: activeIcon(MenuPage.Invoice),
            tooltip: "Faturamento",
          ),
          IconButton(
            onPressed: () {
              if (menuPage! != MenuPage.Message) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Layout(
                          title: "Bate Papo",
                          body: Message(),
                          menuPage: MenuPage.Message
                          )
                  ),
                );
              }
            },
            icon: const Icon(Icons.chat_rounded),
            iconSize: 30,
            color: activeIcon(MenuPage.Message),
            tooltip: "Mensagens",
          ),
        ]),
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    register = widget.register;
    accontIcon = widget.accontIcon;
    menuIcon = widget.menuIcon;
    menuPage = widget.menuPage;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        //automaticallyImplyLeading: !accontIcon!,
        actions: accont(),
        title: Text(widget.title),
      ),
      body: widget.body,
      floatingActionButton: floatingAction(),
      persistentFooterButtons: persistentFooterButtons(),
    );
  }
}