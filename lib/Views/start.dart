import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/Authtentication/signup.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            "lib/assets/a.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 230),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Couleur de fond blanche
                ),
                child: Text(
                  'Commencer',
                  style: TextStyle(
                    color: Colors.blue, // Couleur du texte bleue
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
