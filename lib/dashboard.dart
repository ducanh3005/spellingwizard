import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'categoryview.dart';
import 'package:SpellingWizard/save.dart';

class GridDashboard extends StatefulWidget {
  final List<Items> myList;
  GridDashboard(this.myList);
  @override
  GridDashboardState createState() => GridDashboardState();
}

class GridDashboardState extends State<GridDashboard> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: widget.myList.map((data) {
            return Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              child: InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            maintainState: true,
                            builder: (BuildContext context) => CategoryView(
                                  title: data.title,
                                  itemCount: int.parse(data.event),
                                  saveFile: data.saveFile,
                                ))).then((value) async {
                      SaveFile saveTmp = await saveFileOfCategory(data.title);
                      setState(() {
                        data.saveFile = saveTmp;
                      });
                    });
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [
                              0.01,
                              1
                            ],
                            colors: [
                              Colors.deepPurpleAccent[700],
                              Colors.purpleAccent[700]
                            ]),
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
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          data.subtitle,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.w100,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.event,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.w100,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  )),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  SaveFile saveFile;

  Items({this.title, this.subtitle, this.event, this.img, this.saveFile});
}

Future<List<Items>> categoryList() async {
  Items item1 = new Items(
    title: "Verbs",
    subtitle: "Verbs are essential",
    event: "6",
    img: "assets/verbs_category.png",
    saveFile: await saveFileOfCategory("Verbs"),
  );

  Items item2 = new Items(
    title: "Family",
    subtitle: "",
    event: "3",
    img: "assets/family_category.png",
    saveFile: await saveFileOfCategory("Family"),
  );
  Items item3 = new Items(
    title: "Tools",
    subtitle: "",
    event: "6",
    img: "assets/tools_category.png",
    saveFile: await saveFileOfCategory("Tools"),
  );
  Items item4 = new Items(
    title: "Animals",
    subtitle: "",
    event: "6",
    img: "assets/animals_category.png",
    saveFile: await saveFileOfCategory("Animals"),
  );
  Items item5 = new Items(
    title: "Abstract",
    subtitle: "these are hard",
    event: "2",
    img: "assets/abstract_category.png",
    saveFile: await saveFileOfCategory("Abstract"),
  );

  return [item1, item2, item3, item4, item5];
}

Column homePage(List<Items> items) {
  return Column(children: <Widget>[
    SizedBox(
      height: 80,
    ),
    Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Spelling Wizard",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
              SizedBox(
                height: 4,
              ),
              Text(
                "Challenges",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.w100,
                    color: Colors.white),
              ),
            ],
          )
        ],
      ),
    ),
    SizedBox(
      height: 40,
    ),
    GridDashboard(items),
  ]);
}
