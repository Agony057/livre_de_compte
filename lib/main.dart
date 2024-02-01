import 'package:appli_compte/entities/map/map_couleur.dart';
import 'package:appli_compte/pages/compte/compte_page.dart';
import 'package:appli_compte/pages/historique/historique_page.dart';
import 'package:appli_compte/pages/operationMensuelle/operation_mensuelle_page.dart';
import 'package:appli_compte/route/pages.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de compte',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(backgroundColor: mapCouleur["theme"])),
      initialRoute: Pages.compte,
      routes: {
        // Pages.user: (context) => const UserPage(),
        // Pages.action: (context) => const ActionPage(),
        Pages.compte: (context) => const ComptePage(title: "Liste de Compte"),
        Pages.historique: (context) => HistoriquePage(),
        Pages.operationMensuelle: (context) => const OperationMensuellePage(),
      },
    );
  }
}
