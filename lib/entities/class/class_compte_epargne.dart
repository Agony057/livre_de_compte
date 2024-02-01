import 'package:appli_compte/entities/enum/enum_type_compte.dart';
import 'class_abstract_compte.dart';

class CompteEpargne extends Compte {
  late double _tauxInteret;

  CompteEpargne(String nom, String numero, double solde, TypeCompte type,
      {double tauxInteret = 0})
      : super(nom, numero, solde, type) {
    this.tauxInteret = tauxInteret;
  }

  double get tauxInteret {
    return _tauxInteret;
  }

  set tauxInteret(double valeur) {
    _tauxInteret = valeur.abs();
  }

  double calculerInterets() {
    return solde * tauxInteret;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['type'] = 'epargne';
    json['tauxInteret'] = tauxInteret;
    return json;
  }
}
