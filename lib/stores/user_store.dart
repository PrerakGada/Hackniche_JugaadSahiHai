import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'state_keeper.dart';

class UserStore extends StateKeeper {
  UserStore._();

  static final UserStore _instance = UserStore._();

  factory UserStore() => _instance;

  var token;
  var APIToken;
  var RefreshToken;

  Future refresh() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('APIToken') != null) {
      print(prefs.getString('RefreshToken'));
      var response = await http.post(
        Uri.parse("https://jugaad-sahi-hai.mustansirg.in/auth/token/refresh/"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "refresh": prefs.getString('RefreshToken'),
        }),
      );
      var data = jsonDecode(response.body);
      print("Refresh Response: " + data.toString());
      await prefs.setString('APIToken', data['access']);
      APIToken = data['access'];
      RefreshToken = data['refresh'];

      print(data);
      token = JwtDecoder.decode(data['access']);
      print("Decoded After Refresh: " + token.toString());
      print("------------------------------" + token['profile_photo']);
      notifyListeners();
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    // Register
    var response = await http.post(
      Uri.parse("https://jugaad-sahi-hai.mustansirg.in/auth/login/"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      await prefs.setString('APIToken', data['access']);
      await prefs.setString('RefreshToken', data['refresh']);
      APIToken = data['access'];
      RefreshToken = data['refresh'];

      // final APIToken = prefs.getString('APIToken');
      token = JwtDecoder.decode(APIToken.toString());
      print(token);
      notifyListeners();
      return true;
    } else {
      print("Failed to Login");
      print(response.body);
      return false;
    }
  }

  Future register({
    required String username,
    required String email,
    required String password1,
    required String password2,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    // Register
    var response = await http.post(
      Uri.parse("https://jugaad-sahi-hai.mustansirg.in/auth/registration/"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "username": username,
        "password1": password1,
        "password2": password2,
      }),
    );
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data);
      await prefs.setString('APIToken', data['access_token']);
      await prefs.setString('RefreshToken', data['refresh_token']);
      APIToken = data['access'];
      RefreshToken = data['refresh'];
      refresh();
      return true;
    } else {
      print("Failed to Register");
      print(response.body);
      return false;
    }
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    token = null;
    notifyListeners();
  }

  List<dynamic> searchPosts = [];
  late String selectedChip = '';

  Future search({required String searchText}) async {
    final prefs = await SharedPreferences.getInstance();
    // Register
    var response = await http.get(
      Uri.parse(
          "https://jugaad-sahi-hai.mustansirg.in/news/?query=$searchText"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + APIToken,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      searchPosts = data;
      print(data);
      notifyListeners();
      return true;
    } else {
      print("Failed to Fetch");
      print(response.body);
      return false;
    }
  }

  var businessName;

  Future<Map<dynamic, dynamic>> callApis() async {
    var dio = Dio();
    dio.options.baseUrl = 'https://jugaad-sahi-hai.mustansirg.in/';
    dio.options.headers
        .addAll({'authorization': 'Bearer ${UserStore().APIToken}'});

    final response = await dio.get('business/?ticker=aapl');
    if (response.statusCode == 200) {
      businessName = response.data;
      return response.data;
    } else {
      return {};
    }
  }

  var forYouNews;
  Future<List<dynamic>> queryNews() async {
    var dio = Dio();
    dio.options.baseUrl = 'https://jugaad-sahi-hai.mustansirg.in/';
    dio.options.headers
        .addAll({'authorization': 'Bearer $APIToken'});

    final response = await dio.get('/news/');
    if (response.statusCode == 200) {
      forYouNews = response.data;
      print(forYouNews.runtimeType);
      notifyListeners();
      return response.data;
    } else {
      return [];
    }
  }
}
