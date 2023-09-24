import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../services/news_service.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<Map<String, dynamic>>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = fetchNewsArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Footprint News'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No articles found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return ListTile(
                  title: Text(article['title']),
                  subtitle: Text(article['source']['name']),
                  onTap: () {
                    FlutterWebBrowser.openWebPage(
                      url: article['url'],
                      // androidToolbarColor: Theme.of(context).primaryColor,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
