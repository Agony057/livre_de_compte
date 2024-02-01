import 'package:appli_compte/entities/class/class_abstract_compte.dart';
import 'package:appli_compte/entities/class/class_operation_mensuelle.dart';
import 'package:appli_compte/entities/enum/enum_action_operation.dart';
import 'package:appli_compte/entities/enum/enum_type_operation.dart';
import 'package:appli_compte/entities/map/map_couleur.dart';
import 'package:appli_compte/pages/action/widget/ligne_value.dart';
import 'package:appli_compte/pages/operationMensuelle/widget/ligne_operation_mensuelle.dart';
import 'package:appli_compte/pages/operationMensuelle/widget/map_action_operation_mensuelle.dart';
import 'package:flutter/material.dart';

class OperationMensuellePage extends StatefulWidget {
  const OperationMensuellePage({super.key});
  @override
  State<OperationMensuellePage> createState() => _OperationMensuellePageState();
}

class _OperationMensuellePageState extends State<OperationMensuellePage> {
  late OperationMensuelle ligneSelect;
  late ActionOperationMensuelle choixAction;

// bool readOnlyNomMontantDureeType = true;
//   int numeroOperation = 0;
//   double montantOperation = 0;
//   String nomOperation = "";
//   int dureeOperation = 0;
//   TypeOperation typeOperation = TypeOperation.retrait;
  // readOnly
  late bool readOnlyNomMontantDureeType;
  // variableOperation
  late int numeroOperation;
  late double montantOperation;
  late String nomOperation;
  late int dureeOperation;
  late TypeOperation typeOperation = TypeOperation.retrait;
  // controller
  late final TextEditingController controllerMontant;
  late final TextEditingController controllerNom;
  late final TextEditingController controllerDuree;
  // late final TextEditingController controllerType;
  // parametre
  final int timeError = 2;

  @override
  void initState() {
    initPourInitState();
    super.initState();
  }

  @override
  void dispose() {
    controllerMontant.dispose();
    controllerNom.dispose();
    controllerDuree.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Compte compte = ModalRoute.of(context)!.settings.arguments as Compte;
    final List<OperationMensuelle> operations = compte.operationMensuelle;

    ///

    return Scaffold(
      appBar: AppBar(
        title: Text(compte.toString()),
        backgroundColor: mapCouleur["theme"],
      ),
      backgroundColor: mapCouleur["background"],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// TODO
          /// organiser
          ///
          initController();
          initVariableOperation();
          initLigneSelect();
          choixAction = ajouterSinonNone(choixAction);
          initReadOnly();
          setState(() {});
        },
        tooltip: 'Ajouter une operation mensuelle',
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (estAjouterOuModifier(choixAction))
                Column(
                  children: [
                    Text(
                      "Opération N° $numeroOperation",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Checkbox.width * 2,
                      ),
                    ),

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
                        readOnly: readOnlyNomMontantDureeType,
                        controller: controllerNom,
                        decoration: const InputDecoration(
                          labelText: "Entrez un nom d'opération",
                        ),
                      ),
                    ),

