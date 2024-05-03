import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart' as MyDrawerWidget;
void main() {
  runApp(const BestPage());
}

class BestPage extends StatelessWidget {
  const BestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tacos Chawarma',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blue.shade800, // changed text color
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Les sauces préférées : Harissa et mayonnaise ',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 18,
            ),
          ),
        ],
      ),
    );

    Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 32, // changed icon size
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600, // changed font weight
              color: color,
            ),
          ),
        ],
      );
    }



    Widget textSection = Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Oui, c\'est notre Tacos Chawarma préféré, qui laisse un souvenir gustatif inoubliable! N\'hésitez pas à appeler, acheminer ou partager votre expérience avec ce plat.',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black87, // changed text color
        ),
        textAlign: TextAlign.justify, // justify text alignment
      ),
    );
    Widget buttonSection = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.blue.shade800, Icons.food_bank, 'Healthy'),
          _buildButtonColumn(Colors.blue.shade800, Icons.timeline, '24/7'),
          _buildButtonColumn(Colors.blue.shade800, Icons.motorcycle, 'Rapide'),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Meilleur Vente"),
      ),
      drawer: MyDrawerWidget.MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Image.asset(
              "lib/assets/x.png",
              width: MediaQuery.of(context).size.width, // full width
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }
}