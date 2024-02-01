import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    late final user;

    /// TODO
    /// trouver une variable qui se transmettra de page en page
    /// user, banque, ...
    /// et comment le faire

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion de comptes"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("A faire")

            /// TODO
            /// faire quatre boutons et creer un widget pour une Ligne
          ],
        ),
      ),
    );
  }
}
