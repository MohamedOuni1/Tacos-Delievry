import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart' as MyDrawerWidget;

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Support"),
    ),
    drawer: MyDrawerWidget.MyDrawer(),
      body: SupportContent(),
    );
  }
}

class SupportContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Besoin d\'aide ? Contactez notre équipe de support !',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue), // Changement de couleur en bleu
          ),

          SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.email,
                size: 30,
                color: Colors.blue, // Changement de couleur en bleu
              ),
              SizedBox(width: 10),
              Text(
                'mohamedouni926@gmail.com',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),


          SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.email,
                size: 30,
                color: Colors.blue, // Changement de couleur en bleu
              ),
              SizedBox(width: 10),
              Text(
                'mohamed.ouni@polytechnicien.tn',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),




          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 30,
                color: Colors.blue, // Changement de couleur en bleu
              ),
              SizedBox(width: 10),
              Text(
                'Téléphone: +216 55721070',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Horaires de support:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue), // Changement de couleur en bleu
          ),
          SizedBox(height: 10),
          Text(
            'Lundi - Vendredi: 9h00 - 18h00',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Samedi - Dimanche: 9h00 - 12h00',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
