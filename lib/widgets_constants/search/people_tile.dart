import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:solh/model/search/global_search_model.dart';

import '../../ui/screens/journaling/widgets/solh_expert_badge.dart';
import '../constants/colors.dart';
import '../constants/textstyles.dart';

class PeopleTile extends StatelessWidget {
  const PeopleTile({Key? key, Connection? connection, Function()? onTapped})
      : _connection = connection,
        _onTapped = onTapped,
        super(key: key);
  final Connection? _connection;
  final Function()? _onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTapped,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: SolhColors.grey,
            backgroundImage: CachedNetworkImageProvider(
              _connection!.profilePicture ?? '',
            ),
            radius: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(_connection!.name ?? '',
                      style: SolhTextStyles.JournalingUsernameText,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    height: 12,
                    width: 1,
                    color: SolhColors.grey,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        _connection!.userType == 'SolhVolunteer'
                            ? 'Volunteer'
                            : _connection!.userType == 'SolhProvider'
                                ? 'Counsellor'
                                : '',
                        style: SolhTextStyles.JournalingBadgeText,
                      ),
                      _connection!.userType == 'SolhVolunteer' ||
                              _connection!.userType == 'SolhProvider'
                          ? SolhExpertBadge()
                          : Container()
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: 200,
                  child: Text(
                    _connection!.bio ?? '',
                    style: SolhTextStyles.JournalingHintText,
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
