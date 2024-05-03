import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/Authtentication/signup.dart';
import 'package:sqlite_flutter_crud/JsonModels/users.dart';
import 'package:sqlite_flutter_crud/SQLite/sqlite.dart';
import 'package:sqlite_flutter_crud/Views/notes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;
  final db = DatabaseHelper();
  final formKey = GlobalKey<FormState>();

  //Now we should call this function in login button
  login(Users user) async {
    var response = await db.login(user);
    if (response == true) {
      //If login is correct, then goto notes
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Notes(user: user),
        ),
      );
    } else {
      //If not, true the bool value to show error message
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/login.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                //We put all our textfield to a form to be controlled and not allow as empty
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Username field
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple.withOpacity(.2),
                        ),
                        child: TextFormField(
                          controller: username,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Le nom d'utilisateur est requis";
                            } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                              return "Nom invalide, utilisez uniquement des alphabets";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person, color: Colors.blue),
                            border: InputBorder.none,
                            hintText: "Nom d'utilisateur",
                          ),
                        ),
                      ),
                      // Phone number field
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple.withOpacity(.2),
                        ),
                        child: TextFormField(
                          controller: phoneNumber,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Le numéro de téléphone est requis";
                            } else if (value.length != 8 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return "Numéro de téléphone invalide";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.phone, color: Colors.blue),
                            border: InputBorder.none,
                            hintText: "Numéro de téléphone",
                          ),
                        ),
                      ),
                      // Password field
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple.withOpacity(.2),
                        ),
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Le mot de passe est requis";
                            } else if (value.length < 5) {
                              return "Le mot de passe doit contenir au moins 5 caractères.";
                            }
                            return null;
                          },
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.lock, color: Colors.blue),
                            border: InputBorder.none,
                            hintText: "Mot de passe",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Afficher le message d'erreur sur le bouton Se connecter
                      if (isLoginTrue)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Vérifiez votre nom d'utilisateur, numéro de téléphone ou mot de passe",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      // Login button
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Create a Users instance with username, phone number, and password
                              var user = Users(
                                usrName: username.text.trim(),
                                usrPassword: password.text.trim(),
                                phoneNumber: phoneNumber.text.trim(),
                              );
                              // Pass the user to the login method
                              login(user);
                            }
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: const Text(
                            "Se connecter",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      // Sign up button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Vous n'avez pas de compte ?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUp()),
                              );
                            },
                            child: const Text("S'inscrire"),
                            style: TextButton.styleFrom(
                              primary: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
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
