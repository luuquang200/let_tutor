import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/course/course_category.dart';
import 'package:let_tutor/data/models/course/course_category_response.dart';
import 'package:let_tutor/data/models/course/course_reponse.dart';
import 'package:let_tutor/data/network/apis/course_api_client.dart';

class CourseRepository {
  final CourseApiClient _courseApiClient;

  CourseRepository({CourseApiClient? courseApiClient})
      : _courseApiClient = courseApiClient ?? CourseApiClient();

  Future<CourseResponse> getCoursesList({int page = 1, int size = 100}) async {
    CourseResponse courseResponse =
        await _courseApiClient.getCoursesList(page, size);
    return courseResponse;
  }

  Future<List<CourseCategory>> getCourseCategories() async {
    CourseCategoryResponse courseCategoryResponse =
        await _courseApiClient.getCourseCategories();
    return courseCategoryResponse.rows;
  }

  Future<Course> getDetailCourse(String id) async {
    Course course = await _courseApiClient.getDetailCourse(id);
    return course;
  }

  // searchCourses(int i, int j, int perPage, Map<String, String> map) {}
  Future<CourseResponse> searchCourses({
    int page = 1,
    int size = 100,
    int perPage = 20,
    Map<String, dynamic> map = const {},
  }) async {
    CourseResponse courseResponse =
        await _courseApiClient.searchCourses(page, size, perPage, map);
    return courseResponse;
  }

  Future<List<Course>> searchEbooks({
    int page = 1,
    int size = 100,
    int perPage = 20,
    Map<String, dynamic> map = const {},
  }) async {
    CourseResponse courseResponse =
        await _courseApiClient.searchEbooks(page, size, perPage, map);
    return courseResponse.rows;
  }
}
