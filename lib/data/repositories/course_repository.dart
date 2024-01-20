import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/course/course_category.dart';
import 'package:let_tutor/data/models/course/course_category_response.dart';
import 'package:let_tutor/data/models/course/course_reponse.dart';
import 'package:let_tutor/data/network/apis/course_api_client.dart';

class CourseRepository {
  final CourseApiClient _courseApiClient;

  CourseRepository({CourseApiClient? courseApiClient})
      : _courseApiClient = courseApiClient ?? CourseApiClient();

  Future<List<Course>> getCoursesList({int page = 1, int size = 100}) async {
    CourseResponse courseResponse =
        await _courseApiClient.getCoursesList(page, size);
    return courseResponse.rows;
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
  Future<List<Course>> searchCourses({
    int page = 1,
    int size = 100,
    int perPage = 20,
    Map<String, dynamic> map = const {},
  }) async {
    CourseResponse courseResponse =
        await _courseApiClient.searchCourses(page, size, perPage, map);
    return courseResponse.rows;
  }
}
