import 'dart:convert';
import 'dart:developer';

import 'package:agriconnect/models/models.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../uicomponents/uicomponents.dart';
import 'package:dio/dio.dart';



class SpeechPage extends StatefulWidget {
  SpeechPage({Key? key}) : super(key: key);

  @override
  _SpeechPageState createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  FlutterTts flutterTts = FlutterTts();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  List<Message> messages = [ Message(from: "AI Assistant", content: "Hi how can I help you")];
  ScrollController scrctl = ScrollController();
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    _initSpeech();
    
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    log((await flutterTts.getVoices).toString());
    await _speechToText.listen(onResult: _onSpeechResult, listenOptions: SpeechListenOptions(partialResults: false));
    _lastWords = '';
    setState(() {});
  }
  

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    // _lastWords = result.recognizedWords;
    addPrompt(result.recognizedWords);
  }

  void addPrompt(String text) async {
    setState(() {
      messages.add(Message(from: "You", content: text));
    });
    print("PROMPT ADDED "+ text);
    final response = await dio.post('http://10.100.55.216:3000/api/chatbot', data: '{"prompt": "$text"}');
    print(response.data);
    try {
      var dec = response.data;
      print(dec["response"]);
      String resp = dec['response'];
      
      if (resp.startsWith(":userresponse:")) {
        setState(() {
          messages.add(Message(from: "AI Assistant", content: resp.substring(14).trim()));
        });
        flutterTts.speak( resp.substring(14).trim());
      }
    }
    catch (e, t) {
      print(e);
      print(t);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrctl.animateTo(
        scrctl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    flutterTts.setVoice({"name": "en-in-x-ene-network", "locale": "en-IN"});
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Recognition'),
        // actions: [
        //   IconButton(onPressed: () {
        //     flutterTts.speak( "Hi, how can i help you today");
        //   }, icon: Icon(Icons.mic))
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.all(16),
            //   child: Text(
            //     'Recognized words:',
            //     style: TextStyle(fontSize: 20.0),
            //   ),
            // ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black38,
                ),
                margin: EdgeInsets.all(6),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: scrctl,
                        padding: const EdgeInsets.all(8),
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          Message currentMessage = messages[index];
                          return MessageItem(message: currentMessage);
                        }
                      ),
                    ),
                    MessageField(
                      onSend: (value) {
                        print("sent $value");
                        setState(() {
                          addPrompt(value);
                        });
                        
                      },
                      fieldprefixwidget: IconButton(
                        onPressed:
                            // If not yet listening for speech start, otherwise stop
                            _speechToText.isNotListening ? _startListening : _stopListening,
                        tooltip: 'Listen',
                        icon: Icon(
                          _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                          color: _speechToText.isNotListening ? null : Color.fromARGB(255, 0, 255, 26),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   child: Column(
            //     children: [
            //       Text(
            //         '$_lastWords',
            //         style: TextStyle(fontSize: 25, ),
            //       ),
            //       Text(
            //         // If listening is active show the recognized words
            //         _speechEnabled
            //                 ? 'Tap the microphone to start listening...'
            //                 : 'Speech not available',
            //       ),
                  
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: _speechToText.isNotListening ? null : Colors.green[300],
      //   onPressed:
      //       // If not yet listening for speech start, otherwise stop
      //       _speechToText.isNotListening ? _startListening : _stopListening,
      //   tooltip: 'Listen',
      //   child: Icon(
      //     _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
      //     color: _speechToText.isNotListening ? null : Colors.black,
      //   ),
      // ),
    );
  }
}