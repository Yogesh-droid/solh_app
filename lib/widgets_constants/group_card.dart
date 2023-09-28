import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'constants/colors.dart';

class GroupCard extends StatelessWidget {
  const GroupCard(
      {Key? key,
      required Function() onTap,
      String? id,
      int? membersCount,
      String? groupMediaUrl,
      String? groupName,
      int? journalCount})
      : _onTap = onTap,
        _id = id,
        _groupMediaUrl = groupMediaUrl,
        _groupName = groupName,
        _journalCount = journalCount,
        _memberCount = membersCount,
        super(key: key);
  final Function() _onTap;
  final String? _id;
  final String? _groupMediaUrl;
  final String? _groupName;
  final int? _memberCount;
  final int? _journalCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        InkWell(
          onTap: _onTap,
          child: Hero(
            tag: _id ?? '',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: double.infinity,
                  color: SolhColors.primary_green,
                  child: Container(
                    height: 300,
                    child: _groupMediaUrl != null
                        ? CachedNetworkImage(
                            imageUrl: _groupMediaUrl ?? '',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/group_placeholder.png',
                            fit: BoxFit.cover,
                          ),
                  )),
            ),
          ),
        ),
        // Positioned(
        //     top: 10,
        //     right: 10,
        //     child: Row(children: [
        //       Container(
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: SolhColors.black.withOpacity(0.2),
        //         ),
        //         child: Transform(
        //             alignment: Alignment.center,
        //             transform: Matrix4.rotationY(math.pi),
        //             child: Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child:
        //                   Icon(Icons.reply, color: SolhColors.white, size: 20),
        //             )),
        //       ),
        //       SizedBox(width: 10),
        //       Container(
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: SolhColors.black.withOpacity(0.2),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Icon(Icons.share, color: SolhColors.white, size: 20),
        //         ),
        //       )
        //     ])),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _groupName ?? '',
                    style: SolhTextStyles.QS_big_body.copyWith(
                        color: SolhColors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //Image.asset('assets/icons/group/lock.png'),
                          Icon(
                            Icons.public,
                            color: SolhColors.white,
                            size: 10,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Public',
                            style: TextStyle(
                              color: SolhColors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('|', style: TextStyle(color: SolhColors.white)),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.person_3_fill,
                            color: SolhColors.white,
                            size: 15,
                          ),
                          SizedBox(width: 5),
                          _memberCount != null
                              ? Text(_memberCount!.toString() + ' members',
                                  style: TextStyle(
                                    color: SolhColors.white,
                                    fontSize: 12,
                                  ))
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('|', style: TextStyle(color: SolhColors.white)),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/get_help/post.svg',
                            height: 10,
                          ),
                          SizedBox(width: 5),
                          _journalCount != null
                              ? Text(_journalCount.toString() + ' posts',
                                  style: TextStyle(
                                    color: SolhColors.white,
                                    fontSize: 12,
                                  ))
                              : Container(),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
