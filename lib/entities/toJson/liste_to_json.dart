import 'dart:convert';
import 'dart:io';

import 'package:appli_compte/entities/class/class_abstract_compte.dart';
import 'package:appli_compte/entities/list/liste_compte.dart';

void main() {
  // Votre liste de comptes
  List<Compte> listeCompte = [
    compte1,
    compte2,
    compte3,
    compte4,
    compte5,
  ];

  // Convertir la liste de comptes en une liste de Map
  List<Map<String, dynamic>> listeCompteMap =
      listeCompte.map((compte) => compte.toJson()).toList();

  // Convertir la liste de Map en une chaîne JSON
  String jsonString = jsonEncode(listeCompteMap);

  // Écrire la chaîne JSON dans un fichier
  String fileName = 'liste_comptes.json';
  File(fileName).writeAsString(jsonString).then((_) {
    print('Fichier JSON créé avec succès : $fileName');
  }).catchError((error) {
    print('Erreur lors de la création du fichier JSON : $error');
  });
}
