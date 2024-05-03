import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart' as MyDrawerWidget;
import 'commande.dart';

void main() {
  runApp(MenuPage());
}

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Composer votre tacos',
      home: TacosOrderPage(),
    );
  }
}

class TacosOrderPage extends StatefulWidget {
  const TacosOrderPage({Key? key}) : super(key: key);

  @override
  _TacosOrderPageState createState() => _TacosOrderPageState();
}

class _TacosOrderPageState extends State<TacosOrderPage> {
  final _tacosOrderFormKey = GlobalKey<FormState>();
  final _nbrTacosController = TextEditingController();
  bool _choixExtra = false;
  bool _choixBoi = false;
  double _prixTotal = 0;
  String _prixTotalString = '0.00';
  String? _selectedViande;
  double _tailleTacos = 0;
  Map<String, bool> _selectedSauces = {
    'Harissa': true,
    'Algerienne': false,
    'Barbecue': false,
    'Mayonnaise': false,
  };

  @override
  void dispose() {
    _nbrTacosController.dispose();
    super.dispose();
  }

  void _updatePrixTotal() {
    setState(() {
      int nbrTacos = int.tryParse(_nbrTacosController.text) ?? 0;
      _prixTotal = _tailleTacos * nbrTacos;

      if (_choixExtra) {
        _prixTotal += 1.5 * nbrTacos;
      }

      if (_choixBoi) {
        _prixTotal += 2 * nbrTacos;
      }

      _prixTotalString = _prixTotal.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menus"),
      ),
      drawer: MyDrawerWidget.MyDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _tacosOrderFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Nombre de Tacos :',
                      style: TextStyle(
                        color: Colors.blue, // Couleur bleue
                      ),
                    ),
                    SizedBox(width: 10), // Espacement entre le texte et le champ de texte
                    Expanded(
                      child: TextFormField(
                        controller: _nbrTacosController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le nombre de tacos.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Choix de viande :',
                  style: TextStyle(
                    color: Colors.blue, // Couleur bleue
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedViande,
                  items: [
                    DropdownMenuItem(
                      child: Text('Cordon Bleu'),
                      value: 'Cordon Bleu',
                    ),
                    DropdownMenuItem(
                      child: Text('Escaloppe Grillé'),
                      value: 'Escaloppe Grillé',
                    ),
                    DropdownMenuItem(
                      child: Text('Escaloppe Panné'),
                      value: 'Escaloppe Panné',
                    ),
                    DropdownMenuItem(
                      child: Text('Viande Hachée'),
                      value: 'Viande Hachée',
                    ),
                    DropdownMenuItem(
                      child: Text('Chawarma'),
                      value: 'Chawarma',
                    ),
                    DropdownMenuItem(
                      child: Text('Végétarien'),
                      value: 'Végétarien',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedViande = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Choix des supplémentaires :',
                  style: TextStyle(
                    color: Colors.blue, // Couleur bleue
                  ),
                ),
                Row(
                  children: [
                    _buildCheckbox(_choixBoi,'Boisson (+2 DT)'),
                    _buildCheckbox(_choixExtra, 'Extra Frite (+1.5 DT)'),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Taille de Tacos:',
                  style: TextStyle(
                    color: Colors.blue, // Couleur bleue
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        _buildRadioButton(6.0, 'M (6 DT)'),
                        _buildRadioButton(7.0, 'L (7 DT)'),
                      ],
                    ),
                    SizedBox(width: 20), // Espacement entre les colonnes
                    Column(
                      children: [
                        _buildRadioButton(9.0, 'XL (9 DT)'),
                        _buildRadioButton(12.0, 'XXL (12 DT)'),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Text(
                  'Choix des sauces :',
                  style: TextStyle(
                    color: Colors.blue, // Couleur bleue
                  ),
                ),
                Column(
                  children: _buildSauceCheckboxes(),
                ),
                SizedBox(height: 20),
                Text(
                  'Prix de la livraison : 4.00 DT',
                  style: TextStyle(
                    color: Colors.blue, // Couleur bleue
                  ),
                ),

                Text(
                  'Prix de tacos : $_prixTotalString DT',
                  style: TextStyle(
                    color: Colors.blue, // Couleur bleue
                  ),
                ),


                Text(
                  'Prix total de la commande : ${(double.parse(_prixTotalString) + 4.00).toString()} DT',
                  style: TextStyle(
                    color: Colors.blue, // Couleur bleue
                  ),
                ),


                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_tacosOrderFormKey.currentState!.validate()) {
                          _updatePrixTotal();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SecondPage(data: _getFormData()),
                            ),
                          );
                        }
                      },
                      child: Text('Valider Achat'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getFormData() {
    return {
      'nbr': int.tryParse(_nbrTacosController.text) ?? 0,
      'pr': _prixTotalString,
      'choix_extra': _choixExtra,
      'choix_boi': _choixBoi,
      'viande': _selectedViande ?? '',
      'taille': _tailleTacos.toString(), // Convertir en String pour la compatibilité avec le type de données dans la classe SecondPage
      'sauces': _selectedSauces,
    };
  }

  List<Widget> _buildSauceCheckboxes() {
    List<Widget> sauceCheckboxes = [];
    _selectedSauces.forEach((sauce, isSelected) {
      sauceCheckboxes.add(
        Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (val) {
                setState(() {
                  _selectedSauces[sauce] = val!;
                });
              },
            ),
            Text(sauce),
          ],
        ),
      );
    });
    return sauceCheckboxes;
  }

  Widget _buildRadioButton(double value, String title) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _tailleTacos,
          onChanged: (val) {
            setState(() {
              _tailleTacos = val as double;
              _updatePrixTotal();
            });
          },
        ),
        Text(title),
      ],
    );
  }

  Widget _buildCheckbox(bool value, String title) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (val) {
            setState(() {
              if(title.contains('Boisson')) {
                _choixBoi = val!;
              } else {
                _choixExtra = val!;
              }
              _updatePrixTotal();
            });
          },
        ),
        Text(title),
      ],
    );
  }
}




class SecondPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const SecondPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int nbrTacos = data['nbr'];
    final double pr = double.parse(data['pr']);
    final double updatedPr = pr + 4.00;
    final String updatedPrString = updatedPr.toString();
    final bool choixExtra = data['choix_extra'];
    final bool choixBoi = data['choix_boi'];
    final String viande = data['viande'];
    final String taille = data['taille']; // Changer le type de données en String
    final Map<String, bool> sauces = data['sauces'];

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
        title: Text('Confirmation de commande'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Nombre de Tacos: ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('$nbrTacos', style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(width: 20), // Espacement entre chaque paire de texte
            Row(
              children: [
                Text('Prix: ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('$updatedPrString DT', style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(width: 20),
            Row(
              children: [
                Text('Viande: ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('$viande', style: TextStyle(color: Colors.black)),
              ],
            ),

            SizedBox(width: 20),
            Row(
              children: [
                Text('Choix supplémentaires: ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('$choixSupplementaires', style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(width: 20),
            Row(
              children: [
                Text('Sauces sélectionnées: ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                Text('$saucesSelected', style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmation de commande'),
                          content: Text('Votre commande a été confirmée avec succès!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommandePage(commandeData: data),
                                  ),
                                );
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Confirmer Commande'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Retour'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
