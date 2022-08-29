import 'dart:convert';

import 'package:news_c6_sun/api/model/news_response.dart';
import 'package:news_c6_sun/api/model/sources_response.dart';
import 'package:http/http.dart' as http;


class ApiManager{
  static const String baseUrl = 'newsapi.org';
  static const String apiKey = '5909ae28122a471d8b0c237d5989cb73';
  static Future<SourcesResponse> getNewsSources(String categoryId)async{
    //category=business&apiKey=API_KEY
    var uri = Uri.https(baseUrl, 'v2/top-headlines/sources',
        { 'apiKey':apiKey,'category':categoryId});
    var response = await http.get(uri);
    var json = jsonDecode(response.body);
    var sourcesResponse = SourcesResponse.fromJson(json);
    if(response.statusCode==200 || response.statusCode==401){
      return sourcesResponse;
    }
    throw Exception((sourcesResponse.message)??'Something went wrong.'
        ' couldnt connect to server');

  }

  static Future<NewsResponse> getNews(String sourceId)async{
    var uri = Uri.https(baseUrl, 'v2/everything',
    {'apiKey':apiKey,'sources':sourceId}
    );
    var response = await http.get(uri);
    var json = jsonDecode(response.body);
    var newsResponse = NewsResponse.fromJson(json);
    return newsResponse;
  }
}