import 'package:flutter/material.dart';
import 'package:upsitizen/theme/color.dart';
import 'package:upsitizen/utils/data.dart';
import 'package:upsitizen/widgets/category_item.dart';
import 'package:upsitizen/widgets/destination_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: getAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => buildBody(),
                childCount: 1,
                // try 2 or 3 to get know more abaout this one
              ),
            )
          ],
        ));
  }

  Widget getAppBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Welcome to",
                style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 3,
              ),
              Text("UPSITIZEN",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  )),
            ],
          )),
          IconButton(
            icon: Image.asset('assets/images/logo.png'),
            onPressed: () {},
          ),
          // NotificationBox(
          //   notifiedNumber: 1,
          //   onTap: () {},
          // )
        ],
      ),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            child: getCategories(),
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
            child: Text("Newly Added",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                )),
          ),
          DestinationCarousel(),
          // getPopulars(),
          const SizedBox(
            height: 50,
          ),
        ]),
      ),
    );
  }

  getCategories() {
    List<Widget> lists = List.generate(
        categories.length,
        (index) => CategoryItem(
              data: categories[index],
              color: listColors[index % 10],
              onTap: () {
                print("tapped");
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FruitDetail(fruitDataModel: Fruitdata[index],)));
              },
            ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  // getPopulars() {
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //       height: 370,
  //       enlargeCenterPage: true,
  //       disableCenter: true,
  //       viewportFraction: .75,
  //     ),
  //     items: List.generate(
  //       populars.length,
  //       (index) => PopularItem(
  //         data: populars[index],
  //         onTap: () {
  //           print("tapped");
  //         },
  //       ),
  //     ),
  //   );
  // }
}
