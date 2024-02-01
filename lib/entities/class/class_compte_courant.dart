import 'package:appli_compte/entities/enum/enum_type_compte.dart';
import 'class_abstract_compte.dart';

class CompteCourant extends Compte {
  late double _decouvertAutorise;

  CompteCourant(String nom, String numero, double solde, TypeCompte type,
      {double decouvertAutorise = 0})
      : super(nom, numero, solde, type) {
    this.decouvertAutorise = decouvertAutorise;
  }

  double get decouvertAutorise {
    return _decouvertAutorise;
  }

  set decouvertAutorise(double valeur) {
    // on change la valeur de decouvertAutorise grace a la valeur absolue du parametre
    _decouvertAutorise = valeur.abs();
  }

  bool soldePositif() {
    // fonction qui retourne un booleen pour savoir si le solde est positif
    return solde >= 0;
  }

  void decouvertOff() {
    if (soldePositif()) {
      decouvertAutorise = 0;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['type'] = 'courant';
    json['decouvertAutorise'] = decouvertAutorise;
    return json;
  }
}
