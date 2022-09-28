import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:solh/model/search/global_search_model.dart';
import '../constants/colors.dart';
import '../constants/textstyles.dart';

class PostTile extends StatelessWidget {
  const PostTile({Key? key, PostCount? postCount, Function()? onTapped})
      : _postCount = postCount,
        _onTapped = onTapped,
        super(key: key);
  final PostCount? _postCount;
  final Function()? _onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTapped,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    _postCount!.postIn == 'Group'
                        ? _postCount!.groupPostedIn!.groupMediaUrl ?? ''
                        : _postCount!.userId!.profilePicture ?? ''),
                radius: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${_postCount!.postIn == 'Group' ? _postCount!.groupPostedIn!.groupName ?? '' : _postCount!.userId!.name ?? ''}',
                      style: SolhTextStyles.JournalingUsernameText),
                  Row(
                    children: [
                      Text(
                        _postCount!.postIn == 'Group'
                            ? _postCount!.userId!.name ?? ''
                            : '',
                        style: SolhTextStyles.JournalingDescriptionText,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.circle,
                        color: SolhColors.grey,
                        size: 8,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${timeago.format(DateTime.parse(_postCount!.createdAt ?? ''))}',
                        style: SolhTextStyles.JournalingDescriptionText,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: SolhColors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          // _postCount!.feelings != null && _postCount!.feelings!.isNotEmpty
          //     ? Text(
          //         '#Feelings ${_postCount!.feelings.toString()}',
          //         style: SolhTextStyles.PinkBorderButtonText,
          //       )
          //     : Container(),
          // SizedBox(
          //   height: 5,
          // ),
          ReadMoreText(
            _postCount!.description ?? '',
            style: SolhTextStyles.JournalingDescriptionText,
            trimLines: 3,
            trimMode: TrimMode.Line,
          ),
          Divider(
            color: SolhColors.grey,
          ),
          _postCount!.mediaUrl != null
              ? _postCount!.mediaType == 'video/mp4'
                  ? Container()
                  : CachedNetworkImage(
                      imageUrl: _postCount!.mediaUrl ?? '',
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) => getShimmer(context),
                      errorWidget: (context, url, error) => Center(
                        child:
                            Image.asset('assets/images/no-image-available.png'),
                      ),
                    )
              : Container()
        ],
      ),
    );
  }

  Widget getShimmer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 80,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
