import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haberkontra1/models/news.dart';
import 'package:haberkontra1/utils/api_details.dart';
import 'package:timeago/timeago.dart' as timeago;


class NewsDetails extends StatefulWidget {

  News haber;


  NewsDetails({@required this.haber});

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {

  bool pinned = false;

  @override
  Widget build(BuildContext context) {

    News haber = widget.haber;
    DateTime olusturulma = DateTime.parse(haber.created_date);

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // AppBar
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                leading: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Entypo.chevron_with_circle_left,
                    size: 30),
                ),
                iconTheme: IconThemeData(
                  color: Colors.red.shade800
                ),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding: EdgeInsets.only(bottom: 14,left: 50),
                    title: Text(
                      "${haber.title}",
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 16,
                        ),
                    ),
                    background: Hero(
                      tag: "${ApiDetails.webSiteUrl}${haber.image}",
                      child: Image.network(
                        "${ApiDetails.webSiteUrl}${haber.image}",
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                // Tarih ve Buttonlar
                Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                    Text(
                      "• ${timeago.format(olusturulma, locale: 'tr')} "
                          "• ${olusturulma.day}/"
                          "${olusturulma.month>10?olusturulma.month:"0"+olusturulma.month.toString()}/"
                          "${olusturulma.year} •",
                      style: TextStyle(
                          color: Colors.grey.shade600
                      ),
                    ),
                    Spacer(),
                    // Link Kopyalama Buttonu
                    IconButton(
                      icon: Icon(
                        Entypo.link,
                        color: Colors.pinkAccent,
                      ),
                      onPressed: (){

                      },
                    ),
                    SizedBox(width: 5),
                    // Paylaşma Buttonu
                    IconButton(
                      icon: Icon(
                        Entypo.share,
                        color: Colors.purple,
                      ),
                      onPressed: (){

                      },
                    ),
                    SizedBox(width: 5),
                    // Sabitleme Buttonu
                    IconButton(
                      icon: Icon(
                        pinned==false?AntDesign.pushpino:AntDesign.pushpin,
                        color: pinned==false?Colors.grey.shade700:Colors.redAccent,
                      ),
                      onPressed: (){
                        if(pinned==false){
                          setState(() {
                            pinned = true;
                          });
                        }else{
                          setState(() {
                            pinned = false;
                          });
                        }
                      },
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 10),

                //Başlık
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "${haber.title}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        letterSpacing: 1.05,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //İçerik
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "${haber.content}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          letterSpacing: 1,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
