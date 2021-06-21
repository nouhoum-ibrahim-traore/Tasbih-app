import 'package:audioplayers/audio_cache.dart';
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PageDaccueil(title: "Compteur"));
  }
}

class PageDaccueil extends StatefulWidget {
  static var _audioPlayer = AudioPlayer();

  final String title;
  static var textEditingController = TextEditingController();

  static AudioPlayer audioPlayer = AudioPlayer();
  static AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  static String filePath = 'mp3Test.mp3';
  static AudioCache audioCache;

  const PageDaccueil({Key key, this.title}) : super(key: key);

  @override
  _PageDaccueilState createState() => _PageDaccueilState();

  static playMusic() async {
    await PageDaccueil.audioCache.play(PageDaccueil.filePath);
  }
}

class _PageDaccueilState extends State<PageDaccueil> {
  @override
  void initState() {
    super.initState();

    PageDaccueil.audioPlayer = AudioPlayer();
    PageDaccueil.audioCache = AudioCache(fixedPlayer: PageDaccueil.audioPlayer);

    PageDaccueil.audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        PageDaccueil.audioPlayerState = s;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 130,
          width: 130,
          child: FloatingActionButton(
            backgroundColor: context.watch<Compteur>().getCouleur,
            child: Icon(Icons.add),
            onPressed: () {
              context.read<Compteur>().incrementer();
            },
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
                      controller: PageDaccueil.textEditingController,
                      decoration: InputDecoration(hintText: 'Entrer la limite'),
                    ),
                  ),
                  RaisedButton(
                      color: Colors.blue,
                      child: Text('Valider'),
                      onPressed: () => context.read<Compteur>().updateLimite(
                          int.parse(PageDaccueil.textEditingController.text
                              .toString()))),
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
                  onPressed: () {
                    context.read<Compteur>().reset();
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

  @override
  void dispose() {
    PageDaccueil.audioPlayer.release();
    PageDaccueil.audioPlayer.dispose();
    PageDaccueil.audioCache.clearCache();
    super.dispose();
  }

  pauseMusic() async {
    await PageDaccueil.audioPlayer.pause();
  }
}
