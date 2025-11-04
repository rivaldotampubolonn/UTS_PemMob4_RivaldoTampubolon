import '../models/question_model.dart';
import '../config/app_constants.dart';

class QuestionsData {
  static final List<QuestionModel> _allQuestions = [
    // EASY QUESTIONS
    QuestionModel(
      id: '1',
      text: 'What is the central message of the Gospel?',
      options: ['God\'s love through Jesus Christ', 'Following rules perfectly', 'Personal enlightenment', 'Building kingdoms'],
      correctAnswer: 0,
      category: 'Core Gospel',
      difficulty: AppConstants.difficultyEasy,
      verse: 'John 3:16',
      explanation: 'The Gospel centers on God\'s love demonstrated through Jesus Christ.',
    ),
    QuestionModel(
      id: '2',
      text: 'What is grace in Christian teaching?',
      options: ['Earning God\'s favor', 'God\'s unmerited favor', 'A ritual', 'Perfection'],
      correctAnswer: 1,
      category: 'Salvation',
      difficulty: AppConstants.difficultyEasy,
      verse: 'Ephesians 2:8-9',
      explanation: 'Grace is God\'s unmerited favor - freely given, not earned.',
    ),
    QuestionModel(
      id: '3',
      text: 'What does "Trinity" describe?',
      options: ['Three gods', 'One God in three persons', 'Three stages', 'Three religions'],
      correctAnswer: 1,
      category: 'Doctrine',
      difficulty: AppConstants.difficultyEasy,
      verse: 'Matthew 28:19',
      explanation: 'Trinity: one God existing in three distinct persons.',
    ),
    QuestionModel(
      id: '4',
      text: 'What is the purpose of prayer?',
      options: ['Manipulate outcomes', 'Communication with God', 'Prove holiness', 'Obligation only'],
      correctAnswer: 1,
      category: 'Practices',
      difficulty: AppConstants.difficultyEasy,
      verse: 'Philippians 4:6',
      explanation: 'Prayer is communication and relationship with God.',
    ),

    // NORMAL QUESTIONS
    QuestionModel(
      id: '5',
      text: 'What is "justification"?',
      options: ['Making excuses', 'Declared righteous through faith', 'Being better', 'Achieving perfection'],
      correctAnswer: 1,
      category: 'Salvation',
      difficulty: AppConstants.difficultyNormal,
      verse: 'Romans 5:1',
      explanation: 'Justification is being declared righteous through faith in Christ.',
    ),
    QuestionModel(
      id: '6',
      text: 'What is "sanctification"?',
      options: ['Initial salvation', 'Growing in holiness', 'Declaring holy', 'Complete separation'],
      correctAnswer: 1,
      category: 'Growth',
      difficulty: AppConstants.difficultyNormal,
      verse: '1 Thessalonians 5:23',
      explanation: 'Sanctification is progressive growth in holiness.',
    ),
    QuestionModel(
      id: '7',
      text: 'Role of faith and works?',
      options: ['Works alone', 'Faith produces works', 'Neither matters', 'Works earn faith'],
      correctAnswer: 1,
      category: 'Salvation',
      difficulty: AppConstants.difficultyNormal,
      verse: 'James 2:17',
      explanation: 'Faith leads to salvation, which produces good works.',
    ),
    QuestionModel(
      id: '8',
      text: 'What is "redemption"?',
      options: ['Trading sins', 'Freed from sin\'s slavery', 'Social reform', 'Earning favor'],
      correctAnswer: 1,
      category: 'Salvation',
      difficulty: AppConstants.difficultyNormal,
      verse: 'Ephesians 1:7',
      explanation: 'Redemption means being freed from bondage through Christ.',
    ),

    // HARD QUESTIONS
    QuestionModel(
      id: '9',
      text: 'What is the "Hypostatic Union"?',
      options: ['Modalism', 'Christ\'s divine-human natures united', 'Arianism', 'Adoptionism'],
      correctAnswer: 1,
      category: 'Christology',
      difficulty: AppConstants.difficultyHard,
      verse: 'Colossians 2:9',
      explanation: 'Hypostatic Union: Christ\'s divine and human natures in one person.',
    ),
    QuestionModel(
      id: '10',
      text: 'What is "imago Dei"?',
      options: ['Religious icons', 'Humanity created in God\'s image', 'Christ\'s appearance', 'Angels'],
      correctAnswer: 1,
      category: 'Anthropology',
      difficulty: AppConstants.difficultyHard,
      verse: 'Genesis 1:27',
      explanation: 'Imago Dei: humanity reflects God\'s character and nature.',
    ),
  ];

  static List<QuestionModel> getAllQuestions() => List.from(_allQuestions);

  static List<QuestionModel> getQuestionsByDifficulty(String difficulty) {
    return _allQuestions.where((q) => q.difficulty == difficulty).toList();
  }
}