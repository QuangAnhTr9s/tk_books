import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tk_books/component/back_button_appbar.dart';
import 'package:tk_books/shared/const/images.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  final DataSourceType dataSourceType;
  final String? title;
  final String? subTitle;
  final bool isShowSub;
  final VoidCallback? onTapOpenSubTitle;

  const VideoPlayerWidget({
    Key? key,
    required this.url,
    required this.dataSourceType,
    this.title,
    this.subTitle,
    this.isShowSub = false,
    this.onTapOpenSubTitle,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late FlickManager _flickManager;
  bool isSubtitleVisible = false;
  Duration? duration;
  bool isLooping = false;
  String? title;
  String? subTitle;
  bool showControls = false;
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _initProperties();
    _initVideoPlayer();
  }

  void _initVideoPlayer() {
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.url);
        break;
      case DataSourceType.network:
        _videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(widget.url));
        break;
      /*
      case DataSourceType.file:
        _videoPlayerController = VideoPlayerController.file();
        break;*/
      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(widget.url));
    }
    _flickManager = FlickManager(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      autoInitialize: true,
    );
  }

  void _initProperties() {
    title = widget.title;
    subTitle = widget.subTitle;
  }

  @override
  void dispose() {
    _flickManager.flickControlManager?.pause();
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    _flickManager.dispose();
    super.dispose();
  }

  void toggleSubtitle() {
    /*if (widget.onTapOpenSubTitle != null) {
      widget.onTapOpenSubTitle!();
    }*/
    setState(() {
      isSubtitleVisible = !isSubtitleVisible;
    });
  }

  void toggleFullscreen() {
    _flickManager.flickControlManager?.toggleFullscreen();
    setState(() {
      isFullScreen = !isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_flickManager.flickControlManager != null) {
      duration = _flickManager.flickVideoManager?.videoPlayerValue?.duration;
      return FlickVideoPlayer(
        flickManager: _flickManager,
        flickVideoWithControls: Builder(builder: (context) {
          return FlickVideoWithControls(
            videoFit: BoxFit.fitWidth,
            controls: _buildControlView(),
          );
        }),
        flickVideoWithControlsFullscreen: Builder(builder: (context) {
          return FlickVideoWithControls(
            videoFit: BoxFit.cover,
            controls: _buildControlView(),
          );
        }),
      );
    } else {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      ));
    }
  }

  final AppBar _appBar = AppBar(
    backgroundColor: Colors.transparent,
    leading: FlickAutoHideChild(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12),
        child: BackButtonAppBar(
          backgroundColor: Colors.white.withOpacity(0.3),
          iconColor: Colors.white,
        ),
      ),
    ),
  );

  Widget _buildControlView() {
    double appBarHeight = _appBar.preferredSize.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: isFullScreen ? null : _appBar,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: isFullScreen ? null : 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FlickAutoHideChild(
                child: Column(
                  crossAxisAlignment: isFullScreen
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Text(
                      title ?? '',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      subTitle ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: isFullScreen ? 0 : appBarHeight,
            child: FlickShowControlsAction(
              child: FlickSeekVideoAction(
                child: Center(
                  child: FlickAutoHideChild(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: const ControlButton(
                            icon: Icons.skip_previous_rounded,
                            radius: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const FlickPlayToggle(
                          playChild: ControlButton(
                            icon: Icons.play_arrow,
                            radius: 25,
                          ),
                          pauseChild: ControlButton(
                            icon: Icons.pause,
                            radius: 25,
                          ),
                          replayChild:
                              ControlButton(icon: Icons.replay, radius: 25),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          child: const ControlButton(
                              icon: Icons.skip_next_rounded, radius: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FlickAutoHideChild(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextPosition(),
                        TextTotalDuration(),
                      ],
                    ),
                    FlickVideoProgressBar(
                      flickProgressBarSettings: FlickProgressBarSettings(
                        backgroundColor: const Color(0xffe0f2f3),
                        playedColor: const Color(0xff4db5b6),
                        height: 6,
                        handleColor: const Color(0xff4db5b6),
                        handleRadius: 8,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Image.asset(MyImages.icRepeat),
                          onTap: () {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            /*FlickSubtitleToggle(
                              activeChild: SizedBox(
                                height: 32,
                                width: 32,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              inactiveChild: SizedBox(
                                height: 32,
                                width: 32,
                                child: const Icon(
                                  Icons.access_alarm,
                                  color: Colors.white,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              toggleSubtitleVisibility: toggleSubtitle,
                            ),*/
                            GestureDetector(
                              child: Image.asset(isSubtitleVisible
                                  ? MyImages.icSubtitleOpened
                                  : MyImages.icSubtitle),
                              onTap: () {
                                toggleSubtitle();
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            FlickFullScreenToggle(
                              enterFullScreenChild:
                                  Image.asset(MyImages.icZoom),
                              toggleFullscreen: toggleFullscreen,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // if (widget.isShowSub) const SubtitleWidget(),
          if (isSubtitleVisible) const SubtitleWidget(),
          // Show subtitle widget if visible
        ],
      ),
    );
  }

  Widget _buildControlViewWithFullScreen() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: FlickAutoHideChild(
              child: Column(
                children: [
                  Text(
                    title ?? '',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    subTitle ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: FlickShowControlsAction(
              child: FlickSeekVideoAction(
                child: Center(
                  child: FlickAutoHideChild(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: const ControlButton(
                            icon: Icons.skip_previous_rounded,
                            radius: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const FlickPlayToggle(
                          playChild: ControlButton(
                            icon: Icons.play_arrow,
                            radius: 25,
                          ),
                          pauseChild: ControlButton(
                            icon: Icons.pause,
                            radius: 25,
                          ),
                          replayChild:
                              ControlButton(icon: Icons.replay, radius: 25),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          child: const ControlButton(
                              icon: Icons.skip_next_rounded, radius: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: FlickAutoHideChild(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextPosition(),
                      TextTotalDuration(),
                    ],
                  ),
                  FlickVideoProgressBar(
                    flickProgressBarSettings: FlickProgressBarSettings(
                      backgroundColor: const Color(0xffe0f2f3),
                      playedColor: const Color(0xff4db5b6),
                      height: 6,
                      handleColor: const Color(0xff4db5b6),
                      handleRadius: 8,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Image.asset(MyImages.icRepeat),
                        onTap: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /*FlickSubtitleToggle(
                            activeChild: SizedBox(
                              height: 32,
                              width: 32,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            inactiveChild: SizedBox(
                              height: 32,
                              width: 32,
                              child: const Icon(
                                Icons.access_alarm,
                                color: Colors.white,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            toggleSubtitleVisibility: toggleSubtitle,
                          ),*/
                          GestureDetector(
                            child: Image.asset(widget.isShowSub
                                ? MyImages.icSubtitleOpened
                                : MyImages.icSubtitle),
                            onTap: () {
                              toggleSubtitle();
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          FlickFullScreenToggle(
                            enterFullScreenChild: Image.asset(MyImages.icZoom),
                            toggleFullscreen: toggleFullscreen,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (widget.isShowSub) const SubtitleWidget(),
          // if (isSubtitleVisible) const SubtitleWidget(),
          // Show subtitle widget if visible
        ],
      ),
    );
  }
}

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 140),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: Text(
              'Với các từ có tận cùng là “e”, khi chuyển sang',
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class ControlButton extends StatelessWidget {
  final IconData icon;
  final double radius;

  const ControlButton({
    super.key,
    required this.icon,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.black54,
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

String formatTime(Duration? duration) {
  if (duration == null) {
    return "00:00:00";
  } else {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class TextTotalDuration extends StatelessWidget {
  const TextTotalDuration({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlickVideoManager videoManager = Provider.of<FlickVideoManager>(context);
    Duration? duration = videoManager.videoPlayerValue?.duration;
    return Text(
      formatTime(duration),
      style: GoogleFonts.quicksand(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.57,
        color: const Color(0xff8b90a7),
      ),
    );
  }
}

class TextPosition extends StatelessWidget {
  const TextPosition({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlickVideoManager videoManager = Provider.of<FlickVideoManager>(context);
    Duration? duration = videoManager.videoPlayerValue?.position;

    return Text(
      formatTime(duration),
      style: GoogleFonts.quicksand(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.57,
        color: const Color(0xff8b90a7),
      ), // Use the custom textStyle or default
    );
  }
}
