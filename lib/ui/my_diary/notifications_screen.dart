import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  List<Map> dummyJson = [
    {
      'mediaUrl': 'https://picsum.photos/200',
      'type': 'connectionPost',
      'causedBy': 'Priyanka',
      'time': '2 hours ago'
    },
    {
      'mediaUrl': 'https://picsum.photos/200',
      'type': 'connectionRequest',
      'causedBy': 'Priyanka',
      'time': 'Yesterday'
    },
    {
      'mediaUrl': 'https://picsum.photos/200',
      'type': 'connectionAccept',
      'causedBy': 'Priyanka',
      'time': '2 hours ago'
    },
    {
      'mediaUrl': 'https://picsum.photos/200',
      'causedByMediaUrl': 'https://picsum.photos/200',
      'type': 'GroupCreation',
      'groupName': 'Stress busters',
      'time': '2 hours ago'
    },
    {
      'mediaUrl': 'https://picsum.photos/200',
      'causedByMediaUrl': 'https://picsum.photos/200',
      'groupName': 'Stress busters',
      'type': 'GroupPost',
      'causedBy': 'Priyanka',
      'time': '2 hours ago'
    },
    {
      'mediaUrl': 'https://picsum.photos/200',
      'type': 'solhWish',
      'wish': 'Happy Diwali(title) (Body) lorem ipsum this Diwali',
      'time': '2 hours ago'
    },
    {
      'mediaUrl': 'https://picsum.photos/200',
      'type': 'congrats',
      'body':
          'Congratulations ! one of your post in  solh’s trending section. click to view',
      'time': '2 hours ago'
    },
    {
      'mediaUrl': 'https://picsum.photos/200',
      'type': 'sessionReminder',
      'body':
          'Congratulations ! one of your post in  solh’s trending section. click to view',
      'time': '2 hours ago'
    },
    {
      'mediaUrl': 'https://picsum.photos/200',
      'type': 'sessionReminder',
      'body':
          'Session Reminder, Your Sesseion is scheduled for Tommorow with DR. Priyanka Tripathi',
      'time': '2 hours ago'
    },
    {
      'mediaUrl': 'https://picsum.photos/200',
      'type': 'sessionReminder2',
      'body':
          'Session Reminder, Your Sesseion is about to start in 15 mins with DR. Priyanka Tripathi',
      'time': '2 hours ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          'Notification',
          style: GoogleFonts.signika(
            color: SolhColors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: dummyJson.length,
        itemBuilder: ((context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getNotificationTile(dummyJson[index]),
                SizedBox(
                  height: 18,
                ),
                GetHelpDivider(),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget getNotificationTile(Map item) {
    if (item['type'] == 'connectionPost') {
      return Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item['mediaUrl']),
            radius: 30,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  children: [
                    Text(item['causedBy']),
                    Text(' shared '),
                    Text('new Post')
                  ],
                ),
                Text(
                  item['time'],
                  style: GoogleFonts.signika(
                    color: Color(0xff666666),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
        ],
      );
    }
    if (item['type'] == 'connectionRequest') {
      return Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item['mediaUrl']),
            radius: 30,
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  Text(item['causedBy']),
                  Text(' sent you '),
                  Text('connection request')
                ],
              ),
              Text(
                item['time'],
                style: GoogleFonts.signika(
                  color: Color(0xff666666),
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      );
    }
    if (item['type'] == 'connectionAccept') {
      return Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item['mediaUrl']),
            radius: 30,
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  Text('Connection request accepted'),
                  Text(' by '),
                  Text(item['causedBy'])
                ],
              ),
              Text(
                item['time'],
                style: GoogleFonts.signika(
                  color: Color(0xff666666),
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      );
    }
    if (item['type'] == 'GroupCreation') {
      return Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(item['mediaUrl']),
                radius: 30,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(item['causedByMediaUrl']),
                    radius: 10,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(item['groupName']),
                    Text(' New Group Created '),
                    Text('you may find it helpful')
                  ],
                ),
                Text(
                  item['time'],
                  style: GoogleFonts.signika(
                    color: Color(0xff666666),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
        ],
      );
    }
    if (item['type'] == 'GroupPost') {
      return Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(item['mediaUrl']),
                radius: 30,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(item['causedByMediaUrl']),
                    radius: 10,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Text(item['causedBy']),
                  Text(' shared a '),
                  Text('New post '),
                  Text(' in '),
                  Text(item['groupName'])
                ],
              ),
              Text(
                item['time'],
                style: GoogleFonts.signika(
                  color: Color(0xff666666),
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      );
    }
    if (item['type'] == 'solhWish') {
      return Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item['mediaUrl']),
            radius: 30,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(item['wish']),
                  ],
                ),
                Text(
                  item['time'],
                  style: GoogleFonts.signika(
                    color: Color(0xff666666),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
        ],
      );
    }
    if (item['type'] == 'congrats') {
      return Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item['mediaUrl']),
            radius: 30,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(item['body']),
                  ],
                ),
                Text(
                  item['time'],
                  style: GoogleFonts.signika(
                    color: Color(0xff666666),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
        ],
      );
    }
    if (item['type'] == 'sessionReminder') {
      return Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item['mediaUrl']),
            radius: 30,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(item['body']),
                  ],
                ),
                Text(
                  item['time'],
                  style: GoogleFonts.signika(
                    color: Color(0xff666666),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
        ],
      );
    }
    if (item['type'] == 'sessionReminder2') {
      return Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item['mediaUrl']),
            radius: 30,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(item['body']),
                  ],
                ),
                Text(
                  item['time'],
                  style: GoogleFonts.signika(
                    color: Color(0xff666666),
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
