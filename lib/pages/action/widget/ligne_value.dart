import 'package:appli_compte/entities/map/map_couleur.dart';
import 'package:flutter/material.dart';

class LigneValue extends StatefulWidget {
  final String value;
  bool isSelect;
  final VoidCallback onClick;

  LigneValue({
    Key? key,
    required this.value,
    required this.onClick,
    this.isSelect = false,
  }) : super(key: key);

  @override
  State<LigneValue> createState() => _LigneValueState();
}

class _LigneValueState extends State<LigneValue> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      child: InkWell(
        onTap: () => widget.onClick(),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelect
                ? mapCouleur["ligneSelect"]
                : mapCouleur['ligne'],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(widget.value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
