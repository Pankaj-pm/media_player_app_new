import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/media_provider.dart';
import 'package:media_player_app/video_play.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MediaPlayerProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  List<Audio> al = [
    Audio.network("https://pagalfree.com/musics/128-Ishq%20Jaisa%20Kuch%20-%20Fighter%20128%20Kbps.mp3",
        metas: Metas(
          title: "Ishq Jaisa Kuch",
          album: "Fighter",
          artist: "Vishal-Sheykhar, Shilpa Rao, Mellow D, Kumaar",
          image:
              MetasImage.network("https://pagalfree.com/images/128Ishq%20Jaisa%20Kuch%20-%20Fighter%20128%20Kbps.jpg"),
        )),
    Audio.network("https://pagalfree.com/musics/128-Banda%20-%20Dunki%20128%20Kbps.mp3",
        metas: Metas(
          title: "Banda",
          album: "Dunki",
          artist: "Pritam, Diljit Dosanjh, Kumaar",
          image: MetasImage.network("https://pagalfree.com/images/128Banda%20-%20Dunki%20128%20Kbps.jpg"),
        )),
    Audio.network("https://pagalfree.com/musics/128-O%20Maahi%20-%20Dunki%20128%20Kbps.mp3",
        metas: Metas(
          title: "O Maahi",
          album: "Fighter",
          artist: "Vishal-Sheykhar, Shilpa Rao, Mellow D, Kumaar",
          image: MetasImage.network("https://pagalfree.com/images/128O%20Maahi%20-%20Dunki%20128%20Kbps.jpg"),
        )),
    Audio.network("https://pagalfree.com/musics/128-Abrars%20Entry%20Jamal%20Kudu%20-%20Animal%20128%20Kbps.mp3",
        metas: Metas(
          title: "Abrars Entry Jamal Kudu",
          album: "Fighter",
          artist: "Vishal-Sheykhar, Shilpa Rao, Mellow D, Kumaar",
          image: MetasImage.network(
              "https://pagalfree.com/images/128Abrars%20Entry%20Jamal%20Kudu%20-%20Animal%20128%20Kbps.jpg"),
        )),
  ];

  @override
  void initState() {
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    assetsAudioPlayer.open(Playlist(audios: al), autoStart: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                print("sdfsdfsdfsdf");
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Videoplay(),
                //     ));
              },
              icon: Icon(Icons.video_call))
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TextButton(
            //     onPressed: () {
            //       assetsAudioPlayer.open(
            //         Audio("assets/jaan.mp3"),
            //         autoStart: false,
            //         showNotification: true,
            //       );
            //     },
            //     child: Text("man mari jaan")),
            // TextButton(
            //     onPressed: () {
            //       assetsAudioPlayer.open(
            //         Audio("assets/naach.mp3"),
            //         autoStart: false,
            //         showNotification: true,
            //       );
            //     },
            //     child: Text("nach meri jaan")),
            // TextButton(
            //     onPressed: () {
            //       assetsAudioPlayer.open(
            //         Audio.network(
            //             "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3"),
            //         autoStart: false,
            //         showNotification: true,
            //       );
            //     },
            //     child: Text("Network")),
            // TextButton(
            //     onPressed: () {
            //       assetsAudioPlayer.open(
            //         Audio.network("https://pagalfree.com/musics/128-Lutt%20Putt%20Gaya%20-%20Dunki%20128%20Kbps.mp3"),
            //         autoStart: false,
            //         showNotification: true,
            //       );
            //     },
            //     child: Text("Lutt put")),
            Expanded(
              child: ListView.builder(
                itemCount: al.length,
                itemBuilder: (context, index) {
                  var audio = al[index];
                  return ListTile(
                    title: Text(audio.metas.title ?? ""),
                  );
                },
              ),
            ),
            StreamBuilder<Playing?>(
                stream: assetsAudioPlayer.current,
                builder: (context, snapshot) {
                  var title = snapshot.data?.playlist.current.metas.title ?? "";
                  var album = snapshot.data?.playlist.current.metas.album ?? "";
                  var path = snapshot.data?.playlist.current.metas.image?.path ?? "";
                  return ListTile(
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.network(path),
                    ),
                    title: Text(title),
                    subtitle: Text(album),
                  );
                }),
            StreamBuilder<Duration>(
                stream: assetsAudioPlayer.currentPosition,
                builder: (context, snapshot) {
                  var sec = snapshot.data?.inSeconds ?? 0;
                  var min = snapshot.data?.inMinutes ?? 0;
                  return StreamBuilder<Playing?>(
                      stream: assetsAudioPlayer.current,
                      builder: (context, snapshot) {
                        var duration = snapshot.data?.audio.duration;
                        if (duration != null) {
                          return Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value: sec.toDouble(),
                                  max: (duration.inSeconds ?? 1).toDouble(),
                                  onChanged: (value) {
                                    print("value $value");
                                    assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
                                  },
                                ),
                              ),
                              Text("${min % 60}:${sec % 60}")
                            ],
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      assetsAudioPlayer.previous();
                    },
                    icon: Icon(Icons.skip_previous)),
                StreamBuilder<bool>(
                    stream: assetsAudioPlayer.isPlaying,
                    builder: (context, snapshot) {
                      var playing = snapshot.data ?? false;
                      return StreamBuilder<bool>(
                          stream: assetsAudioPlayer.isBuffering,
                          builder: (context, snapshot1) {
                            if (snapshot1.data ?? false) {
                              return SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              );
                            }
                            return IconButton(
                                onPressed: () {
                                  if (playing) {
                                    assetsAudioPlayer.pause();
                                  } else {
                                    assetsAudioPlayer.play();
                                  }
                                },
                                icon: Icon(playing ? Icons.pause : Icons.play_arrow));
                          });
                    }),
                IconButton(
                    onPressed: () {
                      assetsAudioPlayer.next();
                    },
                    icon: Icon(Icons.skip_next)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
