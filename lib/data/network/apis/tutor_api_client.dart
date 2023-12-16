import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/tutors/tutor_search_result.dart';
import 'package:let_tutor/data/network/dio_client.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';

class TutorApiClient {
  Future<TutorSearchResult> searchTutor(
      Map<String, dynamic> filters, int page, int perPage) async {
    log('calling search tutor api');
    try {
      final response = await DioClient.instance.post(
        Endpoints.searchTutor,
        data: {'filters': filters, 'page': page, 'perPage': perPage},
      );
      return TutorSearchResult.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error handling from search tutor api: $e');
      rethrow;
    }
  }
}
