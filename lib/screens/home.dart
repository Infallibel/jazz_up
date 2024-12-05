import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jazz_up/screens/youtube_player_screen.dart';
import 'package:jazz_up/utilities/constants.dart';
import '../utilities/dance_moves.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random _random = Random();
  late String firstMove;
  late String secondMove;
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
        firstMove = _getRandomMove();
      }
      if (!isSecondMoveLocked) {
        do {
          secondMove = _getRandomMove();
        } while (secondMove == firstMove);
      }
    });
  }

  String _getRandomMove() {
    return danceMoves.keys.elementAt(_random.nextInt(danceMoves.length));
  }

  void _showVideo(String moveName) {
    final timestamp = danceMoves[moveName];
    if (timestamp != null) {
      final url = "https://www.youtube.com/watch?v=jAIwJd2tQo0&t=$timestamp";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YouTubePlayerScreen(videoUrl: url),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video not available for this move.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPurple,
        title: const Center(
          child: Text(
            'Combine these dance moves',
            style: TextStyle(color: kColorBeige),
          ),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your first move: ',
                          style: TextStyle(color: kColorGrey),
                        ),
                        IconButton(
                          onPressed: () => _toggleLock(true),
                          icon: Icon(
                              isFirstMoveLocked
                                  ? Icons.lock_outlined
                                  : Icons.lock_open_outlined,
                              color:
                                  isFirstMoveLocked ? kColorRed : kColorGrey),
                        ),
                      ],
                    ),
                    Text(
                      firstMove,
                      style: const TextStyle(fontSize: 18, color: kColorGrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'See that move',
                          style: TextStyle(color: kColorGrey),
                        ),
                        IconButton(
                          onPressed: () => _showVideo(firstMove),
                          icon: const Icon(Icons.play_circle_outline,
                              color: kColorGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your second move: ',
                          style: TextStyle(color: kColorGrey),
                        ),
                        IconButton(
                          onPressed: () => _toggleLock(false),
                          icon: Icon(
                            isSecondMoveLocked
                                ? Icons.lock_outlined
                                : Icons.lock_open_outlined,
                            color: isSecondMoveLocked ? kColorRed : kColorGrey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      secondMove,
                      style: const TextStyle(fontSize: 18, color: kColorGrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'See that move',
                          style: TextStyle(color: kColorGrey),
                        ),
                        IconButton(
                          onPressed: () => _showVideo(secondMove),
                          icon: const Icon(Icons.play_circle_outline,
                              color: kColorGrey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorPurple,
                  ),
                  onPressed: _randomizeMoves,
                  child: const Text(
                    'Randomize Moves',
                    style: TextStyle(color: kColorBeige),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
