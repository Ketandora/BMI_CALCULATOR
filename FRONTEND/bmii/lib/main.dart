import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Entry point
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmiResult = 0.0;

  void calculateBMI() {
    if (weightController.text.isNotEmpty && heightController.text.isNotEmpty) {
      setState(() {
        double weight = double.parse(weightController.text);
        double height = double.parse(heightController.text);
        bmiResult = weight / (height * height);
      });
    }
  }

  String giveCategory() {
    if (bmiResult < 1) {
      return '';
    } else if (bmiResult < 18.5) {
      return 'Underweight';
    } else if (bmiResult <= 24.9) {
      return 'Normal Weight';
    } else if (bmiResult <= 34.9) {
      return 'Obesity Class I';
    } else if (bmiResult <= 39.9) {
      return 'Obesity Class II';
    } else {
      return 'Obesity Class III';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI CALCULATOR"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Weight (Kg)"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Height (m)"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateBMI,
                child: const Text("CALCULATE"),
              ),
              const SizedBox(height: 20),
              bmiResult > 0.0
                  ? Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text("Result"),
                    const SizedBox(height: 10),
                    Text(
                      bmiResult.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 35),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      giveCategory(),
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              )
                  : const SizedBox(),
              const SizedBox(height: 20),
              bmiResult > 0.9
                  ? ElevatedButton(
                onPressed: () {
                  setState(() {
                    weightController.clear();
                    heightController.clear();
                    bmiResult = 0.0;
                  });
                },
                child: const Text("CLEAR"),
              )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}//////correct one 18:39