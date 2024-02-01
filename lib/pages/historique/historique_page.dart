import 'package:appli_compte/entities/class/class_abstract_compte.dart';
import 'package:appli_compte/entities/class/class_journalisation.dart';
import 'package:appli_compte/entities/map/map_couleur.dart';
import 'package:appli_compte/pages/action/widget/ligne_value.dart';
import 'package:flutter/material.dart';

class HistoriquePage extends StatefulWidget {
  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  @override
  Widget build(BuildContext context) {
    final Compte compte = ModalRoute.of(context)!.settings.arguments as Compte;
    final historique = Journalisation.getInstance(compte);
    String ligneSelect = "";

    return Scaffold(
      appBar: AppBar(
        title: Text(compte.toString()),
        backgroundColor: mapCouleur["theme"],
      ),
      backgroundColor: mapCouleur["background"],
      body:
          // ListView.builder(
          //   itemCount: historique.getOperation().length,
          //   itemBuilder: (context, index) {
          //     final operation = historique.getOperation()[index];
          //     return LigneValue(
          //       value: operation,
          //       onClick: () {
          //         ligneSelect = operation;
          //         setState(() {});
          //       },
          //       isSelect: operation == ligneSelect,
          //     );
          //   },
          // ),
          SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (historique.getOperation().isNotEmpty)
                // Solution non gardé
                // nous ne voulons pas l'ordre chronologique
                /*
                for (final operation in historique.getOperation())
                  LigneValue(
                    value: operation,
                    isSelect: operation == ligneSelect,
                    onClick: () {
                      ligneSelect = operation;
                      setState(() {});
                    },
                  ),
                  */
                for (int i = historique.getOperation().length - 1; i >= 0; i--)
                  LigneValue(
                    value: historique.getOperation()[i],
                    isSelect: historique.getOperation()[i] == ligneSelect,
                    onClick: () {
                      ligneSelect = historique.getOperation()[i];

                      setState(() {});
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
