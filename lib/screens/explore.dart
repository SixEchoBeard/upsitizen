import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:upsitizen/theme/color.dart';
import 'package:upsitizen/utils/data.dart';
import 'package:upsitizen/widgets/explore_item.dart';
import 'package:upsitizen/widgets/round_textbox.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
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
              ),
            )
          ],
        ));
  }

  // App bar only
  Widget getAppBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Explore",
                style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )),
          IconButton(
            icon: Image.asset('assets/images/logo.png'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  buildBody() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 10,
      ),
      Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: RoundTextBox(
            hintText: "Search",
            prefixIcon: const Icon(Icons.search, color: darker),
          )),
      // SizedBox(
      //   height: 20,
      // ),
      // getCategories(),
      const SizedBox(
        height: 15,
      ),
      Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: getPlaces(),
      ),
      const SizedBox(
        height: 50,
      ),
    ]));
  }

  int selectedIndex = 0;
  // getCategories() {
  //   List<Widget> lists = List.generate(
  //       exploreCategories.length,
  //       (index) => ExploreCategoryItem(
  //             data: exploreCategories[index],
  //             selected: index == selectedIndex,
  //             onTap: () {
  //               setState(() {
  //                 selectedIndex = index;
  //               });
  //             },
  //           ));
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     padding: EdgeInsets.only(bottom: 5, left: 15),
  //     child: Row(children: lists),
  //   );
  // }

  getPlaces() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      itemCount: countries.length,
      itemBuilder: (BuildContext context, int index) => ExploreItem(
          data: countries[index],
          onTap: () {
            print("tapped");
          }),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 3 : 2),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    );
  }
}
