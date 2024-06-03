import 'package:common/arch/di/config_di.dart';
import 'package:common/arch/domain/model/auth.dart';
import 'package:common/value/const_values.dart';
import 'package:core/util/_consoles.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

const REMOTE_HOST = "https://sibunda3.digitalise.biz.id";
const ENDPOINT_LOGIN = "$REMOTE_HOST/api/auth/login";
const ENDPOINT_REGISTER = "$REMOTE_HOST/api/auth/register";
const ENDPOINT_LOGOUT = "$REMOTE_HOST/api/auth/logout";

class SimpleNetResponse extends Equatable {
  final int? statusCode;
  final String? message;
  final data;

  const SimpleNetResponse(this.statusCode, this.message, [this.data]);
  SimpleNetResponse.from(Response response)
      : this(response.statusCode, response.statusMessage, response.data);

  @override
  String toString() {
    final superStr = super.toString();
    return "$superStr(statusCode=$statusCode, message=$message, data=$data)";
  }

  @override
  List<Object?> get props => [statusCode, message, data];
}

class SibDio {
  SibDio._();
  static Dio getDefaultInstance({
    Dio? preExisting,
    SessionData? session,
    bool isLogging = IoConfig.canPrint,
    LogInterceptor? interceptor,
  }) {
    final dio = preExisting ?? Dio(SibDio.defaultBaseOptions());
    dio.interceptors.insert(0, AuthInterceptor());
    if (session != null) {
      dio.options.headers[Const.HEADER_AUTH] = session.toAuthString();
    }
    if (isLogging) {
      dio.interceptors.add(interceptor ??
          LogInterceptor(
            responseBody: true,
            requestBody: true,
            logPrint: prind,
          ));
    }
    return dio;
  }

  static const Map<String, dynamic> defaultHeaders = {
    "Accept": "application/json"
  };
  static Options defaultOptions() => Options(
        followRedirects: false,
        validateStatus: (code) =>
            true, //So that every response, even errors, is returned.
        headers: defaultHeaders,
      );
  static BaseOptions defaultBaseOptions() => BaseOptions(
        followRedirects: false,
        validateStatus: (code) =>
            true, //So that every response, even errors, is returned.
        headers: defaultHeaders,
      );
}

class AuthInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    prind(
        "AuthInterceptor.onResponse() response.statusCode= ${response.statusCode} data= $response");
    VarDi.isSessionValid.value = response.statusCode != 401;
    super.onResponse(response, handler);
  }
}
