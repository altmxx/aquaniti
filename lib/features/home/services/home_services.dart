import 'dart:convert';
import 'dart:developer';

import 'package:aquaniti/models/article.dart';
import 'package:aquaniti/sercrets.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  List<Article> _article = [];

  List<Article> get article => _article;

  Future<void> getArticles() async {
    var response = await http.get(
        Uri.parse('https://api.jsonbin.io/v3/b/650ff7b40574da7622af8da1/'),
        headers: {
          "X-Master-Key": Secrets.XMasterKey,
          "X-Access-Key": Secrets.XAccessKey,
        });
    var data = jsonDecode(response.body)['record']['articles'] as List<dynamic>;
    log(data.length.toString());
    for (int i = 0; i < data.length; i++) {
      // log(data[i].toString());
      _article.add(Article.fromMap(data[i]));
    }
    notifyListeners();
    return;
  }
}
