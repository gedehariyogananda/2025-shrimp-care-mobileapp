class AppExceptions implements Exception {
  final String message;

  AppExceptions({
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}

class ServerException extends AppExceptions {
  ServerException()
      : super(message: "Tidak ada respon dari server. Silakan coba lagi.");
}

class BadRequestException extends AppExceptions {
  BadRequestException({required String message}) : super(message: message);
}

class NotFoundException extends AppExceptions {
  NotFoundException() : super(message: "Data tidak ditemukan!");
}

class UnauthorisedException extends AppExceptions {
  UnauthorisedException()
      : super(message: "Akses ditolak, silahkan login kembali!");
}

class UnexpectedException extends AppExceptions {
  UnexpectedException()
      : super(message: "Terjadi kesalahan yang tidak terduga, coba lagi!");
}

class TimeoutException extends AppExceptions {
  TimeoutException()
      : super(
            message:
                "Permintaan telah melebihi batas waktu, silahkan coba lagi!");
}

class NoConnectionException extends AppExceptions {
  NoConnectionException()
      : super(message: "Tidak ada koneksi internet, silahkan coba lagi!.");
}

class ValidationException extends AppExceptions {
  ValidationException({required String message}) : super(message: message);
}