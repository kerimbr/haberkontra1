import 'package:haberkontra1/models/news.dart';
import 'package:haberkontra1/models/pagination.dart';

class ApiModel {

	/*
		Bu Sınıf API'ye göre hazırlanmıştır.

		 --> Gelen JSON verisini Map verisine çevirerek bize bir Nesne vermektedir.
				 Bu işlemi 'ApiModel.fromJsonMap' Named Constructor ile yapmaktadır.
				 Veri Çekme işlemiinde bu Constructor kullanılır.


	*/


  List<Object> search;
  Pagination pagination;
  List<News> news;

	ApiModel.fromJsonMap(Map<String, dynamic> map): 
		search = map["search"],
		pagination = Pagination.fromJsonMap(map["pagination"]),
		news = List<News>.from(map["news"].map((it) => News.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['search'] = search;
		data['pagination'] = pagination == null ? null : pagination.toJson();
		data['news'] = news != null ? 
			this.news.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
