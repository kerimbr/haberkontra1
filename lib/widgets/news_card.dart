import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haberkontra1/models/news.dart';
import 'package:haberkontra1/pages/news_details.dart';
import 'package:haberkontra1/utils/api_details.dart';
import 'package:timeago/timeago.dart' as timeago;


class NewsCard extends StatefulWidget {

  News haber;


  NewsCard({@required this.haber});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {

  bool pinned = false;

  @override
  Widget build(BuildContext context) {

    News haber = widget.haber;
    DateTime olusturulma = DateTime.parse(haber.created_date);

    return Container(
      width: MediaQuery.of(context).size.width,
      //color: Colors.white,
      child: GestureDetector(
        onTap: (){
          Route r = MaterialPageRoute(
            builder: (context)=>NewsDetails(haber: haber)
          );
          Navigator.push(context, r);
        },
        child: Column(
          children: <Widget>[


            // Görsel
            Hero(
              tag: "${ApiDetails.webSiteUrl}${haber.image}",
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.network(
                    "${ApiDetails.webSiteUrl}${haber.image}",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(height: 10),

            //Başlık ve İçerik Özeti
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "${haber.title}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: Text(
                "${haber.content}",
                overflow: TextOverflow.clip,
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
            SizedBox(height: 10),

            //Footer
            // Ne Zaman Yayınlandı
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
                SizedBox(width: 20),
              ],
            )

          ],
        ),
      ),
    );
  }



}
