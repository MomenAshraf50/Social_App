import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
              margin: const EdgeInsets.all(8),
              child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                const Image(
                  image: NetworkImage(
                      'https://img.freepik.com/free-photo/aesthetic-dark-wallpaper-background-neon-light_53876-128291.jpg?w=740&t=st=1663432158~exp=1663432758~hmac=ae12f6a4d8a81f1590da0374ad5f8c214e1e143c4c40885954f2b92d4ce2b74b'),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Communicate with friends',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white)),
                )
              ]),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder:(context,index) => buildPostItem(context),
              separatorBuilder:(context,index)=>const SizedBox(height: 10,),
              itemCount: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget buildPostItem(BuildContext context) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-photo/young-pretty-woman-portrait-outdoors_624325-2177.jpg?w=740&t=st=1663433131~exp=1663433731~hmac=2d5eb53981e093eb72d68185bdc8ab348e54e324e8253051bbb583ddb2df1b1f'),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Mo\'men Ashraf',
                            style:  TextStyle(height: 1.4),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                        'January 21,2022 at 13:00',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    size: 16,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
          ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            style: TextStyle(height: 1.2),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0,bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: SizedBox(
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        minWidth: 1,
                        child: Text(
                          '#Software',
                          style: Theme.of(context).textTheme.caption!.copyWith(color: defaultColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: SizedBox(
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        minWidth: 1,
                        child: Text(
                          '#Flutter',
                          style: Theme.of(context).textTheme.caption!.copyWith(color: defaultColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/free-photo/young-pretty-woman-portrait-outdoors_624325-2177.jpg?w=740&t=st=1663433131~exp=1663433731~hmac=2d5eb53981e093eb72d68185bdc8ab348e54e324e8253051bbb583ddb2df1b1f'),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Icon(IconBroken.Heart,color: defaultColor,size: 20,),
                        const SizedBox(width: 5,),
                        const Text('1200'),
                      ],
                    ),
                  ),
                  onTap: (){},
                ),
                const Spacer(),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: const [
                        Icon(IconBroken.Chat, color: Colors.amber,size: 20,),
                        SizedBox(width: 5,),
                        Text('521'),
                        Text('comment'),
                      ],
                    ),
                  ),
                  onTap: (){},
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/young-pretty-woman-portrait-outdoors_624325-2177.jpg?w=740&t=st=1663433131~exp=1663433731~hmac=2d5eb53981e093eb72d68185bdc8ab348e54e324e8253051bbb583ddb2df1b1f'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Write a comment ...',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      Icon(IconBroken.Heart,color: defaultColor,size: 20,),
                      const SizedBox(width: 5,),
                      const Text('Like'),
                    ],
                  ),
                ),
                onTap: (){},
              ),
            ],
          )

        ],
      ),
    ),
  );
}
