import 'package:c1_flutter_tasbih_provider/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Compteur with ChangeNotifier, DiagnosticableTreeMixin {
  int nombreDeClics = 0;
  int limite = 33;
  Color couleur = Colors.blue;

  Color get getCouleur => couleur;

  int get count => nombreDeClics;

  void incrementer() {
    nombreDeClics++;
    if (nombreDeClics == 0) {
      couleur = Colors.blue;
    }

    ;
    if (nombreDeClics == limite) {
      //couleur = Colors.yellowAccent;
      nombreDeClics = 0;
      PageDaccueil.playMusic();
    }
    notifyListeners();
  }

  void updateLimite(int newLimite) {
    limite = newLimite;
    couleur = Colors.blue;
    notifyListeners();
  }

  void reset() {
    nombreDeClics = 0;
    couleur = Colors.blue;
    notifyListeners();
  }

  void changerCouleur() {}

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
    properties.add(ColorProperty('count', getCouleur));
  }
}
