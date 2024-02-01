// import 'package:appli_compte/entities/class/class_abstract_compte.dart';
// import 'package:appli_compte/entities/class/class_operation.dart';
// import 'package:appli_compte/entities/enum/enum_action_compte.dart';
// import 'package:appli_compte/entities/enum/enum_type_operation.dart';
// import 'package:appli_compte/entities/list/liste_compte.dart';
// import 'package:appli_compte/entities/map/map_action_compte.dart';
// import 'package:appli_compte/entities/map/map_couleur.dart';
// import 'package:appli_compte/pages/action/widget/ligne_value.dart';
// import 'package:appli_compte/route/pages.dart';
// import 'package:flutter/material.dart';

// class ActionPage extends StatefulWidget {
//   const ActionPage({super.key});

//   @override
//   State<ActionPage> createState() => _ActionPageState();
// }

// class _ActionPageState extends State<ActionPage> {
//   ActionCompte choix = ActionCompte.retirer;
//   bool readOnlyNomMontant = false;
//   double montant = 0;
//   String nom = "";
//   late final TextEditingController controllerMontant;
//   late final TextEditingController controllerNom;
//   final int timeError = 2;

//   @override
//   void initState() {
//     controllerMontant = TextEditingController();
//     controllerNom = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controllerMontant.dispose();
//     controllerNom.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Compte compte = ModalRoute.of(context)!.settings.arguments as Compte;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           compte.nom,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: mapCouleur["theme"],
//       ),
//       backgroundColor: mapCouleur["background"],
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 10,
//                 ),
//                 alignment: Alignment.center,
//                 // width: MediaQuery.of(context).size.width * 0.45,
//                 child: Text(
//                   compte.solde.toString(),
//                   style: TextStyle(
//                       color: compte.solde < 0
//                           ? mapCouleur["negatif"]
//                           : mapCouleur["positif"],
//                       fontWeight: FontWeight.bold,
//                       fontSize: Checkbox.width * 3),
//                 ),
//               ),

//               Container(
//                 margin: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 10,
//                 ),
//                 decoration: BoxDecoration(
//                     color: mapCouleur["textfield"],
//                     borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 10,
//                 ),
//                 child: TextField(
//                   readOnly: readOnlyNomMontant,
//                   controller: controllerNom,
//                   decoration: const InputDecoration(
//                     labelText: "Entrez un nom d'opération",
//                   ),
//                 ),
//               ),

//               // const Divider(),

//               Container(
//                 margin: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 10,
//                 ),
//                 decoration: BoxDecoration(
//                     color: mapCouleur["textfield"],
//                     borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 10,
//                 ),
//                 child: TextField(
//                   readOnly: readOnlyNomMontant,
//                   controller: controllerMontant,
//                   decoration: const InputDecoration(
//                     labelText: "Entrez un montant",
//                   ),
//                 ),
//               ),

//               Divider(endIndent: 20, indent: 20, color: mapCouleur["theme"]),

//               IconButton(
//                 icon: const Icon(Icons.check),
//                 onPressed: () {
//                   final String nomAVerifier = controllerNom.text.trim();
//                   final String montantAVerfifier =
//                       controllerMontant.text.trim();

//                   if (!estDouble(montantAVerfifier)) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: const Text("Il faut saisir un nombre !"),
//                       backgroundColor: mapCouleur["erreur"],
//                       duration: Duration(seconds: timeError),
//                     ));
//                   } else if (strToDouble(montantAVerfifier) <= 0) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content:
//                           const Text("Le nombre doit être supérieur à 0 !"),
//                       backgroundColor: mapCouleur["erreur"],
//                       duration: Duration(seconds: timeError),
//                     ));
//                   } else if (!strValide(nomAVerifier)) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: const Text(
//                           "Le nom de l'opération n'est pas valide !"),
//                       backgroundColor: mapCouleur["erreur"],
//                       duration: Duration(seconds: timeError),
//                     ));
//                   } else if (!estDeposerOuRetirer(choix)) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text(
//                           "L'opération selectionnée doit être ${mapActionCompte.values.elementAt(0)} ou ${mapActionCompte.values.elementAt(1)} !"),
//                       backgroundColor: mapCouleur["erreur"],
//                       duration: Duration(seconds: timeError),
//                     ));
//                   } else {
//                     nom = strValide(nomAVerifier) ? nomAVerifier : "";
//                     setState(() {});
//                     montant = estDouble(montantAVerfifier)
//                         ? strToDouble(montantAVerfifier)
//                         : 0;
//                     miseAZero();
//                   }
//                 },
//               ),

//               Divider(endIndent: 20, indent: 20, color: mapCouleur["theme"]),

//               IconButton(
//                 icon: Icon(
//                   Icons.check_circle_outline_rounded,
//                   color: !readOnlyNomMontant
//                       ? mapCouleur["ligneSelect"]
//                       : mapCouleur["ligne"],
//                 ),
//                 onPressed: () => clickOnButton(choix, compte),
//               ),

//               Divider(endIndent: 20, indent: 20, color: mapCouleur["theme"]),

