import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                  _connection!.userType != 'Seeker'
                      ? Container(
                          height: 12,
                          width: 1,
                          color: SolhColors.grey,
                        )
                      : Container(),
                  SizedBox(
                    width: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        getUserType(_connection!.userType ?? ''),
                        style: SolhTextStyles.JournalingBadgeText,
                      ),
                      getUserBadge(_connection!.userType!)
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
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

String getUserType(String userType) {
  switch (userType) {
    case 'SolhVolunteer':
      return 'Volunteer';
    case 'SolhProvider':
      return 'Counsellor';
    case 'solhChampion':
      return 'Solh Champ';
    default:
      return '';
  }
}

Widget getUserBadge(String userType) {
  if (userType == "solhChampion") {
    return Text('🏆');
  } else if (userType == "SolhVolunteer" || userType == 'SolhProvider') {
    return SolhExpertBadge();
  }
  return Container();
}
