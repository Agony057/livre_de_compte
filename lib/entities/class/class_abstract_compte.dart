import 'package:appli_compte/entities/class/class_operation.dart';
import 'package:appli_compte/entities/class/class_operation_mensuelle.dart';
import 'package:appli_compte/entities/class/class_journalisation.dart';
import '../enum/enum_type_compte.dart';

abstract class Compte {
  late String _nom;
  late final String _numero;
  late double _solde;
  late TypeCompte _type;
  late final List<OperationMensuelle> _operationMensuelle = [];

  Compte(
    String nom,
    String numero,
    double solde,
    TypeCompte type,
  ) {
    this.nom = nom;
    _numero = numero;
    this.solde = solde;
    this.type = type;
  }

  String get nom {
    return _nom;
  }

  String get numero {
    return _numero;
  }

  double get solde {
    return _solde;
  }

  TypeCompte get type {
    return _type;
  }

  List<OperationMensuelle> get operationMensuelle {
    return _operationMensuelle;
  }

  set nom(String valeur) {
    _nom = valeur.trim();
  }

  set solde(double valeur) {
    _solde = valeur;
  }

  set type(TypeCompte valeur) {
    _type = valeur;
  }

  void deposer(Operation operation) {
    _solde += operation.montant;
    Journalisation.getInstance(this).journaliser(
        "Compte ${numero} : ${nom} ${operation.type.name} de ${operation.montant} €. Motif : ${operation.nom}");
  }

  void retirer(Operation operation) {
    _solde -= operation.montant;
    Journalisation.getInstance(this).journaliser(
        "Compte ${numero} : ${nom} ${operation.type.name} de ${operation.montant} €. Motif : ${operation.nom}");
  }

  void ajouterOperationMensuelle(OperationMensuelle operation) {
    operationMensuelle.add(operation);
  }

  void retirerOperationMensuelle(OperationMensuelle operation) {
    operationMensuelle.remove(operation);
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'numero': numero,
      'solde': solde,
    };
  }

  @override
  String toString() {
    final String str = nom;
    return str;
  }
}
