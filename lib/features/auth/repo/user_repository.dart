import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/common/services/shared_pref_services.dart';
import 'package:ecommerce_app/features/auth/models/user.dart';

class UserRepository {
  User? _user;

  User? get user => _user;

  String _token = "";

  String get token => _token;

  Future<void> initialize() async {
    final tempUser = await SharedPrefServices.user;
    final tempToken = await SharedPrefServices.token;
    _user = tempUser;
    _token = tempToken;
  }

  final dio = Dio();
  Future<Either<String, String>> signUp(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String address}) async {
    try {
      final Dio dio = Dio();
      final _ = await dio.post("${Constants.baseUrl}/api/auth/register", data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'address': address,
      });
      return Right("Sign Up Successful");
    } on DioException catch (e) {
      return Left(e.response?.data["message"]);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, User>> login(
      {required String email, required String password}) async {
    final dio = Dio();
    try {
      final res = await dio.post(
        "${Constants.baseUrl}/api/auth/login",
        data: {
          'email': email,
          'password': password,
        },
      );
      User _user = User.fromJson(res.data["results"]);
      await SharedPrefServices.setUser(_user);
      await SharedPrefServices.setToken(res.data["token"]);
      return Right(_user);
    } on DioException catch (e) {
      print(e.response?.data["message"].toString() ?? "unable to login");

      return Left(e.response?.data["message"].toString() ?? "unable to login");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, User>> facebookLogin() async {
    try {
      await FacebookAuth.instance.logOut();
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: []);
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = await result.accessToken!;
        final res = await dio
            .post("${Constants.baseUrl}/api/auth/login/social/facebook", data: {
          "token": accessToken.tokenString,
        });
        final tempUser = User.fromJson(res.data["results"]);
        _user = tempUser;
        await SharedPrefServices.setUser(_user!);
        await SharedPrefServices.setToken(res.data["token"]);

        print("hello${accessToken.tokenString}");
        return Right(tempUser);
      } else {
        print(result.status);
        print(result.message);
        return Left("Facebook api error");
      }
    } on DioException catch (e) {
      print(e.response?.data["message"].toString() ?? "dio api error");

      return Left(e.response?.data["message"].toString() ?? "dio api error");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, User>> googleLogin() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final result = await googleSignIn.signIn();
      if (result != null) {
        final auth = await result.authentication;
        // final AccessToken accessToken = await result.accessToken!;
        final res = await dio
            .post("${Constants.baseUrl}/api/auth/login/social/google", data: {
          "token": auth.accessToken,
        });
        final tempUser = User.fromJson(res.data["results"]);
        _user = tempUser;
        await SharedPrefServices.setUser(_user!);
        await SharedPrefServices.setToken(res.data["token"]);

        return Right(tempUser);
      } else {
        return Left("Google api error");
      }
    } on DioException catch (e) {
      print(e.response?.data["message"].toString() ?? "dio api error");

      return Left(e.response?.data["message"].toString() ?? "dio api error");
    } catch (e) {
      return Left(e.toString());
    }
  }

  logout() async {
    await SharedPrefServices.removeUser();
    await SharedPrefServices.removeToken();
  }
}
