import 'package:flutter/material.dart';
import 'package:news_time/Theme/app_colors.dart';
import 'package:news_time/widgets/custom_tag.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/image_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const homescreenRoute = "/";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(index: 0),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          )),
      extendBodyBehindAppBar: true,
      body: ListView(
          padding: EdgeInsets.zero,
          children: [_NewsOftheDay(), _BreakingNews()]),
    );
  }
}

class _BreakingNews extends StatelessWidget {
  const _BreakingNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking News',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'More',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.black,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: size.width * 0.4,
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageContainer(
                            width: size.width * 0.4,
                            imageUrl:
                                "https://www.hindustantimes.com/ht-img/img/2023/02/17/550x309/Indian-and-Chinese-soldiers-along-the-Line-of-Actu_1670910862390_1676600712301_1676600712301.jpg",
                            decide: true),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Takimata duo sadipscing erat ut sed dolore takimata sadipscing. Magna.',
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  // color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('${DateTime.now().hour} hours ago',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall!),
                        Text('by Shradha Tiwari',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall!),
                      ]),
                );
              },
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}

class _NewsOftheDay extends StatelessWidget {
  const _NewsOftheDay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.50,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decide: true,
      imageUrl:
          "https://i.guim.co.uk/img/media/fdec7ccbac99e998401759127a3b0109266a91e7/0_372_8640_5184/master/8640.jpg?width=1200&height=630&quality=85&auto=format&fit=crop&overlay-align=bottom%2Cleft&overlay-width=100p&overlay-base64=L2ltZy9zdGF0aWMvb3ZlcmxheXMvdGctbGl2ZS5wbmc&enable=upscale&s=59e90f8c384dde8443cebb9292f5e4e9",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTag(bg: AppColors.grey.withAlpha(150), children: [
            Text(
              'News of the Day',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.white,
                  ),
            )
          ]),
          const SizedBox(
            height: 10,
          ),
          Text('Dolores consetetur ipsum eos invidunt sed sadipscing aliquyam.',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.25)),
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    "Learn More",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    color: AppColors.white,
                  )
                ],
              ))
        ],
      ),
    );
  }
}