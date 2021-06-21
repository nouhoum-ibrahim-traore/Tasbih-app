import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
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
  static var _audioPlayer = AudioPlayer();

  final String title;
  static var textEditingController = TextEditingController();

  const PageDaccueil({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 130,
          width: 130,
          child: FloatingActionButton(
            backgroundColor: context.watch<Compteur>().getCouleur,
            child: Icon(Icons.add),
            onPressed: () => context.read<Compteur>().incrementer(),
          ),
        ),
      ),
      body: Center(
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: textEditingController,
                      decoration: InputDecoration(hintText: 'Entrer la limite'),
                    ),
                  ),
                  RaisedButton(
                      color: Colors.blue,
                      child: Text('Valider'),
                      onPressed: () => context.read<Compteur>().updateLimite(
                          int.parse(textEditingController.text.toString()))),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Text('Le nombre de fois que vous avez cliqué: ',
                  style: TextStyle(
                    fontSize: 17,
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                context.watch<Compteur>().nombreDeClics.toString(),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  // onPressed: () {
                  //   context.read<Compteur>().reset();
                  //   playLocalAsset();
                  // },
                  onPressed: () async {
                    //String filePath = await FilePicker.getFilePath();

                    await _audioPlayer.play("mp3Test.mp3", isLocal: true);

                    // if(status == 1){
                    //   setState(() {
                    //     isPlaying = true;
                    //   });
                    // }
                  },
                  child: Icon(Icons.refresh),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ))
            ],
          ),
        ]),
      ),
    );
    throw UnimplementedError();
  }

  Future<AudioPlayer> playLocalAsset() async {
    AudioCache cache = new AudioCache();
    //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
    //Just pass the file name only.
    return await cache.play("mp3Test.mp3");
  }
}
