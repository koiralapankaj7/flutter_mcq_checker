class Student {
  // Primary key
  final int id;
  // Student name
  final String name;
  // Answers provided by student <questionNo, answer>
  final Map<int, String> studentAnswers;

  Student(this.id, this.name, this.studentAnswers);
}
