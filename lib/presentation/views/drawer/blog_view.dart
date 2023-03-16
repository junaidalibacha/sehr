import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/blog_view_model.dart';

import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';

class BlogView extends StatelessWidget {
  const BlogView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                            var blogContent =
                                viewModel.blogsList.data!.posts![index].content;
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
                                      height: getProportionateScreenHeight(120),
                                      width: SizeConfig.screenWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenHeight(10),
                                        ),
                                        image: const DecorationImage(
                                          image: NetworkImage(
                                            'https://3.133.0.29/api/blog/posts/public/1678462528419-591397582.png',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : null,
                            );
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
