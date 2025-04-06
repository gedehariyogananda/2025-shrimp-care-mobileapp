import 'package:dio/dio.dart';
import 'package:shrimp_care_mobileapp/exception/app_exception.dart';

void errorHandler({Object? error}) {
  if (error is DioException) {
    if (error.type == DioExceptionType.connectionTimeout) {
      throw TimeoutException();
    } else if (error.type == DioExceptionType.connectionError) {
      throw NoConnectionException();
    } else if (error.type == DioExceptionType.receiveTimeout) {
      throw NoConnectionException();
    }

    if (error.response != null) {
      switch (error.response!.statusCode) {
        case 400:
          throw BadRequestException(message: error.response!.data['message']);
        case 401:
          throw UnauthorisedException();
        case 404:
          throw NotFoundException();
        case 422:
          throw ValidationException(message: error.response!.data['message']);
        case 500:
          throw ServerException(error.toString());
        default:
          throw ServerException(error.toString());
      }
    } else {
      throw ServerException(error.toString());
    }
  } else {
    throw UnexpectedException();
  }
}
