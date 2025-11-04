import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/game_provider.dart';
import '../providers/question_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/answer_option.dart';
import '../widgets/custom_button.dart';
import '../widgets/question_card.dart';
import '../widgets/progress_bar.dart';
import '../config/app_constants.dart';

class QuizScreen extends StatefulWidget {
  final String difficulty;
  const QuizScreen({super.key, required this.difficulty});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _selectedAnswer;
  bool _hasAnswered = false;
  int _timeRemaining = AppConstants.timePerQuestionSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gameProvider = Provider.of<GameProvider>(context, listen: false);
      final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
      gameProvider.startGame(widget.difficulty);
      questionProvider.loadQuestions(widget.difficulty, AppConstants.questionsPerQuiz);
      _startTimer();
    });
  }

  void _startTimer() {
    _timeRemaining = AppConstants.timePerQuestionSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return timer.cancel();
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _handleTimeUp();
        }
      });
    });
  }

  void _handleTimeUp() {
    if (_hasAnswered) return;
    _timer?.cancel();
    setState(() => _hasAnswered = true);
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    gameProvider.answerQuestion(false, 0);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _proceedToNext();
    });
  }

  void _handleAnswerSelected(int index) {
    if (_hasAnswered) return;
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    final currentQuestion = questionProvider.currentQuestion;
    if (currentQuestion == null) return;
    _timer?.cancel();
    setState(() {
      _selectedAnswer = index;
      _hasAnswered = true;
    });
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    gameProvider.answerQuestion(currentQuestion.isCorrect(index), _timeRemaining);
  }

  void _proceedToNext() {
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    if (questionProvider.hasMoreQuestions) {
      setState(() {
        _selectedAnswer = null;
        _hasAnswered = false;
      });
      questionProvider.nextQuestion();
      _startTimer();
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    _timer?.cancel();
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final result = gameProvider.endGame(questionProvider.totalQuestions);
    userProvider.addGameResult(result.score);
    context.go('/result', extra: result);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(
      builder: (context, questionProvider, _) {
        final currentQuestion = questionProvider.currentQuestion;
        if (currentQuestion == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

        return Scaffold(
          appBar: AppBar(
            title: const Text('MISSION BRIEFING'),
            leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.go('/')),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _timeRemaining <= 10 ? Colors.red.withOpacity(0.2) : Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _timeRemaining <= 10 ? Colors.red : Theme.of(context).colorScheme.primary, width: 2),
                  ),
                  child: Text('$_timeRemaining s', style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold, color: _timeRemaining <= 10 ? Colors.red : Theme.of(context).colorScheme.primary)),
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Question ${questionProvider.currentIndex + 1}/${questionProvider.totalQuestions}', style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                              Consumer<GameProvider>(builder: (context, gameProvider, _) => Text('Score: ${gameProvider.currentScore}', style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary))),
                            ],
                          ),
                          const SizedBox(height: 12),
                          CustomProgressBar(progress: (questionProvider.currentIndex + 1) / questionProvider.totalQuestions),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  QuestionCard(question: currentQuestion.text, category: currentQuestion.category),
                  const SizedBox(height: 16),
                  ...List.generate(currentQuestion.options.length, (index) {
                    final letters = ['A', 'B', 'C', 'D'];
                    bool? isCorrect;
                    if (_hasAnswered) {
                      if (index == currentQuestion.correctAnswer) isCorrect = true;
                      if (index == _selectedAnswer && index != currentQuestion.correctAnswer) isCorrect = false;
                    }
                    return AnswerOption(
                      text: currentQuestion.options[index],
                      optionLetter: letters[index],
                      onTap: () => _handleAnswerSelected(index),
                      isSelected: _selectedAnswer == index,
                      isCorrect: isCorrect,
                      showResult: _hasAnswered,
                    );
                  }),
                  if (_hasAnswered) ...[
                    const SizedBox(height: 16),
                    if (currentQuestion.explanation != null)
                      Card(
                        color: (_selectedAnswer == currentQuestion.correctAnswer ? Colors.green : Colors.orange).withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Explanation', style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                              const SizedBox(height: 8),
                              Text(currentQuestion.explanation!, style: const TextStyle(fontFamily: 'Montserrat')),
                              if (currentQuestion.verse != null) ...[
                                const SizedBox(height: 8),
                                Text('📖 ${currentQuestion.verse}', style: TextStyle(fontFamily: 'Montserrat', fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.primary)),
                              ],
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: questionProvider.hasMoreQuestions ? 'NEXT QUESTION' : 'VIEW RESULTS',
                      onPressed: _proceedToNext,
                      icon: questionProvider.hasMoreQuestions ? Icons.arrow_forward : Icons.emoji_events,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}