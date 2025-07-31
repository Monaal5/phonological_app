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
  int _wrongAnswers = 0;
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
    _wrongAnswers = 0; // Reset wrong answers
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
  }

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
        _wrongAnswers++; // Increment wrong answers
        _waitingForMic = true;
        _isListening = false;
      });
      _updateAvatarTitle("wrong");
      await _speak(_feedbackMessage);
      await Future.delayed(const Duration(milliseconds: 2000)); // Brief pause
      _nextQuestion(); // Move to next question even if wrong
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
        _wrongAnswers++; // Increment wrong answers
        _waitingForMic = true;
      });
      _updateAvatarTitle("wrong");
      await _speak(_feedbackMessage);
      await Future.delayed(const Duration(milliseconds: 2000)); // Brief pause
      _textController.clear();
      _nextQuestion(); // Move to next question even if wrong
    }
  }

  void _showResults() {
    final score = (_correctAnswers / questions.length * 100).round();
    rd.insertDB(title, date, time, score, _correctAnswers, _wrongAnswers); // Pass both counts
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Test Complete!'),
        content: Text('Correct: $_correctAnswers\nWrong: $_wrongAnswers\nTotal: ${questions.length}\nScore: $score%'),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<Map>(
        value: _currentVoice,
        underline: const SizedBox(),
        items: _voices.map((voice) => DropdownMenuItem<Map>(
          value: voice,
          child: Text(
            voice['name'],
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        )).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _currentVoice = value;
              setVoice(_currentVoice!);
            });
          }
        },
      ),
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 32,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(28),
              ),
              child: FloatingActionButton(
                heroTag: 'audioBtn',
                onPressed: () async {
                  if (_currentQuestion.isNotEmpty) {
                    await _speak(_currentQuestion);
                  }
                },
                backgroundColor: Colors.deepPurple,
                elevation: 0,
                child: const Icon(Icons.volume_up, size: 28),
                tooltip: 'Repeat Question',
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(28),
              ),
              child: FloatingActionButton(
                heroTag: 'settingsBtn',
                backgroundColor: Colors.blueGrey,
                elevation: 0,
                child: const Icon(Icons.settings, size: 28),
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
          ),
        ],
      ),
      backgroundColor: const Color(0xFFE8F4F8),
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 191, 84, 51),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _speakerSelector(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Progress bar with improved styling
          Container(
            height: 6,
            child: LinearProgressIndicator(
              value: questions.isEmpty ? 0 : (_currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
            ),
          ),

          // Listening indicator - Moved lower to avoid overlap
          if (_isListening && _micCountdown > 0)
            Positioned(
              top: 80, // Changed from 20 to 80 to be below question counter
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.mic, color: Colors.redAccent, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          ' ${_micCountdown}s',
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${_forceListenWindow - _micCountdown + 1}/${_forceListenWindow}s',
                          style: const TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'Listening...',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Question counter with better styling
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Question ${_currentQuestionIndex + 1} of ${questions.length}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: Column(
                    children: [
                      // Avatar section with proper height
                      Container(
                        height: screenHeight * 0.25, // Reduced for better balance
                        width: double.infinity,
                        child: Avatar(title: _currentAvatarTitle),
                      ),

                      const SizedBox(height: 16), // Reduced gap

                      // Question text with better styling
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          _currentQuestion,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12), // Reduced gap

                      // User answer display
                      if (_userAnswer.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue.withOpacity(0.3)),
                          ),
                          child: Text(
                            "You said: $_userAnswer",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // Feedback message
                      if (_feedbackMessage.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: _feedbackColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _feedbackColor.withOpacity(0.3)),
                          ),
                          child: Text(
                            _feedbackMessage,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _feedbackColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // Loading indicator
                      if (_isListening)
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                            strokeWidth: 4,
                          ),
                        ),

                      // Microphone button with better styling
                      if (_waitingForMic && !_useTextInput)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16), // Reduced gap
                          child: AvatarGlow(
                            animate: _isListening || _forceListening,
                            glowColor: Colors.deepOrangeAccent,
                            curve: Curves.fastOutSlowIn,
                            duration: Duration(milliseconds: _micCountdown > 0 ? _micCountdown * 1000 : 2000),
                            repeat: true,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.deepOrangeAccent.withOpacity(0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: FloatingActionButton(
                                heroTag: 'micGlow',
                                onPressed: _onMicPressed,
                                backgroundColor: Colors.deepOrangeAccent,
                                elevation: 0,
                                child: Icon(
                                  _isListening || _forceListening ? Icons.mic : Icons.mic_none,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Text input section
                      if (_waitingForMic && !_isListening && _useTextInput)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: _textController,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: 'Type your answer here...',
                                    hintStyle: TextStyle(color: Colors.grey[500]),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  onSubmitted: (value) => _onTextSubmitted(value),
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () => _onTextSubmitted(_textController.text),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                child: const Text(
                                  'Submit Answer',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Input method toggle with better styling - Always visible
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Input: ',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Switch(
                              value: _useTextInput,
                              onChanged: (value) {
                                setState(() {
                                  _useTextInput = value;
                                  _textController.clear();
                                });
                              },
                              activeColor: Colors.deepOrangeAccent,
                            ),
                            Text(
                              _useTextInput ? 'Text' : 'Voice',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Confetti animation
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