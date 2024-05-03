import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/Authtentication/login.dart';
import 'package:sqlite_flutter_crud/JsonModels/users.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phoneNumber = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  InputDecoration buildInputDecoration(IconData icon, String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.deepPurple.withOpacity(.2), // Match the background color
      prefixIcon: Icon(icon, color: Colors.blue),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/y.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "S'inscrire",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: username,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Entrez votre nom !!";
                              } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                return "Nom invalide, utilisez uniquement des alphabets";
                              }
                              return null;
                            },
                            decoration: buildInputDecoration(Icons.person, "Nom"),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: phoneNumber,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Entrez votre numéro de téléphone !!";
                              } else if (value.length != 8 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return "Le numéro de téléphone doit être composé de 8 chiffres.";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: buildInputDecoration(Icons.phone, "Numéro de téléphone"),
                          ),
                          SizedBox(height: 10),

                          TextFormField(
                            controller: password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Entrez votre mot de passe !!";
                              } else if (value.length < 5) {
                                return "Le mot de passe doit contenir au moins 5 caractères.";
                              }
                              return null;
                            },
                            obscureText: !isVisible,
                            decoration: buildInputDecoration(Icons.lock, "Mot de passe"),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: confirmPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Entrez votre mot de passe !!";
                              } else if (password.text != confirmPassword.text) {
                                return "Les mots de passe ne correspondent pas";
                              }
                              return null;
                            },
                            obscureText: !isVisible,
                            decoration: buildInputDecoration(Icons.lock, "Confirmez le mot de passe"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final db = DatabaseHelper();
                            db.signup(Users(
                              usrName: username.text,
                              usrPassword: password.text,
                              phoneNumber: phoneNumber.text,
                            )).whenComplete(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            });
                          }
                        },
                        child: Text(
                          "Créer Compte",
                          style: TextStyle(color: Colors.blue), // Change text color to blue
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vous avez déjà un compte ? "),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text("Se connecter"),
                          style: TextButton.styleFrom(
                            primary: Colors.blue, // Set text color to blue
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
