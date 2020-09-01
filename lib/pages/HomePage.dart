import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haberkontra1/models/api_model.dart';
import 'package:haberkontra1/utils/api_details.dart';
import 'package:haberkontra1/widgets/news_card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  // API Servisinden Tüm JSON verisini al ve ApiModel Nesnesine dönüştür.
  Future<ApiModel> getData() async {
    //    // HTTP GET isteği ile veriyi Çek
    var response = await http.get(ApiDetails.apiUrl);

    // HTTP Durum Kodunu İncele
    if(response.statusCode == 200){
      // Veri Çekme Başarılı İse ApiModel.fromJsonMap Constructor'ı ile ApiModel nesnesi oluştur ve dönder.
      return ApiModel.fromJsonMap(json.decode(response.body));
    }else{
      // veri Çekme Başarısız ise Bir Hata Fırlat
      throw Exception("getData (response error code) [HOMEPAGE] : "+response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    // getData() metodunu bekle
    return FutureBuilder<ApiModel>(
      future: getData(),
      builder:(context,snapshot){

        /*
            snapshot : AsyncSnapshot<ApiModel> nesnesidir.

            snapshot.data : Future işlemi bittikten sonra geri dönen veridir.
                            Veri Türü ApiModel Nesnesidir.
        */
        if(snapshot.hasData){
          // Eğer getData metodundan geri dönen veri var ise burayı çalıştır.

          return DefaultTabController(
            length: 5,
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Feather.align_left,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: (){
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                title: Text(
                  "Haber Kontra",
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1.1
                  ),
                ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: (){

                    },
                  )
                ],
                bottom: TabBar(
                  labelColor: Colors.black,
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(text: "Ana Sayfa",icon: Icon(FontAwesome.newspaper_o)),
                    Tab(text: "Futbol",icon: Icon(Ionicons.ios_football)),
                    Tab(text: "Basketbol",icon: Icon(Ionicons.ios_basketball)),
                    Tab(text: "Voleybol",icon: Icon(FlutterIcons.volleyball_mco)),
                    Tab(text: "Diğer Haberler",icon: Icon(MaterialCommunityIcons.newspaper_variant_multiple_outline)),

                  ],
                ),
              ),
              drawer: drawerWidget(),
              body: TabBarView(
                children: <Widget>[
                  anaSayfa(snapshot.data),
                  futbol(snapshot.data),
                  basketbol(snapshot.data),
                  voleybol(snapshot.data),
                  digerhaberler(snapshot.data)
                ],
              ),
            ),
          );
        }else{
          // Eğer getData metodundan geri dönen veri yok ise burayı çalıştır.

          return Scaffold(
            body: Center(child: CupertinoActivityIndicator()),
          );
        }
      } ,
    );

  }

  // 'Ana Sayfa' Sayfasını Oluştur.
  Widget anaSayfa(ApiModel snapshot){
    return ListView.separated(
      itemCount: snapshot.news.length,
      separatorBuilder: (context,i){
        return Divider();
      },
      itemBuilder: (context,index){
        return NewsCard(haber: snapshot.news[index],kategori: "Ana Sayfa",);
      },
    );
  }

  // 'Futbol' Sayfasını Oluştur.
  Widget futbol(ApiModel snapshot){
    return ListView.separated(
      itemCount: snapshot.news.length,
      separatorBuilder: (context,i){
        return Divider();
      },
      itemBuilder: (context,index){
        return NewsCard(haber: snapshot.news[index],kategori: "Futbol",);
      },
    );
  }

  // 'Basketbol' Sayfasını Oluştur.
  Widget basketbol(ApiModel snapshot){
    return ListView.separated(
      itemCount: snapshot.news.length,
      separatorBuilder: (context,i){
        return Divider();
      },
      itemBuilder: (context,index){
        return NewsCard(haber: snapshot.news[index],kategori: "Basketbol",);
      },
    );

  }

  // 'Voleybol' Sayfasını Oluştur.
  Widget voleybol(ApiModel snapshot){
    return ListView.separated(
      itemCount: snapshot.news.length,
      separatorBuilder: (context,i){
        return Divider();
      },
      itemBuilder: (context,index){
        return NewsCard(haber: snapshot.news[index],kategori: "Voleybol",);
      },
    );

  }

  // 'Diğer Haberler' Sayfasını Oluştur.
  Widget digerhaberler(ApiModel snapshot){
    return ListView.separated(
      itemCount: snapshot.news.length,
      separatorBuilder: (context,i){
        return Divider();
      },
      itemBuilder: (context,index){
        return NewsCard(haber: snapshot.news[index],kategori: "Diğer Haberler",);
      },
    );

  }

  Widget drawerWidget() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 51),
          //Logo
          CircleAvatar(
            radius: 62,
            child: Image.asset("assets/img/kontra_logo.png"),
          ),
          SizedBox(height: 10),
          Text(
            "Haber Kontra",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 50),

          Divider(),
          //Ekibimiz
          ListTile(
            onTap: (){

            },
            leading: Icon(
              Feather.users,
              color: Colors.redAccent,
            ),
            title: Text(
                "Ekibimiz",
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey.shade600
              ),
            ),
          ),
          //İletişim
          ListTile(
            onTap: (){

            },
            leading: Icon(
              AntDesign.contacts,
              color: Colors.redAccent,
            ),
            title: Text(
              "İletişim",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey.shade600
              ),
            ),
          ),
          Divider(),

          //Instagram
          ListTile(
            onTap: (){

            },
            leading: Icon(
              Entypo.instagram,
              color: Colors.pink,
            ),
            title: Text(
              "Instagram",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey.shade600
              ),
            ),
          ),
          //Twitter
          ListTile(
            onTap: (){

            },
            leading: Icon(
              AntDesign.twitter,
              color: Colors.blue,
            ),
            title: Text(
              "Twitter",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey.shade600
              ),
            ),
          ),
          //youtube
          ListTile(
            onTap: (){

            },
            leading: Icon(
              AntDesign.youtube,
              color: Colors.redAccent,
            ),
            title: Text(
              "Youtube",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey.shade600
              ),
            ),
          ),
          //Facebook
          ListTile(
            onTap: (){

            },
            leading: Icon(
              AntDesign.facebook_square,
              color: Colors.blue,
            ),
            title: Text(
              "Facebook",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey.shade600
              ),
            ),
          ),
        ],
      ),
    );
  }


}
