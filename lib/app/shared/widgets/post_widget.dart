import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:enhance/app/shared/formatter.dart';
import 'package:enhance/app/shared/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class PostWidget extends StatefulWidget {
  PostModel post;
  Function voteFunction;
  Function deleteFunction;

  PostWidget(this.post, this.voteFunction, this.deleteFunction);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  int oldVoteValue;
  int oldVotesValue;

  @override
  void initState() {
    super.initState();
    oldVoteValue = widget.post.userVoteValue;
    oldVotesValue = widget.post.votes;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            child: Column(
              children: [headerWidget(), contentWidget()],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
    return Row(
      children: [
        SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            if (widget.post.isAnonymous &&
                RegisterRepository.user.id != widget.post.user.id)
              print("hi");
            else
              Modular.to.pushNamed("/home/memberProfile",
                  arguments: [widget.post.user.id]);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: FadeInImage(
                        image: widget.post.isAnonymous &&
                                RegisterRepository.user.id !=
                                    widget.post.user.id
                            ? AssetImage("assets/shared/placeholder.png")
                            : NetworkImage(widget.post.user.profileImage),
                        placeholder:
                            AssetImage("assets/shared/placeholder.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.isAnonymous &&
                              RegisterRepository.user.id != widget.post.user.id
                          ? "Anonymous Member"
                          : widget.post.user.firstName +
                              " " +
                              widget.post.user.lastName,
                      style: boldStyle(
                          fontSize: 14,
                          color:
                              EnhanceColors.color(ColorType.primaryTextColor)),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.post.isAnonymous &&
                              RegisterRepository.user.id != widget.post.user.id
                          ? ""
                          : widget.post.user.profession,
                      style: regularStyle(
                          fontSize: 11,
                          color: EnhanceColors.color(
                              ColorType.secondaryTextColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        widget.post.user.id == RegisterRepository.user.id
            ? PopupMenuButton(
                elevation: 4,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          widget.deleteFunction(widget.post.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.trash,
                                size: 20,
                                color: EnhanceColors.color(
                                    ColorType.primaryTextColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Delete",
                                style: regularStyle(
                                    fontSize: 12,
                                    color: EnhanceColors.color(
                                        ColorType.primaryTextColor)),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                })
            : Container()
      ],
    );
  }

  Widget contentWidget() {
    return Row(
      children: [
        voteWidget(),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                widget.post.title,
                style: boldStyle(
                    fontSize: 14,
                    color: EnhanceColors.color(ColorType.primaryTextColor)),
              ),
              SizedBox(
                height: 15,
              ),
              ReadMoreText(
                widget.post.description,
                moreStyle: regularStyle(
                    color: EnhanceColors.color(ColorType.secondary13),
                    fontSize: 14),
                lessStyle: regularStyle(
                    color: EnhanceColors.color(ColorType.secondary13),
                    fontSize: 14),
                style: regularStyle(
                    fontSize: 12,
                    color: EnhanceColors.color(ColorType.primaryTextColor)),
                trimLines: 2,
                trimLength: widget.post.attachments.length == 0 ? 240 : 100,
                colorClickableText: EnhanceColors.color(ColorType.secondary13),
                trimExpandedText: LocaleKeys.readLess.tr(),
                trimCollapsedText: LocaleKeys.readMore.tr(),
              ),
              attachmentWidget(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    timeAgo.format(widget.post.createdAt),
                    style: regularStyle(
                        fontSize: 12,
                        color:
                            EnhanceColors.color(ColorType.secondaryTextColor)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget attachmentWidget() {
    if (widget.post.attachments.length != 0)
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.post.attachments[0].url,
            loadingBuilder:
                (BuildContext context, Widget child, loadingProgress) {
              print(loadingProgress);
              if (loadingProgress != null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    child: Center(
                      child: CircularProgressIndicator(
                          // value: loadingProgress.expectedTotalBytes != null
                          //     ? loadingProgress.cumulativeBytesLoaded /
                          //     loadingProgress.expectedTotalBytes
                          //     : null,
                          ),
                    ),
                  ),
                );
              }
              return child;
            },
          ),
        ),
      );
    else
      return Container();
  }

  Widget voteWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            if (widget.post.userVoteValue == 0 ||
                widget.post.userVoteValue == -1) {
              if (widget.post.userVoteValue == -1)
                setState(() {
                  widget.post.votes = widget.post.votes + 2;
                  widget.post.userVoteValue = 1;
                });
              else
                setState(() {
                  widget.post.votes = widget.post.votes + 1;
                  widget.post.userVoteValue = 1;
                });

              final doneVoting = await widget.voteFunction(widget.post.id, 1);
              if (!doneVoting) {
                setState(() {
                  widget.post.votes = oldVotesValue;
                  widget.post.userVoteValue = oldVoteValue;
                });
              }
            } else {
              setState(() {
                widget.post.votes = widget.post.votes - 1;
                widget.post.userVoteValue = 0;
              });
              final doneVoting = await widget.voteFunction(widget.post.id, 0);
              if (!doneVoting) {
                setState(() {
                  widget.post.votes = widget.post.votes + 1;
                  widget.post.userVoteValue = 1;
                });
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Icon(Icons.arrow_drop_up,
                size: 50,
                color: widget.post.userVoteValue == 1
                    ? EnhanceColors.color(ColorType.secondary13)
                    : Colors.grey),
          ),
        ),
        Text(
          widget.post.votes.toString(),
          style: regularStyle(
              fontSize: 15,
              color: EnhanceColors.color(ColorType.primaryTextColor)),
        ),
        InkWell(
          onTap: () async {
            if (widget.post.userVoteValue == 0 ||
                widget.post.userVoteValue == 1) {
              if (widget.post.userVoteValue == 1)
                setState(() {
                  widget.post.votes = widget.post.votes - 2;
                  widget.post.userVoteValue = -1;
                });
              else
                setState(() {
                  widget.post.votes = widget.post.votes - 1;
                  widget.post.userVoteValue = -1;
                });

              final doneVoting = await widget.voteFunction(widget.post.id, -1);
              if (!doneVoting) {
                setState(() {
                  widget.post.votes = widget.post.votes - 1;
                  widget.post.userVoteValue = -1;
                });
              }
            } else {
              setState(() {
                widget.post.votes = widget.post.votes + 1;
                widget.post.userVoteValue = 0;
              });
              final doneVoting = await widget.voteFunction(widget.post.id, 0);
              if (!doneVoting) {
                setState(() {
                  widget.post.votes = widget.post.votes - 1;
                  widget.post.userVoteValue = -1;
                });
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            child: Icon(Icons.arrow_drop_down,
                size: 50,
                color: widget.post.userVoteValue == -1
                    ? EnhanceColors.color(ColorType.secondary13)
                    : Colors.grey),
          ),
        ),
      ],
    );
  }
}
