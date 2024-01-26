void shuffleAnswers(Map<String, dynamic> currentQuestion) {
  final correctAnswer = currentQuestion['correctAnswer'];
  final List<String> allAnswers = List<String>.from(currentQuestion['answers']);
  final List<String> wrongAnswers = List<String>.from(allAnswers);

  wrongAnswers.remove(correctAnswer);
  wrongAnswers.shuffle();
  wrongAnswers.removeLast();
  wrongAnswers.removeLast();

  allAnswers.clear();
  allAnswers.addAll(wrongAnswers);
  allAnswers.add(correctAnswer);

  currentQuestion['answers'] = allAnswers;
}
