
class Pagination {


/*
		Bu Sınıf API'ye göre hazırlanmıştır.

		 --> ApiModel sınıfı için kullanılır.
		 		 Gelen JSON verisindeki 'pagination' parametresini bir dart nesnesine dönüştürür.
*/


  bool needed;
  int count;
  int page;
  int lastpage;
  int limit;

	Pagination.fromJsonMap(Map<String, dynamic> map): 
		needed = map["needed"],
		count = map["count"],
		page = map["page"],
		lastpage = map["lastpage"],
		limit = map["limit"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['needed'] = needed;
		data['count'] = count;
		data['page'] = page;
		data['lastpage'] = lastpage;
		data['limit'] = limit;
		return data;
	}
}
