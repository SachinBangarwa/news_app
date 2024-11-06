import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/favourite_provider.dart';
import 'package:news_app/modal/news_details.dart';
import 'package:news_app/modal/news_modal.dart';
import 'package:provider/provider.dart';

class NewsAppScreen extends StatefulWidget {
  const NewsAppScreen({super.key});

  @override
  State<NewsAppScreen> createState() => _NewsAppScreenState();
}

class _NewsAppScreenState extends State<NewsAppScreen> {


  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Demo app",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              FavouriteProvider provider = Provider.of<FavouriteProvider>(context,listen:false);
              List<Articles>? fetchedResults = await fetchData();
              if (fetchedResults != null) {
                provider.getResult(fetchedResults);
              }
            },
            icon: const Icon(Icons.backup),
          )
        ],
      ),
      body: Column(
        children: [
          Consumer<FavouriteProvider>(
            builder: (context,provider,child){
              return  Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, value) => Divider(
                    height: 1,
                    color: Colors.red.withOpacity(0.25),
                  ),
                  itemCount: provider.resultList.length,
                  itemBuilder: (context, index) {
                    Articles value = provider.resultList[index];
                    return ListTile(
                      title: Text(value.title ?? 'No Title'),
                      subtitle: Text(value.author ?? 'No Description'),
                      leading: Image.network(
                        value.urlToImage ??
                            'https://images.unsplash.com/photo-1730461749346-d75ee4d30aa1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4fHx8ZW58MHx8fHx8',
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return NewsDetails(articles: value);
                            }));
                      },
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<List<Articles>?> fetchData() async {
    String url =
        'https://newsapi.org/v2/everything?q=tesla&from=2024-10-05&sortBy=publishedAt&apiKey=ed8e4e30e3a14790a6474ff86851bfbe';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String str = response.body;
      final json = jsonDecode(str);
      newsResponse responseResult = newsResponse.fromJson(json);
      return responseResult.articles ?? [];
    } else {
      print("Failed with status code: ${response.statusCode}");
    }
  }
}
