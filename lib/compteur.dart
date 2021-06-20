import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Compteur with ChangeNotifier, DiagnosticableTreeMixin {
  int nombreDeClics = 0;
  int get count => nombreDeClics;

  void incrementer() {
    nombreDeClics++;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}
