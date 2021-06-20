import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'compteur.dart';

// Dans la suite du cours montrer pourquoi on definit tous les providers a ce niveau
void main() => runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Compteur())],
      child: NotreApp(),
    ));

class NotreApp extends StatefulWidget {
  @override
  NotreAppState createState() {
    // TODO: implement createState
    return NotreAppState();
    throw UnimplementedError();
  }
}

class NotreAppState extends State<NotreApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: PageDaccueil(title: "Compteur"));
  }
}

class PageDaccueil extends StatelessWidget {
  final String title;

  const PageDaccueil({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => context.read<Compteur>().incrementer(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Le nombre de fois que vous avez cliqué: '),
            Text(context.watch<Compteur>().nombreDeClics.toString())
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
