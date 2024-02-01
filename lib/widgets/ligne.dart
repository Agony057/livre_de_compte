import 'package:appli_compte/entities/map/map_couleur.dart';
import 'package:appli_compte/route/pages.dart';
import 'package:flutter/material.dart';

class Ligne<T> extends StatefulWidget {
  final T objet;
  bool isSelect;
  final VoidCallback onOption;

  Ligne(
      {Key? key,
      required this.objet,
      required this.onOption,
      this.isSelect = false})
      : super(key: key);

  @override
  State<Ligne> createState() => _LigneState();
}

class _LigneState extends State<Ligne> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Pages.action,
          arguments: widget.objet,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelect
                ? mapCouleur['ligneSelect']
                : mapCouleur['ligne'],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(widget.objet.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
