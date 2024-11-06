import 'package:flutter/material.dart';
import 'package:news_app/modal/news_modal.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key, this.articles});

  final Articles? articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
        IconButton(onPressed: (){
          Share.share(articles?.title??'', subject:articles?.description??'');
        }, icon:const Icon(Icons.share)),
        ],
        title: const Text(
          "contort news",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon:const Icon(Icons.arrow_back_ios_new_outlined,
            size: 20,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(articles?.urlToImage??''),
            Expanded(child: Text(articles?.description??'https://images.unsplash.com/photo-1730461749346-d75ee4d30aa1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4fHx8ZW58MHx8fHx8')),
          Text(articles?.content??'')
          ],
        ),
      ),
    );
  }
}
