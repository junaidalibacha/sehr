import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/common/logo_widget.dart';
import 'package:sehr/presentation/src/index.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';

class OnboardingScreen extends StatefulWidget {
  String youtubeUrl;

  OnboardingScreen(this.youtubeUrl, {super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  final bool _isPlayerReady = false;
  late String videoId;

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(200),
      color: ColorManager.primary,
      child: VisibilityDetector(
        key: const Key("unique key"),
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 0) {
            _controller.pause();
          } else {
            _controller.value.isPlaying
                ? _controller.play()
                : _controller.pause();
          }
        },
        child: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: ColorManager.primary,
            topActions: <Widget>[
              // const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  _controller.metadata.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenHeight(18),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
            onReady: () {
              _controller.addListener(listener);
            },
            onEnded: (data) {},
          ),
          builder: (context, player) => Scaffold(
            key: _scaffoldKey,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const LogoWidget(),
                  buildVerticleSpace(20),
                  Card(
                    child: player,
                  ),
                  AppButtonWidget(
                    ontap: () {},
                    text: 'Next',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
