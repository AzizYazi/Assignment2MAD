import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class Fruit {
  final String name;
  final String imagePath;

  Fruit({required this.name, required this.imagePath});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Fruit> fruits = [
      Fruit(name: 'Apple', imagePath: 'images/apple.jpg'),
      Fruit(name: 'Orange', imagePath: 'images/orange.jpg'),
      Fruit(name: 'Rambutan', imagePath: 'images/rambutan.jpg'),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Assign(fruits: fruits),
    );
  }
}

class Assign extends StatefulWidget {
  final List<Fruit> fruits;

  const Assign({Key? key, required this.fruits}) : super(key: key);

  @override
  _AssignState createState() => _AssignState();
}

class _AssignState extends State<Assign> {
  String? choice;
  String? randomImage;

  void displayChoice() {
    setState(() {
      Fruit? selectedFruit = widget.fruits.firstWhere(
        (fruit) => fruit.name.toLowerCase() == choice?.toLowerCase(),
        orElse: () => Fruit(name: '', imagePath: ''),
      );
      randomImage =
          selectedFruit.name.isNotEmpty ? selectedFruit.imagePath : null;
    });
  }

  void feelingLucky() {
    setState(() {
      final random = Random();
      final randomIndex = random.nextInt(widget.fruits.length);
      randomImage = widget.fruits[randomIndex].imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 229, 148),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0, // No shadow
        backgroundColor: Color.fromARGB(255, 69, 28, 25),
        title: Text(
          "Fruit Chooser",
          style: TextStyle(fontSize: 35),
        ),
      ),
      body: Column(
        children: [
          // Text input
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter fruit name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  choice = value;
                });
              },
            ),
          ),

          SizedBox(height: 30),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    displayChoice();
                  },
                  child: Text('Display Choice'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    feelingLucky();
                  },
                  child: Text('I\'m feeling Lucky'),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          if (randomImage != null)
            Image.asset(
              randomImage!,
              width: 200,
              height: 200,
            ),
        ],
      ),
    );
  }
}
