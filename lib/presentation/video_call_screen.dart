import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  '17:41:48 until lesson start (Mon, 31 Otb 23 18:30)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white60),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Icon(
                  Icons.mic_rounded,
                  color: Colors.white60,
                )),
                Expanded(
                    child: Icon(
                  Icons.video_call,
                  color: Colors.white60,
                )),
                Expanded(
                    child: Icon(
                  Icons.screen_share_outlined,
                  color: Colors.white60,
                )),
                Expanded(
                    child: Icon(
                  Icons.emergency_recording_outlined,
                  color: Colors.white60,
                )),
                Expanded(
                    child: Icon(
                  Icons.front_hand,
                  color: Colors.white60,
                )),
                Expanded(
                    child: Icon(
                  Icons.fullscreen_outlined,
                  color: Colors.white60,
                )),
                Expanded(
                    child: Icon(
                  Icons.phone,
                  color: Colors.red,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
