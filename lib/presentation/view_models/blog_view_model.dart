import 'package:sehr/app/index.dart';
import 'package:sehr/data/response/api_response.dart';
import 'package:sehr/domain/models/blog_model.dart';

import '../../domain/repository/blog_repository.dart';

class DrawerMenuViewModel extends ChangeNotifier {
  final _blogRepo = BlogsRepository();

  ApiResponse<BlogModel> blogsList = ApiResponse.loading();

  setBlogData(ApiResponse<BlogModel> response) {
    blogsList = response;
    notifyListeners();
  }

  DrawerMenuViewModel() {
    callingBlog();
  }
  callingBlog() async {
    await blogApi();
  }

  Future<void> blogApi() async {
    setBlogData(ApiResponse.loading());

    _blogRepo.getBlogData().then((value) {
      setBlogData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setBlogData(ApiResponse.error(error.toString()));
    });
  }

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