                    ///
                    /// 2eme Textfield Montant
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
                        readOnly: readOnlyNomMontantDureeType,
                        controller: controllerMontant,
                        decoration: const InputDecoration(
                          labelText: "Entrez un montant",
                        ),
                      ),
                    ),

                    ///
                    /// 3eme TextField
                    /// peut etre le remplacer
                    /// par un input qui gere les nombres ?
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
                        readOnly: readOnlyNomMontantDureeType,
                        controller: controllerDuree,
                        decoration: const InputDecoration(
                          labelText: "Entrez une durée",
                        ),
                      ),
                    ),

                    ///
                    /// Dropdown type operation
                    ///

                    Container(
                      // width: MediaQuery.of(context).size.width - 32,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                          color: mapCouleur["textfield"],
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<TypeOperation>(
                        borderRadius: BorderRadius.circular(10),
                        value: typeOperation,
                        onChanged: (value) {
                          typeOperation = value!;
                          setState(() {});
                        },
                        isExpanded: true,
                        items: [
                          for (final type in TypeOperation.values)
                            DropdownMenuItem(
                              value: type,
                              child: Text(type.name),
                            )
                        ],
                      ),
                    ),

                    ///
                    /// Fin Formulaire
                    ///

                    ///
                    /// Bouton Valider
                    ///
                    Container(
                      width: MediaQuery.of(context).size.width - 32,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (estAjouterOuModifier(choixAction)) {
                            final String nomAVerifier =
                                controllerNom.text.trim();
                            final String montantAVerifier =
                                controllerMontant.text.trim();
                            final String dureeAVerifier =
                                controllerDuree.text.trim();
                            if (!strValide(nomAVerifier)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                    "Le nom de l'operation n'est pas valide !"),
                                backgroundColor: mapCouleur["erreur"],
                                duration: Duration(seconds: timeError),
                              ));
                            } else if (!estDigit(
                                montantAVerifier.replaceAll(".", ""))) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                    "le montant doit être un nombre !"),
                                backgroundColor: mapCouleur["erreur"],
                                duration: Duration(seconds: timeError),
                              ));
                            } else if (!estDouble(montantAVerifier)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                    "Le montant doit contenir au plus un point en lieu et place de la virgule !"),
                                backgroundColor: mapCouleur["erreur"],
                                duration: Duration(seconds: timeError),
                              ));
                            } else if (!estDigit(dureeAVerifier)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                    "La durée de l'opération doit être un entier positif !"),
                                backgroundColor: mapCouleur["erreur"],
                                duration: Duration(seconds: timeError),
                              ));
                            } else {
                              nomOperation = nomAVerifier;
                              montantOperation = strToDouble(montantAVerifier);
                              dureeOperation = strToInt(dureeAVerifier);
                              OperationMensuelle operation =
                                  creerOperationMensuelle(
                                      numeroOperation,
                                      nomOperation,
                                      montantOperation,
                                      typeOperation,
                                      dureeOperation);
                              if (estAjouter(choixAction)) {
                                ajouterOperation(compte, operation);
                              } else if (estModifier(choixAction)) {
                                modifierOperationMensuelle(compte, operation);
                              }
                              // initController();
                              // initVariableOperation();
                              initFormulaire();
                              setState(() {});
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                  "Le bouton ne devrait pas apparaitre !"),
                              backgroundColor: mapCouleur["attention"],
                              duration: Duration(seconds: timeError),
                            ));
                          }
                        },
                        // borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          // alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: mapCouleur["valider"],
                            // borderRadius: BorderRadius.circular(10),
                          ),
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
                  ],
                ),
              if (operations.isNotEmpty)
                for (final OperationMensuelle operation in operations)
                  Column(
                    children: [
                      LigneOperationMensuelle(
                        operation: operation,
                        typeOperation: operation.type,
                        onClick: () {
                          ligneSelect = ligneSelect == operation
                              ? operationVierge()
                              : operation;
                          choixAction = ActionOperationMensuelle.none;
                          setState(() {});
                        },
                      ),
                      if (ligneSelect == operation)
                        Column(
                          children: [
                            for (final entry
                                in mapActionOperationMensuelle.entries)
                              Column(
                                children: [
                                  LigneValue(
                                    value: entry.value,
                                    isSelect: entry.key == choixAction,
                                    onClick: () {
                                      choixAction = entry.key;
                                      if (estModifier(choixAction)) {
                                        initController();
                                        initReadOnly();
                                        remplirFormulaireModifier(operation);
                                      } else if (estSupprimer(choixAction)) {
                                        supprimerOperationMensuelle(
                                            compte, operation);
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            Divider(
                              endIndent: 20,
                              indent: 20,
                              color: mapCouleur["theme"],
                            ),
                          ],
                        ),
                    ],
                  ),
              Divider(
                endIndent: 20,
                indent: 20,
                color: mapCouleur["theme"],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initPourInitState() {
    controllerMontant = TextEditingController();
    controllerNom = TextEditingController();
    controllerDuree = TextEditingController();
    initLigneSelect();
    initChoix();
    initReadOnly();
    initVariableOperation();
  }

  void initFormulaire() {
    initController();
    initChoix();
    initReadOnly();
    initVariableOperation();
    // setState(() {});
  }

  void initController() {
    controllerNom.clear();
    controllerMontant.clear();
    controllerDuree.clear();
    // setState(() {});
  }

  void initVariableOperation() {
    /// TODO
    /// une requete  pour avoir le dernier numero attribué + 1
    numeroOperation = 0;
    nomOperation = "";
    montantOperation = 0;
    dureeOperation = 0;
    typeOperation = TypeOperation.retrait;
    // setState(() {});
  }

  void initChoix() {
    choixAction = ActionOperationMensuelle.none;
    // setState(() {});
  }

  void initReadOnly() {
    readOnlyNomMontantDureeType = !estAjouterOuModifier(choixAction);
    // setState(() {});
  }

  void initLigneSelect() {
    ligneSelect = operationVierge();
  }

  OperationMensuelle operationVierge() {
    OperationMensuelle operation = OperationMensuelle(
        numero: 0, nom: "", montant: 0, type: TypeOperation.retrait);
    return operation;
  }

  bool estAjouterOuModifier(ActionOperationMensuelle choix) {
    bool res = false;
    if (estAjouter(choix) || estModifier(choix)) {
      res = true;
    }
    return res;
  }

  bool estAjouter(ActionOperationMensuelle choix) {
    bool res = false;
    if (choix == ActionOperationMensuelle.ajouter) {
      res = true;
    }
    return res;
  }

  ActionOperationMensuelle ajouterSinonNone(ActionOperationMensuelle choix) {
    choix = estAjouter(choixAction)
        ? ActionOperationMensuelle.none
        : ActionOperationMensuelle.ajouter;
    return choix;
  }

  void ajouterOperation(Compte compte, OperationMensuelle operation) {
    compte.ajouterOperationMensuelle(operation);
  }

  bool estModifier(ActionOperationMensuelle choix) {
    bool res = false;
    if (choix == ActionOperationMensuelle.modifier) {
      res = true;
    }
    return res;
  }

  void remplirFormulaireModifier(OperationMensuelle operation) {
    numeroOperation = operation.numero;
    controllerNom.text = operation.nom;
    controllerMontant.text = operation.montant.toString();
    controllerDuree.text =
        operation.duree < 0 ? "0" : operation.duree.toString();
    typeOperation = operation.type;
  }

  void modifierOperationMensuelle(Compte compte, OperationMensuelle operation) {
    compte.operationMensuelle
        .firstWhere((element) => element.numero == operation.numero)
        .nom = operation.nom;
    compte.operationMensuelle
        .firstWhere((element) => element.numero == operation.numero)
        .montant = operation.montant;
    compte.operationMensuelle
        .firstWhere((element) => element.numero == operation.numero)
        .type = operation.type;
    compte.operationMensuelle
        .firstWhere((element) => element.numero == operation.numero)
        .duree = operation.duree;
  }

  bool estSupprimer(ActionOperationMensuelle choix) {
    bool res = false;
    if (choix == ActionOperationMensuelle.supprimer) {
      res = true;
    }
    return res;
  }

  void supprimerOperationMensuelle(
      Compte compte, OperationMensuelle operation) {
    compte.retirerOperationMensuelle(operation);
  }

  int strToInt(String chaine) {
    int res = 0;
    res = int.parse(chaine);
    return res;
  }

  double strToDouble(String chaine) {
    double res = 0;
    if (estDouble(chaine)) {
      res = double.parse(chaine);
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

  OperationMensuelle creerOperationMensuelle(
      int numero, String nom, double montant, TypeOperation type, int duree) {
    duree = duree > 0 ? duree : -1;
    numero = numero != 0
        ? numero
        : DateTime.now().minute +
            DateTime.now().second +
            DateTime.now().microsecond;
    OperationMensuelle operationMensuelle = OperationMensuelle(
        numero: numero, nom: nom, montant: montant, type: type, duree: duree);
    return operationMensuelle;
  }
}
