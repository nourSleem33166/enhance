import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/shared/exceptions/enhance_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ExceptionsHandler {
  static firebaseAuthExceptionsHandler(
      FirebaseAuthException exception, StackTrace stack) {
    switch (exception.code) {
      case 'expired-action-code':
        throw EnhanceException(
            LocaleKeys.expiredActionCode.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case 'invalid-action-code':
        throw EnhanceException(
            LocaleKeys.invalidActionCode.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case 'user-disabled':
        throw EnhanceException(LocaleKeys.userDisabled.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case 'user-not-found':
        throw EnhanceException(LocaleKeys.userNotFound.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case 'invalid-action-code':
        throw EnhanceException(
            LocaleKeys.invalidActionCode.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case 'weak-password':
        throw EnhanceException(LocaleKeys.weakPassword.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case 'wrong-password':
        throw EnhanceException(
            LocaleKeys.wrongPassword.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case 'email-already-in-use':
        throw EnhanceException(
            LocaleKeys.emailAlreadyInUse.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case 'invalid-email':
        throw EnhanceException(LocaleKeys.invalidEmail.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case 'operation-not-allowed':
        throw EnhanceException(
            LocaleKeys.operationNotAllowed.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      default:
        FirebaseCrashlytics.instance.recordError(exception, stack);
        throw EnhanceException(LocaleKeys.unknownError.tr(), LocaleKeys.error.tr(),
            innerException: exception);
    }
  }

  static dioExceptionsHandler(DioError exception, StackTrace stack) {
    switch (exception.type) {
      case DioErrorType.SEND_TIMEOUT:
        throw EnhanceException(LocaleKeys.sendTimeout.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case DioErrorType.CONNECT_TIMEOUT:
        throw EnhanceException(
            LocaleKeys.connectionTimeout.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case DioErrorType.RECEIVE_TIMEOUT:
        throw EnhanceException(
            LocaleKeys.receiveTimeout.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case DioErrorType.CANCEL:
        throw EnhanceException(
            LocaleKeys.requestCancel.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      case DioErrorType.RESPONSE:
        throw EnhanceException(
            LocaleKeys.responseError.tr(), LocaleKeys.error.tr(),
            innerException: exception);
      default:
        throw EnhanceException("Internet Error", LocaleKeys.error.tr(),
            innerException: exception);
    }
  }
}
