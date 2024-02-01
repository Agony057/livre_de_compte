// import 'package:appli_compte/entities/class/class_compte_courant.dart';
// import 'package:appli_compte/entities/enum/enum_type_compte.dart';
// import 'package:appli_compte/entities/list/liste_compte.dart';
// import 'package:appli_compte/entities/class/class_abstract_compte.dart';
// import 'package:appli_compte/widgets/ligne.dart';
// import 'package:flutter/material.dart';
// import 'package:appli_compte/entities/map/map_couleur.dart';

// class HomePageTest extends StatefulWidget {
//   const HomePageTest({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<HomePageTest> createState() => _HomePageTestState();
// }

// class _HomePageTestState extends State<HomePageTest> {
//   Compte compteSelect = CompteCourant("", "", 0, TypeCompte.courant);

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the HomePageTest object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title), backgroundColor: mapCouleur['theme'],
//       ),
//       // debut drawer
//       //////////////////////////////////////////////////////////////////////////////////////
//       endDrawer: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.45,
//         child: Drawer(
//           child: ListView(
//             // Important: Remove any padding from the ListView.
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: mapCouleur['theme'],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Expanded(
//                       child: Text('Utilisateur'), // Utilisateur
//                     ),
//                     Expanded(
//                       child: Text(compteSelect.nom), // Nom du compte
//                     ),
//                     Expanded(
//                       child: Text(
//                         compteSelect.solde.toString(), // Solde
//                         style: TextStyle(
//                             color: compteSelect.solde < 0
//                                 ? mapCouleur['negatif']
//                                 : mapCouleur['positif']),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         compteSelect.type.name, // Découvert autorisé
//                         /// TODO faire un test pour savoir si instrance de compte courant
//                         /// si oui alors afficher decouvert
//                         /// si non decouvert = 0
//                         style: TextStyle(
//                           color: mapCouleur['orange'],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.add_box_rounded,
//                 ),
//                 title: const Text('Déposer'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.indeterminate_check_box_rounded,
//                 ),
//                 title: const Text('Retirer'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       //////////////////////////////////////////////////////////////////////////////////////
//       // fin drawer
//       body: SingleChildScrollView(
//         child: Center(
//           // Center is a layout widget. It takes a single child and positions it
//           // in the middle of the parent.
//           child: Column(
//             // Column is also a layout widget. It takes a list of children and
//             // arranges them vertically. By default, it sizes itself to fit its
//             // children horizontally, and tries to be as tall as its parent.
//             //
//             // Invoke "debug painting" (press "p" in the console, choose the
//             // "Toggle Debug Paint" action from the Flutter Inspector in Android
//             // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//             // to see the wireframe for each widget.
//             //
//             // Column has various properties to control how it sizes itself and
//             // how it positions its children. Here we use mainAxisAlignment to
//             // center the children vertically; the main axis here is the vertical
//             // axis because Columns are vertical (the cross axis would be
//             // horizontal).
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               for (final Compte compte in listeCompte)
//                 Ligne(
//                   // compte, onOption, isSelect: true,
//                   // compte, onOption(compte), isSelect: true,
//                   objet: compte, onOption: () => onOption(compte),
//                   isSelect: compte == compteSelect,
//                   // compte.nom,
//                   // compte.solde.toString(),
//                   // () => onOption(context),
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void onOption(Compte compte) {
//     compteSelect = compte;

//     setState(() {});
//   }
// }
