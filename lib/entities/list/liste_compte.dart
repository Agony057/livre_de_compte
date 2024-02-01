import 'package:appli_compte/entities/class/class_abstract_compte.dart';
import 'package:appli_compte/entities/class/class_compte_courant.dart';
import 'package:appli_compte/entities/class/class_compte_epargne.dart';
import 'package:appli_compte/entities/enum/enum_type_compte.dart';

int numero = DateTime.now().second +
    (DateTime.now().microsecond + DateTime.now().millisecond) ~/ 2;
CompteCourant compte1 = CompteCourant(
    "Compte Courant BPL", (numero + 1).toString(), -100, TypeCompte.courant);
CompteCourant compte2 = CompteCourant(
    "Compte Courant BNP", (numero + 2).toString(), 100, TypeCompte.courant);
CompteEpargne compte3 = CompteEpargne(
    "Livret A de Anthony", (numero + 3).toString(), 150, TypeCompte.livretA);
CompteEpargne compte4 = CompteEpargne(
    "Livret A de Justine", (numero + 4).toString(), 200, TypeCompte.livretA);
CompteEpargne compte5 = CompteEpargne(
    "PEL Imaginaire ;)", (numero + 5).toString(), 300, TypeCompte.pel);

final listeCompte = <Compte>[
  compte1,
  compte2,
  compte3,
  compte4,
  compte5,
];
