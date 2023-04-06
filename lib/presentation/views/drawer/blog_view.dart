import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/blog_view_model.dart';
import 'package:video_player/video_player.dart';

import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';

class BlogView extends StatefulWidget {
  const BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _initializeVideoPlayerFuture = _controller.initialize();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => DrawerMenuViewModel(),
          child: Scaffold(
            body: Consumer<DrawerMenuViewModel>(
              builder: (context, viewModel, child) {
                switch (viewModel.blogsList.status) {
                  case Status.loading:
                    return const Center(child: CircularProgressIndicator());
                  case Status.error:
                    return Center(
                      child: Text(viewModel.blogsList.message.toString()),
                    );
                  case Status.completed:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopBackButtonWidget(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(10),
                              horizontal: getProportionateScreenWidth(30)),
                          child: kTextBentonSansBold("SEHR Blogs",
                              fontSize: getProportionateScreenHeight(31)),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                buildVerticleSpace(20),
                            itemCount: viewModel.blogsList.data!.posts!.length,
                            itemBuilder: (context, index) {
                              print(
                                'Post Lenght ===> ${viewModel.blogsList.data!.posts![index].image}',
                              );
                              var blogTitle =
                                  viewModel.blogsList.data!.posts![index].title;
                              var blogContent = viewModel
                                  .blogsList.data!.posts![index].content;
                              var blogDescription = viewModel
                                  .blogsList.data!.posts![index].description;
                              var blogImage =
                                  viewModel.blogsList.data!.posts![index].image;
                              var blogVideo =
                                  viewModel.blogsList.data!.posts![index].video;

                              return BlogCardWidget(
                                  titleText: blogTitle!,
                                  description: blogDescription,
                                  child: blogImage != null
                                      ? Container(
                                          height:
                                              getProportionateScreenHeight(220),
                                          width: SizeConfig.screenWidth,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              getProportionateScreenHeight(10),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                blogImage,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : blogVideo.toString().isEmpty
                                          ? Container(
                                              height:
                                                  getProportionateScreenHeight(
                                                      300),
                                              child: FutureBuilder(
                                                future:
                                                    _initializeVideoPlayerFuture,
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    // If the VideoPlayerController has finished initialization, use
                                                    // the data it provides to limit the aspect ratio of the video.
                                                    return AspectRatio(
                                                      aspectRatio: _controller
                                                          .value.aspectRatio,
                                                      // Use the VideoPlayer widget to display the video.
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            top: 50,
                                                            bottom: 50,
                                                            left: 130,
                                                            right: 80,
                                                            child:
                                                                FloatingActionButton(
                                                              onPressed: () {
                                                                // Wrap the play or pause in a call to `setState`. This ensures the
                                                                // correct icon is shown.
                                                                setState(() {
                                                                  // If the video is playing, pause it.
                                                                  if (_controller
                                                                      .value
                                                                      .isPlaying) {
                                                                    _controller
                                                                        .pause();
                                                                  } else {
                                                                    // If the video is paused, play it.
                                                                    _controller
                                                                        .play();
                                                                  }
                                                                });
                                                              },
                                                              // Display the correct icon depending on the state of the player.
                                                              child: Icon(
                                                                _controller
                                                                        .value
                                                                        .isPlaying
                                                                    ? Icons
                                                                        .pause
                                                                    : Icons
                                                                        .play_arrow,
                                                              ),
                                                            ),
                                                          ),
                                                          VideoPlayer(
                                                              VideoPlayerController
                                                                  .network(
                                                                      "https://www.youtube.com/watch?v=Lm_XCijreJk")),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    // If the VideoPlayerController is still initializing, show a
                                                    // loading spinner.
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                },
                                              ),
                                            )
                                          : null);
                            },
                          ),
                        ),
                      ],
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BlogCardWidget extends StatelessWidget {
  const BlogCardWidget({
    Key? key,
    required this.titleText,
    this.description,
    this.child,
  }) : super(key: key);

  final String titleText;
  final String? description;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: getProportionateScreenHeight(15),
      shadowColor: ColorManager.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildVerticleSpace(20),
            kTextBentonSansMed(
              titleText,
              fontSize: getProportionateScreenHeight(17),
            ),
            buildVerticleSpace(10),
            child ??
                kTextBentonSansReg(
                  description ?? '',
                  fontSize: getProportionateScreenHeight(12),
                  lineHeight: getProportionateScreenHeight(2),
                  textOverFlow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
            Divider(
              color: ColorManager.textGrey.withOpacity(0.5),
            ),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.thumb_up,
                    color: ColorManager.black,
                    size: getProportionateScreenHeight(22),
                  ),
                  label: kTextBentonSansMed(
                    'Like',
                    fontSize: getProportionateScreenHeight(16),
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.comment_rounded,
                    color: ColorManager.textGrey.withOpacity(0.5),
                    size: getProportionateScreenHeight(22),
                  ),
                  label: kTextBentonSansMed(
                    'Comment',
                    fontSize: getProportionateScreenHeight(16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
