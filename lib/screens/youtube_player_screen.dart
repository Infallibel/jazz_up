import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  final String videoUrl;

  const YouTubePlayerScreen({required this.videoUrl, super.key});

  @override
  YouTubePlayerScreenState createState() => YouTubePlayerScreenState();
}

class YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Extract the video ID and timestamp
    final uri = Uri.parse(widget.videoUrl);
    final videoId = uri.queryParameters['v'];
    final startAt = int.tryParse(uri.queryParameters['t'] ?? '0');

    if (videoId == null) {
      // Handle invalid video ID case
      throw ArgumentError('Invalid video URL');
    }

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        startAt: startAt ?? 0,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Seek the video by a certain number of seconds (positive or negative)
  void _seekBy(int seconds) {
    final currentPosition = _controller.value.position.inSeconds;
    final duration = _controller.metadata.duration.inSeconds;
    final newPosition = (currentPosition + seconds).clamp(0, duration);
    _controller.seekTo(Duration(seconds: newPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onDoubleTapDown: (details) {
          // Check where the double-tap happened: left or right side of the screen
          final screenWidth = MediaQuery.of(context).size.width;
          final tapPosition = details.localPosition.dx;

          if (tapPosition < screenWidth / 2) {
            // Left side: Skip 10 seconds backwards
            _seekBy(-10);
          } else {
            // Right side: Skip 10 seconds forwards
            _seekBy(10);
          }
        },
        child: Center(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
        ),
      ),
    );
  }
}
