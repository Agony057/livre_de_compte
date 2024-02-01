import 'dart:convert';
import 'dart:io';

import 'package:appli_compte/pages/compte/liste_comptes.json';

import 'package:appli_compte/entities/class/class_compte_courant.dart';
import 'package:appli_compte/entities/class/class_compte_epargne.dart';
import 'package:appli_compte/entities/class/class_operation.dart';
import 'package:appli_compte/entities/enum/enum_action_compte.dart';
import 'package:appli_compte/entities/enum/enum_type_compte.dart';
import 'package:appli_compte/entities/class/class_journalisation.dart';
import 'package:appli_compte/entities/enum/enum_type_operation.dart';
import 'package:appli_compte/entities/list/liste_compte.dart';
import 'package:appli_compte/entities/class/class_abstract_compte.dart';
import 'package:appli_compte/entities/map/map_action_compte.dart';
import 'package:appli_compte/pages/action/widget/ligne_value.dart';
import 'package:appli_compte/pages/compte/widget/ligne_compte.dart';
import 'package:appli_compte/route/pages.dart';

import 'package:flutter/material.dart';
import 'package:appli_compte/entities/map/map_couleur.dart';

class ComptePage extends StatefulWidget {
  const ComptePage({super.key, required this.title});

  final String title;

  @override
  State<ComptePage> createState() => _ComptePageState();
}

class _ComptePageState extends State<ComptePage> {
  // variable de selection
  late Compte compteSelect;
  late ActionCompte choixSelect;

  // bool
  late bool ajouterUnCompte;
  late bool readOnlyAjoutCompte;
  late bool readOnlyOperationUnique;
  // variable AjoutCompte
  late String numeroCompte;
  late String nomCompte;
  late double soldeCompte;
  late TypeCompte typeCompte;
  // variable OperationUnique
  late String nomOperation;
  late double montantOperation;
  // controller
  late final TextEditingController controllerMontantOperation;
  late final TextEditingController controllerNomOperation;
  late final TextEditingController controllerNomCompte;
  late final TextEditingController controllerSoldeCompte;
  // parametre
  final int timeError = 2;

  @override
  void initState() {
    initPourInitState();
    super.initState();
  }

