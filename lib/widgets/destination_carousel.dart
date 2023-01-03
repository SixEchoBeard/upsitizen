import 'package:flutter/material.dart';
import 'package:upsitizen/model/destination_model.dart';
import 'package:upsitizen/screen/destination_screen.dart';

class DestinationCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              // Text(
              //   'Top Destinations',
              //   style: TextStyle(
              //     fontSize: 22.0,
              //     fontWeight: FontWeight.bold,
              //     letterSpacing: 1.5,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () => print('See All'),
              //   child: Text(
              //     'See All',
              //     style: TextStyle(
              //       color: Theme.of(context).primaryColor,
              //       fontSize: 16.0,
              //       fontWeight: FontWeight.w600,
              //       letterSpacing: 1.0,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Container(
          height: 400.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: destinations.length,
            itemBuilder: (BuildContext context, int index) {
              Destination destination = destinations[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DestinationScreen(
                      destination: destination,
                    ),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 220.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 5.0,
                        child: Container(
                          height: 200.0,
                          width: 220.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Text(
                                //   '${destination.activities.length} activities',
                                //   style: TextStyle(
                                //     fontSize: 22.0,
                                //     fontWeight: FontWeight.w600,
                                //     letterSpacing: 1.2,
                                //   ),
                                // ),
                                Text(
                                  destination.description,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Hero(
                              tag: destination.imageUrl,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  height: 250.0,
                                  width: 220.0,
                                  image: AssetImage(destination.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10.0,
                              bottom: 10.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    destination.city,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  // Row(
                                  //   children: <Widget>[
                                  //     Icon(
                                  //       FontAwesomeIcons.locationArrow,
                                  //       size: 10.0,
                                  //       color: Colors.white,
                                  //     ),
                                  //     SizedBox(width: 5.0),
                                  //     Text(
                                  //       destination.country,
                                  //       style: TextStyle(
                                  //         color: Colors.white,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
