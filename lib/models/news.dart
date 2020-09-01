
/*
		Bu Sınıf API'ye göre hazırlanmıştır.

		 --> ApiModel sınıfı için kullanılır.
		 		 Gelen JSON verisindeki 'news' parametresini bir dart nesnesine dönüştürür.
*/


class News {

  String id;
  String title;
  String content;
  String image;
  String link;
  String video_link;
  String created_date;
  String updated_date;
  String is_home_banner;

	News.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		title = map["title"],
		content = map["content"],
		image = map["image"],
		link = map["link"],
		video_link = map["video_link"],
		created_date = map["created_date"],
		updated_date = map["updated_date"],
		is_home_banner = map["is_home_banner"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['title'] = title;
		data['content'] = content;
		data['image'] = image;
		data['link'] = link;
		data['video_link'] = video_link;
		data['created_date'] = created_date;
		data['updated_date'] = updated_date;
		data['is_home_banner'] = is_home_banner;
		return data;
	}
}
