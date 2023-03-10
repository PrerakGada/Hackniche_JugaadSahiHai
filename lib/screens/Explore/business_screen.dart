import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_time/screens/graph_screen.dart';

import '../../Theme/app_colors.dart';
import '../../stores/user_store.dart';
import '../../widgets/image_container.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  static const id = "/businessRoute";

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  var businessName = {};
  final List<String> strings = [
    'ADANIENT',
    'ADANIPORTS',
    'HDFCLIFE',
    'DIVISLAB',
    'SBILIFE',
    'SBIN',
    'INDUSINDBK',
    'UPL',
    'BAJFINANCE',
    'TECHM'
  ];

  Future<List<dynamic>> callBusinessNews() async {
    var dio = Dio();
    dio.options.baseUrl = 'https://jugaad-sahi-hai.mustansirg.in/';
    dio.options.headers
        .addAll({'authorization': 'Bearer ${UserStore().APIToken}'});

    final response = await dio.get('business/?ticker=AAPL');
    if (response.statusCode == 200) {
      // businessName = response.data["articles"];
      return response.data["articles"];
    } else {
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    UserStore().callApis();
    UserStore().RefreshToken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Search',
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.grey,
                  ),
                  suffixIcon: const RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.tune,
                      color: AppColors.grey,
                    ),
                  )),
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            SizedBox(
              height: 70,
              width: 500,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Chip(
                      label: Text(
                        strings[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blueGrey,
                      elevation: 4.0,
                      shadowColor: Colors.grey[50],
                    ),
                  );
                },
                itemCount: strings.length,
              ),
            ),
            // Wrap(
            //   spacing: 8.0, // gap between adjacent chips
            //   runSpacing: 1.0, // gap between lines
            //   children: strings
            //       .map((string) => )
            //       .toList(),
            // ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                // ImageContainer(
                //   width: 80,
                //   imageUrl: "${UserStore().businessName["info"]["logo_url"]}",
                //   height: 90,
                //   decide: true,
                // ),
                SizedBox(
                  width: 10,
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       '${UserStore().businessName["info"]["Name"]}',
                //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //           color: AppColors.black, fontWeight: FontWeight.bold),
                //     ),
                //     Text(
                //       '${UserStore().businessName["info"]["CIK"]} Employees',
                //       maxLines: 1,
                //       overflow: TextOverflow.ellipsis,
                //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
                //             color: AppColors.black,
                //           ),
                //     ),
                //     SizedBox(
                //       width: 250,
                //       height: 80,
                //       child: Text(
                //         '${UserStore().businessName["info"]["Description"]}.',
                //         maxLines: 3,
                //         overflow: TextOverflow.fade,
                //         style: Theme.of(context).textTheme.bodySmall!.copyWith(
                //             color: AppColors.black,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
            Row(
              children: [
                RichText(
                  // Controls visual overflow
                  overflow: TextOverflow.clip,

                  // Controls how the text should be aligned horizontally
                  textAlign: TextAlign.end,

                  // Control the text direction
                  textDirection: TextDirection.rtl,

                  // Whether the text should break at soft line breaks
                  softWrap: true,

                  // Maximum number of lines for the text to span
                  maxLines: 1,

                  // The number of font pixels for each logical pixel
                  textScaleFactor: 1,
                  text: TextSpan(
                    text: 'Trending News From ',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColors.black, fontWeight: FontWeight.bold),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Apple',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 22)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 220,
              child: FutureBuilder(
                future: callBusinessNews(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          // gridDelegate:
                          //     const SliverGridDelegateWithFixedCrossAxisCount(
                          //         crossAxisCount: 2,
                          //         mainAxisExtent: 230,
                          //         crossAxisSpacing: 12,
                          //         mainAxisSpacing: 12,
                          //         childAspectRatio: 20),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width: size.width * 0.5,
                              height: 50,
                              padding: const EdgeInsets.only(right: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ImageContainer(
                                        width: size.width * 0.4,
                                        imageUrl:
                                            "${snapshot.data![index]["urlToImage"]}",
                                        decide: true),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${snapshot.data![index]["title"]}',
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              // color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                              height: 1.5),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('${DateTime.now().hour} hours ago',
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!),
                                    Text(
                                        '${snapshot.data![index]["source"]["name"]}',
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!),
                                  ]),
                            );
                            // return Container(
                            //   width: size.width * 0.1,
                            //   height: 100,
                            //   padding: EdgeInsets.only(right: 10),
                            //   child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         ImageContainer(
                            //             width: size.width * 0.4,
                            //             imageUrl:
                            //                 "${snapshot.data![index]["urlToImage"]}",
                            //             decide: true),
                            //         const SizedBox(
                            //           height: 10,
                            //         ),
                            //         Text(
                            //           '${snapshot.data![index]["title"]}',
                            //           maxLines: 2,
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodyLarge!
                            //               .copyWith(
                            //                   // color: AppColors.black,
                            //                   fontWeight: FontWeight.bold,
                            //                   height: 1.5),
                            //         ),
                            //         const SizedBox(
                            //           height: 5,
                            //         ),
                            //         Text('${DateTime.now().hour} hours ago',
                            //             maxLines: 2,
                            //             style: Theme.of(context)
                            //                 .textTheme
                            //                 .bodySmall!),
                            //         Text(
                            //             '${snapshot.data![index]["source"]["name"]}',
                            //             maxLines: 2,
                            //             style: Theme.of(context)
                            //                 .textTheme
                            //                 .bodySmall!),
                            //       ]),
                            // );
                          },
                          itemCount: 20,
                        );
                      } else {
                        return const Text("No data yet");
                      }
                  }
                },
              ),
              // child:
            ),
            // RichText(
            //   // Controls visual overflow
            //   overflow: TextOverflow.clip,

            //   // Controls how the text should be aligned horizontally
            //   textAlign: TextAlign.end,

            //   // Control the text direction
            //   textDirection: TextDirection.rtl,

            //   // Whether the text should break at soft line breaks
            //   softWrap: true,

            //   // Maximum number of lines for the text to span
            //   maxLines: 1,

            //   // The number of font pixels for each logical pixel
            //   textScaleFactor: 1,
            //   text: TextSpan(
            //     text: 'Charts ',
            //     style: Theme.of(context).textTheme.headline6!.copyWith(
            //         color: AppColors.black, fontWeight: FontWeight.bold),
            //     children: const <TextSpan>[
            //       // TextSpan(
            //       //     text: '',
            //       //     style: TextStyle(
            //       //         fontWeight: FontWeight.bold,
            //       //         color: Colors.red,
            //       //         fontSize: 22)),
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Charts',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    print(UserStore().businessName["stock"]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GraphScreen(
                                  data: UserStore().businessName["stock"],
                                )));
                  },
                  child: Text(
                    'More ->',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const ImageContainer(
              width: double.infinity,
              height: 250,
              imageUrl:
                  "https://res.cloudinary.com/practicaldev/image/fetch/s--HrcWs6QD--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/3cd67f80gv7lf1s408o0.png",
              decide: true,
            )
          ],
        ),
      ),
    );
  }
}
