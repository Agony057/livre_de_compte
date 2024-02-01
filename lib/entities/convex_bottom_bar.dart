// import 'package:appli_compte/entities/convex_pages.dart';
// import 'package:appli_compte/entities/liste_compte.dart';
// import 'package:appli_compte/entities/map_couleur.dart';
// import 'package:appli_compte/entities/class_abstract_compte.dart';
// import 'package:appli_compte/widgets/ligne.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';

// class ConvexAppExample extends StatefulWidget {
//   const ConvexAppExample({super.key});

//   @override
//   ConvexAppExampleState createState() => ConvexAppExampleState();
// }

// class ConvexAppExampleState extends State<ConvexAppExample> {
//   final TabStyle _tabStyle = TabStyle.titled;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: convexPages.length,
//       // initialIndex: _kPages.length ~/ 2,
//       initialIndex: 0,
//       child: Scaffold(
//         body: Column(
//           children: [
//             // _buildStyleSelector(),
//             // const Divider(),
//             Expanded(
//               child: Column(
//                 children: [
//                   for (final Compte compte in listeCompte)
//                     Ligne(objet: compte, onOption: () => onOption(compte)
//                         // compte.nom,
//                         // compte.solde.toString(),
//                         // () => onOption(this.context),
//                         )
//                 ],
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: ConvexAppBar.badge(
//           // Optional badge argument: keys are tab indices, values can be
//           // String, IconData, Color or Widget.
//           // badge=
//           const <int, dynamic>{},
//           style: _tabStyle,
//           backgroundColor: mapCouleur['theme'],
//           // badgeColor: Colors.black,
//           items: <TabItem>[
//             for (final entry in convexPages.entries)
//               TabItem(icon: entry.value, title: entry.key),
//           ],
//           onTap: (int i) => print('click index=$i'),
//         ),
//       ),
//     );
//   }

// // archive setState
//   onOption(compte) {
//     print(compte);
//     setState(() {});
//   }
// // fin archive SetState

//   // Select style enum from dropdown menu:
//   // Widget _buildStyleSelector() {
//   //   final dropdown = DropdownButton<TabStyle>(
//   //     value: _tabStyle,
//   //     onChanged: (newStyle) {
//   //       if (newStyle != null) setState(() => _tabStyle = newStyle);
//   //     },
//   //     items: [
//   //       for (final style in TabStyle.values)
//   //         DropdownMenuItem(
//   //           value: style,
//   //           child: Text(style.toString()),
//   //         )
//   //     ],
//   //   );
//   //   return ListTile(
//   //     contentPadding: const EdgeInsets.all(8),
//   //     title: const Text('appbar style:'),
//   //     trailing: dropdown,
//   //   );
//   // }
// }
