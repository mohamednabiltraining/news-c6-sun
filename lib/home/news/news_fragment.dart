import 'package:flutter/material.dart';
import 'package:news_c6_sun/api/api_manager.dart';
import 'package:news_c6_sun/api/model/news_response.dart';
import 'package:news_c6_sun/api/model/sources_response.dart';
import 'package:news_c6_sun/home/categories/categories_fragment.dart';
import 'package:news_c6_sun/home/news/sources_tabs_widget.dart';

class NewsFragment extends StatelessWidget{
  Category category;
  NewsFragment(this.category);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<SourcesResponse>
          (future:ApiManager.getNewsSources(category.id) ,
            builder:(buildContext,snapshot){
            if(snapshot.hasError){
              return Center(child: Text(
                snapshot.error.toString()),
              );
            }else if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            // has data
              var response = snapshot.data;
            if(response?.status =='error'){
              return Center(child: Text(
                  response?.message ?? ""),
              );
            }
            return Expanded(child: SourcesTabs((response?.sources)!));
            } )
      ],
    );
  }
}
