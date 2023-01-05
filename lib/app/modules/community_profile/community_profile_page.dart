import 'package:enhance/app/modules/community_profile/community_profile_controller.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/widgets/flat_button.dart';
import 'package:enhance/app/shared/widgets/loading_widget.dart';
import 'package:enhance/app/shared/widgets/refresh_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CommunityProfilePage extends StatefulWidget {
  int id;

  CommunityProfilePage(this.id);

  @override
  _CommunityProfilePageState createState() => _CommunityProfilePageState();
}

class _CommunityProfilePageState
    extends ModularState<CommunityProfilePage, CommunityProfileController> {
  @override
  void initState() {
    super.initState();
    controller.initValues(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          if (controller.pageState == PageState.fetchDone)
            return CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                    collapsedHeight: 150,
                    expandedHeight: 250,
                    floating: true,
                    bottom: PreferredSize(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            controller.communityData.label,
                            style: boldStyle(fontSize: 18, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          controller.communityData.verified
                              ? Text(
                                  "Verified ✓",
                                  style: regularStyle(
                                      fontSize: 12,
                                      color: EnhanceColors.color(
                                          ColorType.secondary13)),
                                )
                              : Container(),
                          Spacer(),
                          !controller.joined
                              ? SharedFlatButton(
                                  text: "Join Community",
                                  textColor: EnhanceColors.color(
                                      ColorType.secondary13),
                                  onPressed: () {
                                    controller.joinCommunity(
                                        controller.communityData.id);
                                  })
                              : InkWell(
                                  onTap: () async {
                                    await controller.leaveCommunity(
                                        controller.communityData.id);
                                    Modular.to.pushReplacementNamed(
                                        "/userCommunities");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Leave",
                                      style: boldStyle(
                                          fontSize: 14,
                                          color: EnhanceColors.color(
                                              ColorType.secondary13)),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      preferredSize: Size.fromHeight(20),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          FadeInImage(
                            width: double.infinity,
                            height: 220,
                            image: NetworkImage(
                                controller.communityData.coverImage),
                            placeholder: AssetImage(
                                "assets/shared/community_placeholder.png"),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.2),
                            height: 220,
                          )
                        ],
                      ),
                    ),
                    backgroundColor: Colors.transparent),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller.communityData.description,
                            style:
                                regularStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Community Category: ",
                                style: boldStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Text(
                                controller.communityData.category.name,
                                style: regularStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Community Subcategories: ",
                            style: boldStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: [
                              for (int i = 0;
                                  i <
                                      controller
                                          .communityData.subcategories.length;
                                  i++)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Chip(
                                    label: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Text(
                                        controller.communityData
                                            .subcategories[i].name,
                                        style: regularStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                    backgroundColor: EnhanceColors.color(
                                        ColorType.secondary13),
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            );
          else if (controller.pageState == PageState.fetchFailed)
            return RefreshPage(() {
              controller.initValues(widget.id);
            });
          else
            return Loading();
        },
      ),
    );
  }
}