//               SizedBox(
//                 width: MediaQuery.of(context).size.width - 32,
//                 // height: MediaQuery.of(context).size.height - 10,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(10),
//                   onTap: () {
//                     if (estHistorique(choix)) {
//                       afficherHistorique(compte);
//                     } else if (estSupprimer(choix)) {
//                       supprimer(compte);
//                     }
//                   },
//                   child: Container(
//                     // margin: const EdgeInsets.symmetric(
//                     //   horizontal: 16,
//                     //   vertical: 10,
//                     // ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 10,
//                     ),
//                     // alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                         color: !readOnlyNomMontant
//                             ? mapCouleur["valider"]
//                             : mapCouleur["ligne"],
//                         borderRadius: BorderRadius.circular(10)),
//                     child: const Icon(
//                       Icons.check,
//                     ),
//                   ),
//                 ),
//               ),

//               Divider(endIndent: 20, indent: 20, color: mapCouleur["theme"]),

//               for (MapEntry<ActionCompte, String> entry
//                   in mapActionCompte.entries)
//                 LigneValue(
//                   value: entry.value,
//                   onClick: () => clickOnLigne(entry.key),
//                   isSelect: entry.key == choix,
//                 ),

//               Divider(endIndent: 20, indent: 20, color: mapCouleur["theme"]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Operation creerOperation(String nom, double montant, TypeOperation type) {
//     // créé un objet operation
//     return Operation(nom, montant, type);
//   }

//   void clickOnButton(ActionCompte entree, Compte compte) {
//     if (estDeposerOuRetirer(entree)) {
//       deposerOuRetirer(compte);
//     } else if (estHistorique(entree)) {
//       afficherHistorique(compte);
//     } else if (estSupprimer(entree)) {
//       supprimer(compte);
//     }
//   }

//   void clickOnLigne(ActionCompte entree) {
//     choix = entree;
//     readOnlyNomMontant =
//         choix == ActionCompte.retirer || choix == ActionCompte.deposer
//             ? false
//             : true;
//     if (readOnlyNomMontant == true) {
//       controllerNom.clear();
//       controllerMontant.clear();
//     }
//     setState(() {});
//   }

//   void miseAZero() {
//     nom = "";
//     montant = 0;
//     controllerNom.clear();
//     controllerMontant.clear();
//     setState(() {});
//   }

//   bool strValide(String chaine) {
//     // retourne vrai si la chaine ne comporte pas les exceptions du tableau
//     bool res = true;
//     final tableauException = <String>[
//       "",
//     ];
//     if (chaine.trim().isEmpty) {
//       res = false;
//     } else {
//       for (final element in chaine.split("")) {
//         if (tableauException.contains(element)) {
//           res = false;
//           break;
//         }
//       }
//     }
//     // print("strValide(\'$chaine\') : $res");
//     return res;
//   }

//   double strToDouble(String chaine) {
//     double res = 0;
//     if (estDouble(chaine)) {
//       res = double.parse(chaine);
//     }
//     return res;
//   }

//   bool estDouble(String chaine) {
//     bool res = true;
//     bool point = false;
//     final tableauDouble = <String>[
//       ".",
//     ];
//     if (chaine.isEmpty || !estDigit(chaine.replaceAll(".", ""))) {
//       res = false;
//     } else {
//       for (final element in chaine.split("")) {
//         if (element == tableauDouble[0]) {
//           if (point == true) {
//             res = false;
//             break;
//           }
//           point = true;
//           // point == true ? res = false : point = true;
//         }
//       }
//     }
//     // print("estDouble(\'$chaine\') : $res . point : $point");
//     return res;
//   }

//   bool estDigit(String chaine) {
//     bool res = true;
//     final tableauDigit = <String>[
//       "0",
//       "1",
//       "2",
//       "3",
//       "4",
//       "5",
//       "6",
//       "7",
//       "8",
//       "9",
//     ];
//     if (chaine.isEmpty) {
//       res = false;
//     } else {
//       for (final element in chaine.split("")) {
//         if (!tableauDigit.contains(element)) {
//           res = false;
//           break;
//         }
//       }
//     }
//     return res;
//   }

//   bool estDeposerOuRetirer(ActionCompte choix) {
//     // retourne true si deposer ou retirer
//     bool res = false;
//     if (choix == ActionCompte.deposer || choix == ActionCompte.retirer) {
//       res = true;
//     }
//     // print("deposerOuRetirer($choix) : $res");
//     return res;
//   }

//   void deposerOuRetirer(Compte compte) {
//     Operation operation = Operation(
//         nom,
//         montant,
//         choix == TypeOperation.depot
//             ? TypeOperation.depot
//             : TypeOperation.retrait);
//     if (choix == ActionCompte.deposer) {
//       compte.deposer(operation);
//     } else if (choix == ActionCompte.retirer) {
//       compte.retirer(operation);
//     }
//   }

//   bool estHistorique(ActionCompte choix) {
//     bool res = false;
//     res = choix == ActionCompte.historique;
//     return res;
//   }

//   void afficherHistorique(Compte compte) {
//     Navigator.pushNamed(
//       context,
//       Pages.historique,
//       arguments: compte,
//     );
//   }

//   bool estSupprimer(ActionCompte choix) {
//     bool res = false;
//     res = choix == ActionCompte.supprimer;
//     return res;
//   }

//   void supprimer(Compte compte) {
//     listeCompte.remove(compte);
//     Navigator.pop(context);
//     setState(() {});
//   }
// }
