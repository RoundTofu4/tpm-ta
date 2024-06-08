// profile_page.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('videos/videos1.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        // child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Nama: Rayhan Fairuz Sakha',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'NIM: 123210028',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Kelas: IF-B',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Hobi: Movies, Literature, Music, Games',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 35),
              // _controller.value.isInitialized
              //     ? AspectRatio(
              //   aspectRatio: _controller.value.aspectRatio,
              //   child: VideoPlayer(_controller),
              // )
              //     : Container(
              //   child: const CircularProgressIndicator(),
              // ),
              // const SizedBox(height: 20),
              // FloatingActionButton(
              //   onPressed: () {
              //     setState(() {
              //       _controller.value.isPlaying
              //           ? _controller.pause()
              //           : _controller.play();
              //     });
              //   },
              //   child: Icon(
              //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              //   ),
              // ),
              const SizedBox(height: 20),
              const Text(
                'Nama: Ignasius Satria Wicaksana',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'NIM: 123210020',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Kelas: IF-B',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Kata kata hari ini: Becik ketitik Ala rapopo',

                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        // ),
      ),
    );
  }
}
