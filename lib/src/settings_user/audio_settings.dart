import 'package:flutter/material.dart';
import 'package:sw1/src/settings_user/preferencias_usuario.dart';
import 'package:sw1/src/widget/menu_widget.dart';
import 'package:text_to_speech/text_to_speech.dart';

class AudioSettings extends StatefulWidget {
  static final String routeName = 'audio';
  @override
  _AudioSettingsState createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  final prefs = new PreferenciasUsuario();

  TextToSpeech tts = TextToSpeech();

  String text = 'Enter some text here...';
  late double volume = 1; // Range: 0-1
  late double rate; // Range: 0-2
  late double pitch; // Range: 0-2

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = text;
    volume = prefs.volume;
    rate = prefs.rate;
    pitch = prefs.pitch;
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = AudioSettings.routeName;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Audio-Bot'),
      ),
      drawer: MenuWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: textEditingController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter some text here...'),
                  onChanged: (String newText) {
                    setState(() {
                      text = newText;
                    });
                  },
                  //onSubmitted: textEditingController.clear(),
                ),
                Row(
                  children: <Widget>[
                    const Text('Volume'),
                    Expanded(
                      child: Slider(
                        value: volume,
                        min: 0,
                        max: 1,
                        label: volume.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            volume = value;
                          });
                        },
                      ),
                    ),
                    Text('(${volume.toStringAsFixed(2)})'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Text('Rate'),
                    Expanded(
                      child: Slider(
                        value: rate,
                        min: 0,
                        max: 2,
                        label: rate.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            rate = value;
                          });
                        },
                      ),
                    ),
                    Text('(${rate.toStringAsFixed(2)})'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Text('Pitch'),
                    Expanded(
                      child: Slider(
                        value: pitch,
                        min: 0,
                        max: 2,
                        label: pitch.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            pitch = value;
                          });
                        },
                      ),
                    ),
                    Text('(${pitch.toStringAsFixed(2)})'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          child: const Text('Stop'),
                          onPressed: () {
                            tts.stop();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: ElevatedButton(
                        child: const Text('Speak'),
                        onPressed: () {
                          speak();
                        },
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void speak() {
    tts.setVolume(volume);
    tts.setRate(rate);
    tts.setLanguage('es-ES');
    tts.setPitch(pitch);
    tts.speak(text);
    prefs.rate = rate;
    prefs.pitch = pitch;
    prefs.volume = volume;
  }
}