  @override
  void dispose() {
    controllerMontantOperation.dispose();
    controllerNomOperation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: mapCouleur['theme'],
      ),
      backgroundColor: mapCouleur["background"],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initCompteSelect();
          initControllerAjoutCompte();
          initVariablesAjouterCompte();
          ajouterUnCompte = ajouterTrueFalse(ajouterUnCompte);
          setState(() {});
        },
        tooltip: 'Ajouter un compte',
        backgroundColor: mapCouleur["theme"],
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Formulaire Ajouter un Comtpe
              if (ajouterUnCompte)
                Column(
                  children: [
                    Text(
                      "Opération N° ${compteSelect.numero}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Checkbox.width * 2,
                      ),
                    ),

                    /// Textfield nom de compte
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: mapCouleur["textfield"],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: TextField(
                        readOnly: readOnlyAjoutCompte,
                        controller: controllerNomCompte,
                        decoration: const InputDecoration(
                          labelText: "Entrez un nom de compte",
                        ),
                      ),
                    ),

                    /// textfield solde du compte
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                          color: mapCouleur["textfield"],
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: TextField(
                        readOnly: readOnlyAjoutCompte,
                        controller: controllerSoldeCompte,
                        decoration: const InputDecoration(
                          labelText: "Entrez le solde",
                        ),
                      ),
                    ),

                    /// dropdown type de compte
                    Container(
                      // width: MediaQuery.of(context).size.width - 32,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                          color: mapCouleur["textfield"],
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<TypeCompte>(
                        borderRadius: BorderRadius.circular(10),
                        value: typeCompte,
                        onChanged: (value) {
                          typeCompte = value!;
                          setState(() {});
                        },
                        isExpanded: true,
                        items: [
                          for (final type in TypeCompte.values)
                            DropdownMenuItem(
                              value: type,
                              child: Text(type.name),
                            )
                        ],
                      ),
                    ),

                    /// bouton valider

                    SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      child: InkWell(
                        onTap: () {
                          if (ajouterUnCompte) {
                            final String nomAVerifier =
                                controllerNomCompte.text.trim();
                            final String montantAVerifier =
                                controllerSoldeCompte.text.trim();
                            if (!strValide(nomAVerifier)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    const Text("Nom de compte non valide !"),
                                backgroundColor: mapCouleur["erreur"],
                                duration: Duration(seconds: timeError),
                              ));
                            } else if (!estDigit(
                                montantAVerifier.replaceFirst("-", ""))) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                    "Le solde ne doit contenir que des chiffres avec eventuellement un signe négatif devant !"),
                                backgroundColor: mapCouleur["erreur"],
                                duration: Duration(seconds: timeError),
                              ));
                            } else if (!estDouble(
                                montantAVerifier.replaceFirst("-", ""))) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                    "Seulement un point au lieu de la virgule est autorisé !"),
                                backgroundColor: mapCouleur["erreur"],
                                duration: Duration(seconds: timeError),
                              ));
                            } else if (!estNegatif(montantAVerifier)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    const Text("Un seul \"-\" est autorisé !"),
                                backgroundColor: mapCouleur["erreur"],
                                duration: Duration(seconds: timeError),
                              ));
                            } else {
                              nomCompte = nomAVerifier;
                              soldeCompte = strToDouble(montantAVerifier);
                              int numero = DateTime.now().minute +
                                  DateTime.now().second +
                                  DateTime.now().microsecond;
                              numeroCompte = numero.toString();
                              Compte compte = creerCompteParType(
                                nomCompte,
                                numeroCompte,
                                soldeCompte,
                                typeCompte,
                              );

                              // CompteCourant compte = creerCompteCourant(
                              //   nomCompte,
                              //   numeroCompte,
                              //   soldeCompte,
                              //   typeCompte,
                              // );
                              ajouterCompteDansList(compte);
                              initControllerOperation();
                              initFormulaireAjoutCompte();
                              setState(() {});
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text("Erreur bizarre !"),
                              backgroundColor: mapCouleur["attention"],
                              duration: Duration(seconds: timeError),
                            ));
                          }
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          // alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: mapCouleur["valider"],
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.check,
                          ),
                        ),
                      ),
                    ),

                    Divider(
                      endIndent: 20,
                      indent: 20,
                      color: mapCouleur["theme"],
                    ),

                    ///
                    /// Fin Formulaire Ajout d'un compte
                    ///
                  ],
                ),

              for (final Compte compte in listeCompte)
                Column(
                  children: [
                    LigneCompte(
                      compte: compte,
                      onClick: () => clickOnCompte(compte),
                    ),
                    if (compteSelect == compte)
                      Column(
                        children: [
                          Text(
                            compte.solde.toStringAsFixed(2),
                            style: TextStyle(
                              color: compte.solde < 0
                                  ? mapCouleur["negatif"]
                                  : mapCouleur["positif"],
                              fontWeight: FontWeight.bold,
                              fontSize: Checkbox.width * 2,
                            ),
                          ),
                          if (estDeposerOuRetirer(choixSelect))
                            Column(
                              children: [
                                ///
                                /// 1er Textfield Nom Operation
                                ///
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      color: mapCouleur["textfield"],
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  child: TextField(
                                    readOnly: readOnlyOperationUnique,
                                    controller: controllerNomOperation,
                                    decoration: const InputDecoration(
                                      labelText: "Entrez un nom d'opération",
                                    ),
                                  ),
                                ),

                                ///
                                /// 2eme Textfield Montant operation
                                ///

                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      color: mapCouleur["textfield"],
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  child: TextField(
                                    readOnly: readOnlyOperationUnique,
                                    controller: controllerMontantOperation,
                                    decoration: const InputDecoration(
                                      labelText: "Entrez un montant",
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ///
                          /// Button valider operation
                          ///
                          if (choixSelect != ActionCompte.none)
                            Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 32,
                                  child: InkWell(
                                    onTap: () {
                                      /// TODO
                                      /// J'ai ajouté la fonction toJson pour essayer de creer un fichier Json depuis listeCompte

                                      // toJson();

                                      /// TODO
                                      if (estDeposerOuRetirer(choixSelect)) {
                                        final String nomAVerifier =
                                            controllerNomOperation.text.trim();
                                        final String montantAVerfifier =
                                            controllerMontantOperation.text
                                                .trim();
                                        if (verifierDeposerRetirer(
                                            montantAVerfifier,
                                            context,
                                            nomAVerifier)) {
                                          clickOnValider(
                                              montantAVerfifier, nomAVerifier);
                                          creerOperation(
                                              nomOperation,
                                              montantOperation,
                                              actionCompteToTypeOperation(
                                                  choixSelect));
                                          clickOnButton(
                                              choixSelect, compteSelect);
                                          initControllerOperation();
                                          initVariablesOperationUnique();
                                        }
                                      } else if (estHistorique(choixSelect)) {
                                        if (auMoinsUnHistorique(compteSelect)) {
                                          afficherHistorique(compteSelect);
                                        } else {
                                          notExistHistorique();
                                        }
                                      } else if (estSupprimer(choixSelect)) {
                                        supprimer(compte);
                                      } else if (estOperationMensuelle(
                                          choixSelect)) {
                                        afficherOpertaionMensuelle(
                                            compteSelect);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text("$choixSelect non codé !"),
                                          backgroundColor:
                                              mapCouleur["attention"],
                                          duration:
                                              Duration(seconds: timeError),
                                        ));
                                      }
                                      setState(() {});
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      // alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                              couleurBoutonValider(choixSelect),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(
                                        Icons.check,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          for (final entry in mapActionCompte.entries)
                            LigneValue(
                              value: entry.value,
                              onClick: () => clickOnAction(entry.key),
                              isSelect: choixSelect == entry.key,
                            ),
                          // Fin boucle
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: mapCouleur["theme"],
                          ),
                        ],
                      ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  // void toJson() {
  //   // Convertir la liste de comptes en une liste de Map
  //   List<Map<String, dynamic>> listeCompteMap =
  //       listeCompte.map((compte) => compte.toJson()).toList();

  //   // Convertir la liste de Map en une chaîne JSON
  //   String jsonString = jsonEncode(listeCompteMap);

  //   // Écrire la chaîne JSON dans un fichier
  //   String dateCreation =
  //       '${DateTime.now().hour}_${DateTime.now().minute}_${DateTime.now().second}_${DateTime.now().millisecond}';
  //   String fileName = 'liste_comptes.json';
  //   File('$fileName').writeAsString(jsonString).then((_) {
  //     print('Fichier JSON créé avec succès : $fileName');
  //   }).catchError((error) {
  //     print('Erreur lors de la création du fichier JSON "$fileName" : $error');
  //     // print(listeCompteMap);
  //     // print(jsonString);
  //   });
  // }

  TypeOperation actionCompteToTypeOperation(ActionCompte choix) {
    TypeOperation type = TypeOperation.depot;
    if (choix == ActionCompte.deposer) {
      type = TypeOperation.depot;
    } else if (choix == ActionCompte.retirer) {
      type = TypeOperation.retrait;
    }
    return type;
  }

  void clickOnValider(String montantAVerfifier, String nomAVerifier) {
    nomOperation = strValide(nomAVerifier) ? nomAVerifier : "";
    montantOperation =
        estDouble(montantAVerfifier) ? strToDouble(montantAVerfifier) : 0;
    setState(() {});
  }

  void clickOnAction(ActionCompte entry) {
    choixSelect = entry;
    readOnlyOperationUnique = choixSelect == ActionCompte.retirer ||
            choixSelect == ActionCompte.deposer
        ? false
        : true;
    if (readOnlyOperationUnique == true) {
      controllerNomOperation.clear();
      controllerMontantOperation.clear();
    }
    setState(() {});
  }

  void clickOnCompte(Compte compte) {
    initClickOnCompte();
    compteSelect = compteSelect == compte ? compteVierge() : compte;
    setState(() {});
  }

  Operation creerOperation(String nom, double montant, TypeOperation type) {
    // créé un objet operation
    return Operation(numero: 7, nom: nom, montant: montant, type: type);
  }

  void clickOnButton(ActionCompte entree, Compte compte) {
    if (estDeposerOuRetirer(entree)) {
      final Operation operation = creerOperation(nomOperation, montantOperation,
          actionCompteToTypeOperation(choixSelect));
      deposerOuRetirer(compte, operation);
    } else if (estHistorique(entree)) {
      afficherHistorique(compte);
    } else if (estSupprimer(entree)) {
      supprimer(compte);
    }
  }

  void initPourInitState() {
    controllerMontantOperation = TextEditingController();
    controllerNomOperation = TextEditingController();
    controllerNomCompte = TextEditingController();
    controllerSoldeCompte = TextEditingController();
    initCompteSelect();
    initChoixSelect();
    initAjouterUnCompte();
    initReadOnlys();
    initVariablesAjouterCompte();
    initVariablesOperationUnique();
  }

  void initPage() {
    initCompteSelect();
    initChoixSelect();
    initAjouterUnCompte();
    initReadOnlys();
    initVariablesAjouterCompte();
    initVariablesOperationUnique();
  }

  void initFormulaireAjoutCompte() {
    initControllerAjoutCompte();
    initCompteSelect();
    initChoixSelect();
    initAjouterUnCompte();
    initReadOnlys();
    initVariablesAjouterCompte();
  }

  void initControllers() {
    initControllerAjoutCompte();
    initControllerOperation();
  }

  void initFormulaireOperationUnique() {
    initControllerOperation();
  }

  void initControllerAjoutCompte() {
    controllerNomCompte.clear();
    controllerSoldeCompte.clear();
  }

  void initControllerOperation() {
    controllerNomOperation.clear();
    controllerMontantOperation.clear();
    // setState(() {});
  }

  void initVariablesAjouterCompte() {
    numeroCompte = "";
    nomCompte = "";
    soldeCompte = 0;
    typeCompte = TypeCompte.courant;
  }

  void initVariablesOperationUnique() {
    nomOperation = "";
    montantOperation = 0;
    // setState(() {});
  }

  void initChoixSelect() {
    choixSelect = ActionCompte.none;
  }

  void initCompteSelect() {
    compteSelect = compteVierge();
  }

  void initReadOnlyOperation() {
    readOnlyOperationUnique = estDeposerOuRetirer(choixSelect);
  }

  void initReadOnlyAjout() {
    readOnlyAjoutCompte = ajouterUnCompte;
  }

  void initReadOnlys() {
    initReadOnlyAjout();
    initReadOnlyOperation();
  }

  void initAjouterUnCompte() {
    ajouterUnCompte = false;
  }

  void initClickOnCompte() {
    initControllerOperation();
    initChoixSelect();
    initReadOnlyOperation();
    initAjouterUnCompte();
  }

  void initAttributPage() {
    choixSelect = ActionCompte.none;
    readOnlyOperationUnique = false;
    ajouterUnCompte = false;
    // setState(() {});
  }

  bool ajouterTrueFalse(bool aChanger) {
    bool res = aChanger;
    res = aChanger == true ? false : true;
    return res;
  }

  void compteSelectAZero() {
    compteSelect = CompteCourant("", "", 0, TypeCompte.courant);
    setState(() {});
  }

  Compte compteVierge() {
    Compte compte = CompteCourant("", "", 0, TypeCompte.courant);
    return compte;
  }

  Color? couleurBoutonValider(ActionCompte choix) {
    Color? res = mapCouleur["bleu"];
    switch (choix) {
      case ActionCompte.deposer:
      case ActionCompte.retirer:
        res = mapCouleur["valider"];
        break;
      case ActionCompte.operationMensuelle:
        break;
      case ActionCompte.historique:
        break;
      case ActionCompte.supprimer:
        res = mapCouleur["negatif"];
        break;
      default:
        mapCouleur["ligne"];
    }
    return res;
  }

  bool strValide(String chaine) {
    // retourne vrai si la chaine ne comporte pas les exceptions du tableau
    bool res = true;
    final tableauException = <String>[
      "",
    ];
    if (chaine.trim().isEmpty) {
      res = false;
    } else {
      for (final element in chaine.split("")) {
        if (tableauException.contains(element)) {
          res = false;
          break;
        }
      }
    }
    // print("strValide(\'$chaine\') : $res");
    return res;
  }

  double strToDouble(String chaine) {
    double res = 0;
    if (estDouble(chaine)) {
      res = double.parse(chaine);
    }
    return res;
  }

  bool estNegatif(String chaine) {
    bool res = true;
    bool moins = false;
    const signeNegatif = "-";
    if (chaine.isEmpty) {
      res = false;
    } else {
      for (final element in chaine.split("")) {
        if (element == signeNegatif) {
          if (moins == true) {
            res = false;
            break;
          }
          moins = true;
        }
      }
    }

    return res;
  }

  bool estDouble(String chaine) {
    bool res = true;
    bool point = false;
    final tableauDouble = <String>[
      ".",
    ];
    if (chaine.isEmpty || !estDigit(chaine.replaceAll(".", ""))) {
      res = false;
    } else {
      for (final element in chaine.split("")) {
        if (element == tableauDouble[0]) {
          if (point == true) {
            res = false;
            break;
          }
          point = true;
          // point == true ? res = false : point = true;
        }
      }
    }
    // print("estDouble(\'$chaine\') : $res . point : $point");
    return res;
  }

  bool estDigit(String chaine) {
    bool res = true;
    final tableauDigit = <String>[
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
    ];
    if (chaine.isEmpty) {
      res = false;
    } else {
      for (final element in chaine.split("")) {
        if (!tableauDigit.contains(element)) {
          res = false;
          break;
        }
      }
    }
    return res;
  }

  bool estOperationMensuelle(ActionCompte choix) {
    bool res = false;
    if (choix == ActionCompte.operationMensuelle) {
      res = true;
    }
    return res;
  }

  bool estDeposerOuRetirer(ActionCompte choix) {
    // retourne true si deposer ou retirer
    bool res = false;
    if (choix == ActionCompte.deposer || choix == ActionCompte.retirer) {
      res = true;
    }
    // print("deposerOuRetirer($choix) : $res");
    return res;
  }

  void deposerOuRetirer(Compte compte, Operation operation) {
    if (operation.type == TypeOperation.depot) {
      compte.deposer(operation);
    } else if (operation.type == TypeOperation.retrait) {
      compte.retirer(operation);
    }
  }

  bool auMoinsUnHistorique(Compte compteSelect) {
    bool res = false;
    List<String> historique =
        Journalisation.getInstance(compteSelect).getOperation();
    if (historique.isNotEmpty) {
      res = true;
    }
    return res;
  }

  void notExistHistorique() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$compteSelect n'a pas encore d'historique !"),
      backgroundColor: mapCouleur["attention"],
      duration: Duration(seconds: timeError),
    ));
  }

  bool estHistorique(ActionCompte choix) {
    bool res = false;
    res = choix == ActionCompte.historique;
    return res;
  }

  Compte creerCompteParType(
    String nom,
    String numero,
    double solde,
    TypeCompte type,
  ) {
    late final Compte compte;
    switch (type) {
      case TypeCompte.courant:
        compte = CompteCourant(nom, numero, solde, type);
        break;
      default:
        compte = CompteEpargne(nom, numero, solde, type);
    }
    return compte;
  }

  CompteCourant creerCompteCourant(
    String nom,
    String numero,
    double solde,
    TypeCompte type,
  ) {
    CompteCourant compte;
    compte = CompteCourant(nom, numero, solde, type);
    return compte;
  }

  void ajouterCompteDansList(Compte compte) {
    listeCompte.add(compte);
  }

  void afficherHistorique(Compte compte) {
    Navigator.pushNamed(
      context,
      Pages.historique,
      arguments: compte,
    );
  }

  void afficherOpertaionMensuelle(Compte compte) {
    Navigator.pushNamed(
      context,
      Pages.operationMensuelle,
      arguments: compte,
    );
  }

  bool estSupprimer(ActionCompte choix) {
    bool res = false;
    res = choix == ActionCompte.supprimer;
    return res;
  }

  void supprimer(Compte compte) {
    // print(listeCompte);
    listeCompte.remove(compte);
    // print(listeCompte);
    setState(() {});
  }

  bool verifierDeposerRetirer(
      String montantAVerfifier, BuildContext context, String nomAVerifier) {
    bool verif = true;
    if (!estDouble(montantAVerfifier)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Il faut saisir un nombre !"),
        backgroundColor: mapCouleur["erreur"],
        duration: Duration(seconds: timeError),
      ));
      verif = false;
    } else if (strToDouble(montantAVerfifier) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Le nombre doit être supérieur à 0 !"),
        backgroundColor: mapCouleur["erreur"],
        duration: Duration(seconds: timeError),
      ));
      verif = false;
    } else if (!strValide(nomAVerifier)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Le nom de l'opération n'est pas valide !"),
        backgroundColor: mapCouleur["erreur"],
        duration: Duration(seconds: timeError),
      ));
      verif = false;
    } else if (!estDeposerOuRetirer(choixSelect)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "L'opération selectionnée doit être ${mapActionCompte[choixSelect]} ou ${mapActionCompte[choixSelect]} !"),
        backgroundColor: mapCouleur["erreur"],
        duration: Duration(seconds: timeError),
      ));
      verif = false;
    } else if (compteSelect.type == TypeCompte.courant) {
      final CompteCourant compteCourant = CompteCourant(
        compteSelect.nom,
        compteSelect.numero,
        compteSelect.solde,
        compteSelect.type,
      );
      if (compteCourant.soldePositif()) {
        if (choixSelect == ActionCompte.retirer) {
          if (strToDouble(montantAVerfifier) > (compteCourant.solde)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("Le compte est dans le négatif !"),
              // content: const Text("Le découvert autorisé a été dépassé !"),
              backgroundColor: mapCouleur["attention"],
              duration: Duration(seconds: timeError),
            ));
          }
        }
      }
    } else {}
    return verif;
  }
}
