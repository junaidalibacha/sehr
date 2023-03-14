import 'package:sehr/app/index.dart';
import 'package:sehr/data/response/api_response.dart';
import 'package:sehr/domain/models/blog_model.dart';
import 'package:sehr/presentation/routes/routes.dart';
import 'package:sehr/presentation/views/drawer/blog_view.dart';

import '../../domain/repository/blog_repository.dart';
// import '../../domain/repository/education_repository.dart';

class DrawerMenuViewModel extends ChangeNotifier {
  final _blogRepo = BlogsRepository();
  // final _educationRepo = EducationRepository();

  ApiResponse<BlogModel> blogsList = ApiResponse.loading();

  void setBlogData(ApiResponse<BlogModel> response) {
    blogsList = response;
    print(blogsList.status);
    if (blogsList.status == Status.completed) {
      print(blogsList.data!.posts![0].content);
    }

    notifyListeners();
  }

  Future<void> blogApi() async {
    setBlogData(ApiResponse.loading());
    // print(blogsList.status);

    _blogRepo.getBlogData().then((value) {
      setBlogData(ApiResponse.completed(value));
      // print(blogsList.status);
      Get.to(() => const BlogView());
    }).onError((error, stackTrace) {
      setBlogData(ApiResponse.error(error.toString()));
      // print(blogsList.status);
    });
  }

  // Future<void> educationApi() async {
  //   _educationRepo.getEducationApi().then((value) {
  //     // print(value.toString());
  //   }).onError((error, stackTrace) {
  //     print("Error==>$error");
  //   });
  // }

  // ApiResponse<BlogModel> blogsList = ApiResponse.loading();

  // setBlogsList(ApiResponse<BlogModel> response) {
  //   blogsList = response;
  //   // print(blogsList.data?.posts);
  //   notifyListeners();
  // }

  // Future<void> blogApi() async {
  //   setBlogsList(ApiResponse.loading());

  //   _blogRepo.getBlogData().then((value) {
  //     setBlogsList(ApiResponse.completed(value));

  //     print("api response is ==> ${value.toJson()}");
  //   }).onError((error, stackTrace) {
  //     setBlogsList(ApiResponse.error(error.toString()));

  //     print(error);
  //   });
  // }
}
