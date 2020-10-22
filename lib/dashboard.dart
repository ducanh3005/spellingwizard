import 'package:flutter/material.dart';
import 'categoryview.dart';
import 'package:SpellingWizard/save.dart';
import 'dart:io';

class GridDashboard extends StatefulWidget {
  @override
  GridDashboardState createState() => GridDashboardState();
}

class GridDashboardState extends State {
  Items item1 = new Items(
      title: "Verbs",
      subtitle: "Verbs are essential",
      event: "6",
      img: "assets/verbs_category.png");

  Items item2 = new Items(
    title: "Family",
    subtitle: "",
    event: "3",
    img: "assets/family_category.png",
  );
  Items item3 = new Items(
    title: "Tools",
    subtitle: "",
    event: "6",
    img: "assets/tools_category.png",
  );
  Items item4 = new Items(
    title: "Animals",
    subtitle: "",
    event: "6",
    img: "assets/animals_category.png",
  );
  Items item5 = new Items(
    title: "Abstract",
    subtitle: "these are hard",
    event: "2",
    img: "assets/abstract_category.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return InkWell(
                onTap: () async {
                  // load save files for the category
                  final path = await savePath();
                  final file = File('$path/${data.title}.csv');
                  final SaveFile saveFile = SaveFile(file: file);
                  await saveFile.readFromFile();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryView(
                        title: '${data.title}',
                        itemCount: int.parse(data.event),
                        color: Colors.purple[500],
                        saveFile: saveFile,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.purple, Colors.orange[900]]),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        data.img,
                        width: 42,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.title,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        data.subtitle,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w100,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        data.event,
                      ),
                    ],
                  ),
                ));
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}