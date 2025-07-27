import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:test_app/settings_screen.dart';
import 'question_answer.dart';
import 'result_db.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class TestPage extends StatefulWidget {
  final String title;
  const TestPage({super.key, required this.title});

  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  bool _showCorrectAnimation = false;
  final Duration _animationDuration = const Duration(seconds: 2);
  double _speechRate = 0.5;
  List<Map> _voices = [];
  Map? _currentVoice;
  late List<Question> questions;
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final TextEditingController _textController = TextEditingController();
  String _currentQuestion = '';
  String _userAnswer = '';
  String _feedbackMessage = '';
  Color _feedbackColor = Colors.transparent;
  bool _isListening = false;
  bool _waitingForMic = false;
  bool _useTextInput = false;
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  String _currentAvatarTitle = 'ask';
  bool _speechInitialized = false;
  String title = '';
  ResultDataBase rd = ResultDataBase();
  DateTime now = DateTime.now();
  String date = '';
  String time = '';
  int _micCountdown = 0;
  Timer? _micTimer;
  Timer? _forceListenTimer;
  bool _forceListening = false;
  int _forceListenWindow = 7;
  String _finalRecognizedWords = '';

  @override
  void initState() {
    super.initState();
    _loadSpeechRate();
    title = widget.title;
    date = DateFormat('dd-MM-yyyy').format(now);
    time = DateFormat('HH:mm:ss').format(now);

    if (title == 'Rhyming') {
      questions = buildRhymingQuestions();
    } else if (title == 'Syllables') {
      questions = buildSyllableQuestions();
    } else if (title == 'MiddleSound') {
      questions = buildMiddleSoundQuestions();
    } else if (title == 'FinalSound') {
      questions = buildFinalSoundQuestions();
    } else if (title == 'Segmenting') {
      questions = buildSegmentQuestions();
    } else if (title == 'Blending') {
      questions = buildBlendingQuestions();
    } else if (title == 'InitialSound') {
      questions = buildInitialSoundQuestions();
    } else {
      questions = [];
    }

    _initialize();
    _initializeSpeech();
    _testSpeechRecognition();
    _startTest();
  }

  Future<void> _loadSpeechRate() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _speechRate = prefs.getDouble('speech_rate') ?? 0.5;
    });
    await _flutterTts.setSpeechRate(_speechRate);
  }

  void setVoice(Map voice) {
    _flutterTts.setVoice({
      'name': voice['name'],
      'locale': voice['locale'],
    });
  }

  Future<void> _initialize() async {
    await rd.createDB();
    await _flutterTts.setSpeechRate(_speechRate);
    _flutterTts.getVoices.then((data) {
      try {
        _voices = List<Map>.from(data);
        setState(() {
          _voices = _voices.where((_voice) => _voice['name'].contains('en')).toList();
            if (_currentVoice == null && _voices.isNotEmpty) {
      _currentVoice = _voices.first;
      setVoice(_currentVoice!);
    }
        });
      } catch (e) {
        print('Error getting voices: $e');
      }
    });
  }

  Future<void> _initializeSpeech() async {
    try {
      _speechInitialized = await _speech.initialize(
        onStatus: (status) {
          print('Speech status: $status');
          if (status == 'done' || status == 'notListening') {
            setState(() => _isListening = false);
          }
        },
        onError: (error) {
          print('Speech error: $error');
          setState(() => _isListening = false);
        },
      );
    } catch (e) {
      print('Speech initialization error: $e');
      _speechInitialized = false;
    }
  }

  Future<void> _testSpeechRecognition() async {
    bool available = await _speech.initialize();
    print('Speech available: $available');
  }

  void _updateAvatarTitle(String newTitle) {
    if (_currentAvatarTitle != newTitle) {
      setState(() {
        _currentAvatarTitle = newTitle;
      });
    }
  }

 void _startTest() async {
  _updateAvatarTitle('ask');
  _currentQuestionIndex = 0;
  _correctAnswers = 0;
  _userAnswer = '';
  _feedbackMessage = '';
  _feedbackColor = Colors.transparent;

  setState(() {
    _currentQuestion = questions[0].question;
    _waitingForMic = true;
  });

   WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _speak(_currentQuestion);
      setState(() {
        _waitingForMic = true;
      });
    });

  setState(() {
    _waitingForMic = true; 
}

  );}

  Future<void> _speak(String text) async {
     if (_currentVoice == null && _voices.isNotEmpty) {
    _currentVoice = _voices.first;
    setVoice(_currentVoice!);
  }
    await _flutterTts.setSpeechRate(_speechRate);
    await _flutterTts.speak(text);
    await _flutterTts.awaitSpeakCompletion(true);
  }

  Future<String> _forceListen() async {
    _finalRecognizedWords = '';
    _forceListening = true;
    int elapsed = 0;

    _forceListenTimer?.cancel();
    _forceListenTimer = Timer(Duration(seconds: _forceListenWindow), () {
      _forceListening = false;
      _speech.stop();
    });

    while (_forceListening) {
      await _speech.listen(
        localeId: 'en_US',
        listenFor: Duration(seconds: _forceListenWindow - elapsed),
        pauseFor: Duration(seconds: _forceListenWindow - elapsed),
        partialResults: false,
        listenMode: stt.ListenMode.confirmation,
        cancelOnError: false,
        onResult: (result) {
          if (result.finalResult) {
            _finalRecognizedWords = result.recognizedWords;
          }
        },
      );

      // Wait for the recognizer to stop
      while (_speech.isListening && _forceListening) {
        await Future.delayed(Duration(milliseconds: 100));
        elapsed += 0.1.round();
        if (elapsed >= _forceListenWindow) break;
      }

      if (!_forceListening) break;
      // If recognizer stopped early, restart unless time is up
      if (elapsed < _forceListenWindow) {
        continue;
      } else {
        break;
      }
    }

    _forceListenTimer?.cancel();
    _forceListening = false;
    return _finalRecognizedWords;
  }

  void _startMicCountdown() {
    _micTimer?.cancel();
    setState(() {
      _micCountdown = 7;
    });
    _micTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_micCountdown > 1) {
        setState(() {
          _micCountdown--;
        });
      } else {
        timer.cancel();
        setState(() {
          _micCountdown = 0;
        });
      }
    });
  }

  void _stopMicCountdown() {
    _micTimer?.cancel();
    setState(() {
      _micCountdown = 0;
    });
  }

  Future<void> _onMicPressed() async {
    _startMicCountdown();
    setState(() {
      _waitingForMic = false;
      _isListening = true;
    });

    final spoken = await _forceListen();
    _userAnswer = spoken;

    if (spoken.isEmpty) {
      setState(() {
        _feedbackMessage = "Didn't hear anything. Try again!";
        _feedbackColor = Colors.amber;
        _waitingForMic = true;
        _isListening = false;
      });
      await _speak("I didn't hear you. Let's try again.");
      return;
    }

    final correct = _checkAnswer(spoken);
    if (correct) {
      setState(() {
        _feedbackMessage = "Correct! Great job!";
        _feedbackColor = Colors.green;
        _showCorrectAnimation = true;
        _correctAnswers++;
        _waitingForMic = true;
         _isListening = false;
      });
      _updateAvatarTitle("correct");
      _speak(_feedbackMessage);
      await Future.delayed(_animationDuration);
      setState(() => _showCorrectAnimation = false);
      await Future.delayed(const Duration(milliseconds: 1000));
      _nextQuestion();
    } else {
      setState(() {
        _feedbackMessage = "Oops! Try again!";
        _feedbackColor = Colors.red;
        _waitingForMic = true;
        _isListening = false;
      });
      _updateAvatarTitle("wrong");
      await _speak(_feedbackMessage);
    }
  }

  bool _checkAnswer(String answer) {
    final q = questions[_currentQuestionIndex];
    final user = answer.trim().toLowerCase();
    if (q.allowAnyAnswer != null) {
      return q.allowAnyAnswer!.any((r) => user.contains(r.toLowerCase()));
    }
    return user.contains(q.answer.toLowerCase());
  }

  void _nextQuestion() async {
    _updateAvatarTitle('ask');
    _currentQuestionIndex++;
    _userAnswer = '';
    _feedbackMessage = '';
    _feedbackColor = Colors.transparent;

    if (_currentQuestionIndex < questions.length) {
      
        
       
        setState(() {
          _currentQuestion = questions[_currentQuestionIndex].question;
        _waitingForMic = true;
      });
       WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(const Duration(milliseconds: 500));
      await _speak(_currentQuestion);
      setState(() {
        _waitingForMic = true;
      });
    });
     
    } else {
      _showResults();
    }
  }

  Future<void> _onTextSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _waitingForMic = false;
      _userAnswer = text.trim();
    });

    final correct = _checkAnswer(text.trim());
    if (correct) {
      setState(() {
        _feedbackMessage = "Correct! Great job!";
        _feedbackColor = Colors.green;
        _showCorrectAnimation = true;
        _correctAnswers++;
      });
      _updateAvatarTitle("correct");
      _speak(_feedbackMessage);
      await Future.delayed(_animationDuration);
      setState(() => _showCorrectAnimation = false);
      await Future.delayed(const Duration(milliseconds: 1000));
      _textController.clear();
      _nextQuestion();
    } else {
      setState(() {
        _feedbackMessage = "Oops! Try again!";
        _feedbackColor = Colors.red;
        _waitingForMic = true;
      });
      _updateAvatarTitle("wrong");
      await _speak(_feedbackMessage);
      _textController.clear();
    }
  }

  void _showResults() {
    final score = (_correctAnswers / questions.length * 100).round();
    rd.insertDB(title, date, time, score);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Test Complete!'),
        content: Text('You got $_correctAnswers out of ${questions.length} correct!\nScore: $score%'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Back to Menu'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startTest();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _speakerSelector() {
    return DropdownButton<Map>(
      value: _currentVoice,
      items: _voices.map((voice) => DropdownMenuItem<Map>(
        value: voice,
        child: Text(voice['name']),
      )).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _currentVoice = value;
            setVoice(_currentVoice!);
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _micTimer?.cancel();
    _forceListenTimer?.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 30,

            child: FloatingActionButton(
              heroTag: 'audioBtn',
              onPressed: () async {
                if (_currentQuestion.isNotEmpty) {
                  await _speak(_currentQuestion);
                }
              },

              child: const Icon(Icons.volume_up),
              tooltip: 'Repeat Question',
            ),
          ),
          Positioned(
            bottom: 16,
            right: 12,
            child: FloatingActionButton(
              child: Icon(Icons.settings),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(currentRate: _speechRate, fromTestPage: true),
                  ),
                );
                // After returning from settings, reload the speech rate
                await _loadSpeechRate();
              },
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFD6E3ED),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 191, 84, 51),
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _speakerSelector(),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_isListening && _micCountdown > 0)
            Positioned(
              top: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.mic, color: Colors.redAccent, size: 22),
                        SizedBox(width: 6),
                        Text(
                          ' ${_micCountdown}s',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${_forceListenWindow - _micCountdown + 1}/${_forceListenWindow}s',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Listening...',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: questions.isEmpty ? 0 : (_currentQuestionIndex + 1) / questions.length,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                ),
                const SizedBox(height: 10),
                Text(
                  'Question ${_currentQuestionIndex + 1} of ${questions.length}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Avatar(title: _currentAvatarTitle),
                          Text(
                            _currentQuestion,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _userAnswer.isNotEmpty ? "You said: $_userAnswer" : '',
                            style: const TextStyle(fontSize: 20, color: Colors.black87),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _feedbackMessage,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: _feedbackColor,
                            ),
                          ),
                          if (_isListening)
                            const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                            ),
                        if (_waitingForMic && !_useTextInput)
         AvatarGlow(
    animate: _isListening || _forceListening,
    glowColor: Colors.deepOrangeAccent,
           curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: _micCountdown > 0 ? _micCountdown * 1000 : 2000),
    repeat: true,
    child: FloatingActionButton(
      heroTag: 'micGlow',
      onPressed: _onMicPressed,
      backgroundColor: Colors.deepOrangeAccent,
      child: Icon(
        _isListening || _forceListening ? Icons.mic : Icons.mic_none,
        color: Colors.white,
        size: 30,
      ),
    ),
  ),

                          if (_waitingForMic && !_isListening && _useTextInput)
                            Column(
                              children: [
                                TextField(
                                  controller: _textController,
                                  decoration: const InputDecoration(
                                    hintText: 'Type your answer here...',
                                    border: OutlineInputBorder(),
                                  ),
                                  onSubmitted: (value) => _onTextSubmitted(value),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () => _onTextSubmitted(_textController.text),
                                  child: const Text('Submit Answer'),
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Input Method: '),
                              Switch(
                                value: _useTextInput,
                                onChanged: (value) {
                                  setState(() {
                                    _useTextInput = value;
                                    _textController.clear();
                                  });
                                },
                              ),
                              Text(_useTextInput ? 'Text' : 'Voice'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_showCorrectAnimation)
            Positioned.fill(
              child: Center(
                child: Lottie.asset(
                  'assets/confetti.json',
                  repeat: false,
                  width: MediaQuery.of(context).size.height,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }
}