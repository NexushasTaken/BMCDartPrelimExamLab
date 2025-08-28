import 'dart:io';

/// A function helper to get score from user
double get_score(String prompt, String errorString, double maxScore) {
  // print prompt with ':' as prefix
  print("${prompt}:");
  // Use stdout.write to print the '> ' without new line
  stdout.write("> ");

  String input = "";
  try {
    input = stdin.readLineSync()!;
    if (input.isEmpty) {
      throw errorString;
    }
  } catch (e) {
    print("error: ${e}");
    exit(1);
  }

  try {
    double value = double.tryParse(input)!;
    if (value > maxScore) {
      throw "your score exceeds ${maxScore}";
    }
    if (value == 0) {
      throw errorString;
    }
    return value;
  } catch (e) {
    print("error: ${e}");
    exit(1);
  }
}

/// Grade and Score Calculator
void main() {
  // declare constants
  const double passingGradeThreshold = 60.0;
  const double maxScore = 100.0;
  const double assignmentWeight = 0.2;
  const double midtermWeight = 0.3;
  const double finalExamWeight = 0.5;

  String studentName = "";
  try {
    // Get student name from user

    print("Enter your name:");
    // Use stdout.write to print the '> ' without new line
    stdout.write("> ");
    studentName = stdin.readLineSync()!;

    // check if student name is empty, then throw custom error message
    if (studentName.isEmpty) {
      throw "Enter your name!";
    }
  } catch (e) {
    print("error: ${e}");
    exit(1);
  }

  // get scores from user using get_score function
  double assignmentScore = get_score("Enter your assignment score", "enter valid assignment score!", maxScore);
  double midtermScore = get_score("Enter your midterm score", "enter valid midterm score!", maxScore);
  double finalExamScore = get_score("Enter your final exam score", "enter valid final exam score!", maxScore);

  // calculate scores and grade
  double totalWeightedScores = (assignmentScore * assignmentWeight + midtermScore * midtermWeight + finalExamScore * finalExamWeight);
  double finalGrade = totalWeightedScores;
  // a variable to store the status, either it's passed or failed.
  String passedStatus = "";

  // assign passedStatus variable with either passed or failed.
  if (finalGrade > passingGradeThreshold) {
    passedStatus = "Passed";
  } else {
    passedStatus = "Failed";
  }

  // Print results
  print("""
==Student Info==
Name: ${studentName}

==Scores==
Assignment: ${assignmentScore}
Midterm   : ${midtermScore}
Final Exam: ${finalExamScore}

Final Grade: ${finalGrade}

${passedStatus}
""");
}