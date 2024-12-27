import 'package:flutter/material.dart';

void main() {
  runApp(CGPACalculatorApp());
}

class CGPACalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CGPA Calculator',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: LoginScreen(),
    );
  }
}

// Login Screen
class LoginScreen extends StatelessWidget {
  final TextEditingController enrollmentController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: enrollmentController,
              decoration: InputDecoration(labelText: 'Enrollment'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to CGPA Calculator Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CGPACalculatorScreen()),
                );
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Sign-Up Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

// Sign-Up Screen
class SignupScreen extends StatelessWidget {
  final TextEditingController enrollmentController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: enrollmentController,
              decoration: InputDecoration(labelText: 'Enrollment'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform Sign-Up Logic
                Navigator.pop(context); // Navigate back to Login
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to Login
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// CGPA Calculator Screen
class CGPACalculatorScreen extends StatefulWidget {
  @override
  _CGPACalculatorScreenState createState() => _CGPACalculatorScreenState();
}

class _CGPACalculatorScreenState extends State<CGPACalculatorScreen> {
  final List<Map<String, dynamic>> courses = [];
  final TextEditingController courseController = TextEditingController();
  final TextEditingController creditController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  double calculateCGPA() {
    if (courses.isEmpty) return 0.0;

    double totalGradePoints = 0;
    double totalCredits = 0;

    for (var course in courses) {
      double gradePoint = _convertGradeToPoint(course['grade']);
      int credit = course['creditHours'];
      totalGradePoints += gradePoint * credit;
      totalCredits += credit;
    }

    return totalGradePoints / totalCredits;
  }

  double _convertGradeToPoint(String grade) {
    switch (grade.toUpperCase()) {
      case 'A+':
        return 4.0;
      case 'A':
        return 3.7;
      case 'B+':
        return 3.3;
      case 'B':
        return 3.0;
      case 'C+':
        return 2.7;
      case 'C':
        return 2.3;
      case 'D':
        return 2.0;
      case 'F':
        return 0.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CGPA Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: courseController,
              decoration: InputDecoration(labelText: 'Course Title'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: creditController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Credit Hours'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: gradeController,
                    decoration: InputDecoration(labelText: 'Grade (e.g., B+)'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (courseController.text.isNotEmpty &&
                        creditController.text.isNotEmpty &&
                        gradeController.text.isNotEmpty) {
                      setState(() {
                        courses.add({
                          'title': courseController.text,
                          'creditHours': int.parse(creditController.text),
                          'grade': gradeController.text,
                        });
                      });
                      courseController.clear();
                      creditController.clear();
                      gradeController.clear();
                    }
                  },
                  child: Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      courses.clear();
                    });
                  },
                  child: Text('Delete All'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return ListTile(
                    title: Text(course['title']),
                    subtitle: Text(
                        'Credit Hours: ${course['creditHours']}, Grade: ${course['grade']}'),
                  );
                },
              ),
            ),
            Text(
              'Your CGPA: ${calculateCGPA().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
