import 'package:let_tutor/data/models/course/course.dart';
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
}
