import 'package:common/util/_util.dart';
import 'package:common/util/auth.dart';
import 'package:common/value/const_values.dart';
import 'package:core/util/_consoles.dart';
import 'package:equatable/equatable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'unit_test.g.dart';

void main() async {
  final api = CobApi(Dio());
  final users = await api.getUsers();
  final repos = await api.getRepos("alfalifr");

  print("users= $users");
  print("repos= $repos");

  final dio = Dio();

  final resp = await dio.get(
    "https://api.github.com/users/alfalifr/repos",
  );

  final resp2 = SimpleNetResponse.from(resp);

  prinr("resp2 = $resp2");
/*
  final name = "ayu3";
  final email = "a6@a.a";
  final pswd = "abcd1234";
  final secret = "5xnEHfLiRiyyRGrez97iEmqzTB4h48IWr5DnHEuO";
  final clientId = "2";
  final fcmToken = "ini token";
  //remote_host=https://sibunda3.digitalise.biz.id

  await signUpTest(name, email, pswd);
  final token = await login(email, pswd, secret, clientId, fcmToken);
  await logout(token);
 */
}

///*
@RestApi(baseUrl: "https://api.github.com")
abstract class CobApi {
  factory CobApi(Dio dio, {String? baseUrl}) => _CobApi(dio);
  @GET("/users")
  Future<List<User>> getUsers();
  @GET("/users/{uname}/repos")
  Future<List<Repo>> getRepos(@Path() String uname);
}
// */

@JsonSerializable()
class User extends Equatable {
  final String login;
  final int id;
  final String avatar_url;

  const User({
    required this.login,
    required this.id,
    required this.avatar_url,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  List<Object?> get props => [login, id, avatar_url];
}

@JsonSerializable()
class Repo extends Equatable {
  final String full_name;
  final int id;
  final String html_url;
  final User owner;

  const Repo({
    required this.full_name,
    required this.id,
    required this.html_url,
    required this.owner,
  });

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  @override
  List<Object?> get props => [full_name, id, html_url, owner];
}

Future<void> signUpTest(String name, String email, String pswd) async {
  print("Mulai signUpTest()");
  final resp = await Auth.signUp(name, email, pswd);
  print("resp= $resp");
  assert(resp.statusCode == 200);
  print("Selesai signUpTest()");
}

Future<String> login(
  String email,
  String pswd,
  String secret,
  String clientId,
  String fcmToken,
) async {
  print("Mulai login()");
  final resp = await Auth.login(email, pswd, secret, clientId, fcmToken);
  print("resp= $resp");
  assert(resp.statusCode == 200);
  print("Selesai login()");
  return resp.data["data"][Const.KEY_ACCESS_TOKEN];
}

Future<void> logout(String token) async {
  print("Mulai logout()");
  final resp = await Auth.logout(token);
  print("resp= $resp");
  assert(resp.statusCode == 200);
  print("Selesai logout()");
}
