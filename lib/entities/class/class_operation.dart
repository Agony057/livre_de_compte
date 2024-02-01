import 'package:appli_compte/entities/enum/enum_type_operation.dart';

class Operation {
  late final int _numero;
  late String _nom;
  late double _montant;
  late TypeOperation _type;
  // int _duree;

  Operation({
    int numero = 8,
    required String nom,
    required double montant,
    required TypeOperation type,
  }) {
    _numero = numero;
    this.nom = nom;
    this.montant = montant;
    this.type = type;
  }

  // getters / setters

  int get numero {
    return _numero;
  }

  String get nom {
    return _nom;
  }

  set nom(String valeur) {
    _nom = valeur.trim();
  }

  double get montant {
    return _montant;
  }

  set montant(double valeur) {
    _montant = valeur.abs();
  }

  TypeOperation get type {
    return _type;
  }

  set type(TypeOperation valeur) {
    _type = valeur;
  }

  // methods

  @override
  String toString() {
    final String str = nom;
    return str;
  }
}
