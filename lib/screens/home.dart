import 'dart:math';
import 'package:flutter/material.dart';

import '../utilities/moves_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random _random = Random();
  late int firstMove;
  late int secondMove;
  bool isFirstMoveLocked = false;
  bool isSecondMoveLocked = false;

  @override
  void initState() {
    super.initState();
    _randomizeMoves();
  }

  void _toggleLock(bool isFirst) {
    setState(() {
      if (isFirst) {
        isFirstMoveLocked = !isFirstMoveLocked;
      } else {
        isSecondMoveLocked = !isSecondMoveLocked;
      }
    });
  }

  void _randomizeMoves() {
    setState(() {
      if (!isFirstMoveLocked) {
        firstMove = _random.nextInt(movesList.length);
      }
      if (!isSecondMoveLocked) {
        do {
          secondMove = _random.nextInt(movesList.length);
        } while (secondMove == firstMove);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your dance moves'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Your first move: '),
              IconButton(
                onPressed: () => _toggleLock(true),
                icon: Icon(
                  isFirstMoveLocked
                      ? Icons.lock_outlined
                      : Icons.lock_open_outlined,
                ),
              ),
            ],
          ),
          Text(
            movesList[firstMove],
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Your second move: '),
              IconButton(
                onPressed: () => _toggleLock(false),
                icon: Icon(
                  isSecondMoveLocked
                      ? Icons.lock_outlined
                      : Icons.lock_open_outlined,
                ),
              ),
            ],
          ),
          Text(
            movesList[secondMove],
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _randomizeMoves,
            child: const Text('Randomize Moves'),
          ),
        ],
      ),
    );
  }
}
