import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/params/article_request.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/articles_repository.dart';
import '../datasources/remote/news_api_service.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final NewsApiService _newsApiService;

  const ArticlesRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<Article>>> getBreakingNewsArticles(
      ArticlesRequestParams? params) async {
    try {
      final httpResponse = await _newsApiService.getBreakingNewsArticles(
          apiKey: params != null ? params.apiKey : '',
          country: params != null ? params.country : '',
          category: params != null ? params.category : '',
          page: params != null ? params.page : 0,
          pageSize: params != null ? params.pageSize : 0);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // return DataSuccess(httpResponse.data.articles);
        return DataState(
            data: httpResponse.data.articles,
            error: DioError(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                requestOptions: httpResponse.response.requestOptions,
                type: DioErrorType.response));
      }
      return DataState(
          data: [],
          error: DioError(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              requestOptions: httpResponse.response.requestOptions,
              type: DioErrorType.response));
    } on DioError catch (e) {
      return DataState(data: [], error: e);
    }
  }
}
