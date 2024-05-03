import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart' as MyDrawerWidget;

class CommandePage extends StatefulWidget {
  final Map<String, dynamic>? commandeData;

  const CommandePage({Key? key, required this.commandeData}) : super(key: key);

  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.commandeData == null || widget.commandeData!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Mes commandes"),
        ),
        drawer: MyDrawerWidget.MyDrawer(),
        body: Center(
          child: Text("Aucune commande disponible"),
        ),
      );
    }

    final int nbrTacos = widget.commandeData!['nbr'];
    final String pr = widget.commandeData!['pr'];
    final bool choixExtra = widget.commandeData!['choix_extra'];
    final bool choixBoi = widget.commandeData!['choix_boi'];
    final String viande = widget.commandeData!['viande'];
    final String taille = widget.commandeData!['taille'].toString();
    final Map<String, bool> sauces = widget.commandeData!['sauces'] ?? {};

    String choixSupplementaires = '';
    if (choixExtra && choixBoi) {
      choixSupplementaires = 'Extra Frite et Boisson';
    } else if (choixExtra) {
      choixSupplementaires = 'Extra Frite';
    } else if (choixBoi) {
      choixSupplementaires = 'Boisson';
    }

    String saucesSelected = '';
    sauces.forEach((sauce, isSelected) {
      if (isSelected) {
        if (saucesSelected.isNotEmpty) {
          saucesSelected += ', ';
        }
        saucesSelected += sauce;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes commandes"),
      ),
      drawer: MyDrawerWidget.MyDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column( // Changement ici pour afficher chaque paire de texte sur une nouvelle ligne
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Nombre de Tacos: ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('$nbrTacos', style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(height: 8), // Espacement entre chaque paire de texte
            Row(
              children: [
                Text('Prix: ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('$pr DT', style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Viande: ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('$viande', style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Choix supplémentaires: ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('$choixSupplementaires', style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Sauces sélectionnées: ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('$saucesSelected', style: TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
