import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/blog_view_model.dart';

import '../../src/index.dart';

class BlogView extends StatefulWidget {
  const BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  DrawerMenuViewModel drawerMenuViewModel = DrawerMenuViewModel();
  @override
  void initState() {
    drawerMenuViewModel.blogApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final BlogModel blogModel = BlogModel();
    final viewModel = Provider.of<DrawerMenuViewModel>(context);
    // print(viewModel.blogsList!.status);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              // if (viewModel.blogsList.status == Status.completed)
              // Text(viewModel.blogsList.data!.posts![0].content!),
              ElevatedButton(
                onPressed: () {
                  // viewModel.setBlogData;
                  print(viewModel.blogsList.status);
                },
                child: const Text('data'),
              ),
            ],
          ),
        ),
        // Consumer<DrawerMenuViewModel>(
        //   builder: (context, value, _) {
        //     if (viewModel.blogsList.status == Status.loading) {
        //       return const CircularProgressIndicator();
        //     } else if (viewModel.blogsList.status == Status.error) {
        //       return Text(viewModel.blogsList.message.toString());
        //     } else {
        //       return const Text('Data Loaded');
        //     }
        //
        // switch (viewModel.blogsList.status) {
        //   case Status.loading:
        //     return const Center(child: CircularProgressIndicator());
        //   case Status.error:
        //     return Center(
        //       child: Text(viewModel.blogsList.message.toString()),
        //     );
        //   case Status.completed:
        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const TopBackButtonWidget(),
        //         Padding(
        //           padding: EdgeInsets.symmetric(
        //               vertical: getProportionateScreenHeight(10),
        //               horizontal: getProportionateScreenWidth(30)),
        //           child: kTextBentonSansBold("SEHR Blogs",
        //               fontSize: getProportionateScreenHeight(31)),
        //         ),
        //         Expanded(
        //           child: SingleChildScrollView(
        //             child: Column(
        //               children: [
        //                 const BlogCardWidget(
        //                   titleText: 'Blog',
        //                   description:
        //                       'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        //                 ),
        //                 buildVerticleSpace(10),
        //                 BlogCardWidget(
        //                   titleText: 'Blog',
        //                   child: Image.asset(
        //                     AppImages.restourant,
        //                     height: getProportionateScreenHeight(110),
        //                     width: SizeConfig.screenWidth,
        //                     fit: BoxFit.fill,
        //                   ),
        //                 ),
        //                 buildVerticleSpace(10),
        //                 const BlogCardWidget(
        //                   titleText: 'Blog',
        //                   description:
        //                       'Most whole Alaskan Red King Crabs get broken down into legs, claws, and lump meat. We offer all of these options as well in our online shop, but there is nothing like getting the whole . . . .',
        //                 ),
        //                 buildVerticleSpace(100),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     );
        //   default:
        //     return Container();
        // }
        // },
        // ),
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
