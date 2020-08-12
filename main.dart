import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome(), debugShowCheckedModeBanner: false);
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int status;
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Music")),
        body: Container(
          color: Colors.grey,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.transparent,
                height: 500,
                margin: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () async {
                    status = await audioPlayer.play(
                        "https://raw.githubusercontent.com/pushkar02-op/flutter_assets/master/Sub Urban - Cradles.mp3");
                    if (status == 1) {
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: Card(
                      child: Image.network(
                          "https://raw.githubusercontent.com/pushkar02-op/flutter_assets/master/Cradles.jpg")
                      //Text('play Local'),
                      //elevation: 5,
                      ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(130, 30, 2, 6),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 20,
                child: Text(
                  "Sub Urban - Cradles",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                      padding: EdgeInsets.all(40),
                      icon: Icon(
                        Icons.stop,
                        size: 50,
                      ),
                      onPressed: () async {
                        status = await audioPlayer.stop();
                      }),
                  IconButton(
                      padding: EdgeInsets.all(50),
                      icon: Icon(
                        Icons.pause,
                        size: 50,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          audioPlayer.pause();

                          setState(() {
                            isPlaying = false;
                            audioPlayer.pause();
                          });
                        } else {
                          audioPlayer.resume();
                          setState(() {
                            isPlaying = true;
                          });
                        }
                      }),
                  IconButton(
                      padding: EdgeInsets.all(60),
                      icon: Icon(Icons.fast_forward, size: 50),
                      onPressed: () async {
                        status = await audioPlayer.seek(Duration(seconds: x));
                        x = x + 5;
                        print(x);
                        setState(() {
                          isPlaying = true;
                        });
                      })
                ],
              )
            ],
          ),
        ));
  }
}
