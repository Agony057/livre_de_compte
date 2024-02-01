import 'package:appli_compte/entities/class/class_abstract_compte.dart';

class Journalisation {
  static final Map<Compte, Journalisation> _instance = {};
  final List<String> _operation = [];

  static Journalisation getInstance(Compte clef) {
    if (!Journalisation._instance.containsKey(clef)) {
      Journalisation._instance.addAll({clef: Journalisation()});
    }
    return Journalisation._instance[clef]!;
  }

  void journaliser(String operation) {
    final DateTime date = DateTime.now();
    final String jour = date.day.toString();
    final String mois = date.month < 10 ? "0${date.month}" : "${date.month}";
    final String annee = date.year.toString();
    final String dateFormat = "$jour/$mois/$annee";
    _operation.add("[ $dateFormat ] $operation");
  }

  List<String> getOperation() {
    return _operation;
  }
}
