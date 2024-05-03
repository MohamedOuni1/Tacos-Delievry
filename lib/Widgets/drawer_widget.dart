import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black45,
                  Colors.blueAccent,
                ],
              ),
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("lib/assets/u.png"),
                radius: 50,
              ),
            ),
          ),


          buildListTile(
            context,
            title: "Mon Compte",
            icon: Icons.person,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/notes");
            },
          ),


          buildListTile(
            context,
            title: "Meilleure Vente",
            icon: Icons.star_rate,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/best");
            },
          ),


          buildListTile(
            context,
            title: "Menus",
            icon: Icons.restaurant_menu,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/menu");
            },
          ),


          buildListTile(
            context,
            title: "Mes Commandes",
            icon: Icons.shopping_cart,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/commande");
            },
          ),


          buildListTile(
            context,
            title: "Support",
            icon: Icons.headset_mic,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/support");
            },
          ),
          buildListTile(
            context,
            title: "Déconnexion",
            icon: Icons.logout,
            onTap: () {
              Navigator.pushNamed(context, "/login");            },
          ),
        ],
      ),
    );
  }

  Widget buildListTile(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      leading: Icon(
        icon,
        color: Colors.blue, // Modifier la couleur en bleu
        size: 30,
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 20),
      onTap: onTap,
    );
  }

  Widget buildDivider() {
    return Divider(
      height: 0,
      thickness: 0.5,
      color: Colors.grey[400],
      indent: 20,
      endIndent: 20,
    );
  }
}
