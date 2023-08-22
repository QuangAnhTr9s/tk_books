import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tk_books/component/custom_slider.dart';

import '../shared/const/images.dart';

class AudioPlayerWidget extends StatefulWidget {
  final VoidCallback? onTapOpenSubTitle;
  final bool? isShowSub;

  const AudioPlayerWidget({Key? key, this.onTapOpenSubTitle, this.isShowSub})
      : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String urlAudio = 'https://luan.xyz/files/audio/coins.wav';
  late StreamSubscription _positionSubscription;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await audioPlayer.setAsset('assets/audio/a_loi.mp3');
    duration = audioPlayer.duration ?? Duration.zero;
    setState(() {});
    _positionSubscription = audioPlayer.positionStream.listen((event) {
      Duration temp = event;
      position = temp < duration ? temp : duration;
      if (temp == duration) {
        isPlaying = false;
        audioPlayer.stop();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  _playerAction() {
    if (position == duration) {
      //hết bài mà bấm nút chạy thì chạy lại từ đầu
      audioPlayer.seek(Duration.zero);
      audioPlayer.play();
      isPlaying = true;
    } else {
      if (isPlaying) {
        audioPlayer.pause();
        isPlaying = false;
      } else {
        audioPlayer.play();
        isPlaying = true;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSlider(
              duration: duration, position: position, audioPlayer: audioPlayer),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatTime(position),
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.57,
                  color: const Color(0xff8b90a7),
                ),
              ),
              Text(
                formatTime(duration),
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.57,
                  color: const Color(0xff8b90a7),
                ),
              ),
            ],
          ),
          //controll audio
          SizedBox(
            height: 108,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset(
                    MyImages.icRepeat,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 156,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 32,
                        width: 32,
                        child: Icon(
                          Icons.skip_previous_rounded,
                          color: Color(0xff4db5b6),
                          size: 32,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: GestureDetector(
                          onTap: () => _playerAction(),
                          child: Icon(
                            isPlaying ? Icons.pause_circle : Icons.play_circle,
                            color: const Color(0xff4db5b6),
                            size: 60,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                        width: 32,
                        child: Icon(
                          Icons.skip_next_rounded,
                          color: Color(0xff4db5b6),
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.onTapOpenSubTitle != null) {
                        widget.onTapOpenSubTitle!();
                      }
                    },
                    child: Image.asset(
                      widget.isShowSub!
                          ? MyImages.icSubtitleOpened
                          : MyImages.icSubtitle,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
