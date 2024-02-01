import 'package:appli_compte/entities/class/class_abstract_compte.dart';
import 'package:appli_compte/entities/map/map_couleur.dart';
import 'package:flutter/material.dart';

class LigneCompte extends StatefulWidget {
  final Compte compte;

  final VoidCallback onClick;

  const LigneCompte({
    Key? key,
    required this.compte,
    required this.onClick,
  }) : super(key: key);

  @override
  State<LigneCompte> createState() => _LigneCompteState();
}

class _LigneCompteState extends State<LigneCompte> {
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
            color: mapCouleur['ligne'],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.compte.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Checkbox.width * 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
