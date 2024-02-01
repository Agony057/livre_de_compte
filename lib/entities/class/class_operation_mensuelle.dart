import 'package:appli_compte/entities/class/class_operation.dart';

class OperationMensuelle extends Operation {
  late int _duree;

  // constructor
  OperationMensuelle(
      {super.numero,
      required super.nom,
      required super.montant,
      required super.type,
      int duree = (-1)}) {
    _duree = duree;
  }

  // getters / setters
  int get duree {
    return _duree;
  }

  set duree(int valeur) {
    _duree = valeur <= 0 ? -1 : valeur.abs();
  }

  // methods
  bool dureeNegative() {
    return duree < 0;
  }

  bool dureeAZero() {
    return duree == 0;
  }

  void reduireDuree() {
    _duree -= 1;
  }
}
