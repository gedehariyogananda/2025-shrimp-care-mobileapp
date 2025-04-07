class AppExceptions implements Exception {
  String? message;
  List<dynamic>? errors;

  AppExceptions({
    this.message,
    this.errors,
  });

  @override
  String toString() {
    if (message != null) {
      return message!;
    } else if (errors != null && errors!.isNotEmpty) {
      return errors!.join(", ");
    } else {
      return "Terjadi kesalahan yang tidak terduga, coba lagi!";
    }
  }
}

class ServerException extends AppExceptions {
  ServerException(String message)
      : super(
            message: message.isNotEmpty
                ? message
                : "Terjadi kesalahan pada server, silahkan coba lagis.");
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
  ValidationException({List<dynamic>? errors})
      : super(message: "KESALAHAN VALIDASI : ", errors: errors);

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln(message);

    if (errors != null && errors!.isNotEmpty) {
      for (var e in errors!) {
        if (e is Map<String, dynamic>) {
          final field = e['field'] ?? '';
          final msg = e['message'] ?? '';
          buffer.writeln('$field: $msg');
        } else {
          buffer.writeln(e.toString());
        }
      }
    } else {
      buffer.writeln("Terjadi kesalahan validasi.");
    }

    return buffer.toString();
  }
}
