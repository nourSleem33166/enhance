import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class EnhanceException implements Exception {
  final String key;
  final String level;
  final Exception innerException;

  String get innerCode {
    if (innerException != null && innerException is PlatformException)
      return (innerException as PlatformException).code;
    if (innerException != null && innerException is FirebaseAuthException)
      return (innerException as FirebaseAuthException).code;
    if (innerException != null && innerException is DioError)
      return (innerException as DioError).error?.toString();
    return null;
  }

  String get innerMessage {
    if (innerException != null && innerException is PlatformException)
      return (innerException as PlatformException).message;
    if (innerException != null && innerException is FirebaseAuthException)
      return (innerException as FirebaseAuthException).message;
    if (innerException != null && innerException is DioError)
      return (innerException as DioError).message;
    return null;
  }

  EnhanceException(this.key, this.level, {this.innerException});
}
