import 'package:flutter/material.dart';
import 'package:news_c6_sun/api/api_manager.dart';
import 'package:news_c6_sun/api/model/news_response.dart';
import 'package:news_c6_sun/api/model/sources_response.dart';
import 'package:news_c6_sun/home/news/news_widget.dart';

class NewsList extends StatelessWidget {

  Source source;
  NewsList(this.source);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse>(
      future: ApiManager.getNews(source.id ??''),
      builder: (_,snapshot){
        if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()));
        }
        else if (snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        var data = snapshot.data;
        if("error" == data?.status){
          return Center(child: Text(data?.message??""),);
        }
        return Expanded(
          child: ListView.builder(itemBuilder:(_,index){
            return NewsWidget((data?.articles![index])!);
          },itemCount: data?.articles?.length ??0, ),
        );
      },
    );
  }
}
