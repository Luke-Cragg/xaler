class Question {
  final String question;
  final List<String> options;

  const Question({
    required this.question,
    required this.options,
  });
}

const List<Question> questions = [
  Question(question: "How are you feeling today?", options: [
    'Amazing',
    'Good',
    'Not Great',
    'Terrible',
  ]),
];
