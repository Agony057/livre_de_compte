import 'package:appli_compte/entities/class/class_operation_mensuelle.dart';
import 'package:appli_compte/entities/enum/enum_type_operation.dart';
import 'package:appli_compte/entities/map/map_couleur.dart';

import 'package:flutter/material.dart';

class LigneOperationMensuelle extends StatefulWidget {
  final OperationMensuelle operation;
  TypeOperation typeOperation;
  final VoidCallback onClick;

  LigneOperationMensuelle({
    Key? key,
    required this.operation,
    required this.onClick,
    required this.typeOperation,
  }) : super(key: key);

  @override
  State<LigneOperationMensuelle> createState() =>
      _LigneOperationMensuelleState();
}

class _LigneOperationMensuelleState extends State<LigneOperationMensuelle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: InkWell(
        onTap: () => widget.onClick(),
        child: Container(
          decoration: BoxDecoration(
            color: widget.typeOperation == TypeOperation.depot
                ? mapCouleur["positif"]
                : mapCouleur['negatif'],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(widget.operation.nom),
              ),
              Expanded(
                child: Text("${widget.operation.montant.toStringAsFixed(2)} €"),
              ),
              Expanded(
                flex: 0,
                child: Text(widget.operation.duree < 0
                    ? "NoLimit"
                    : "${widget.operation.duree} mois"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
