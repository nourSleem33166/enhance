import 'package:enhance/app/modules/user_communities/user_communities_controller.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:enhance/app/shared/models/community_model.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/widgets/app_bar.dart';
import 'package:enhance/app/shared/widgets/drawer.dart';
import 'package:enhance/app/shared/widgets/loading_widget.dart';
import 'package:enhance/app/shared/widgets/refresh_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class UserCommunitiesPage extends StatefulWidget {
  @override
  _UserCommunitiesPageState createState() => _UserCommunitiesPageState();
}

class _UserCommunitiesPageState
    extends ModularState<UserCommunitiesPage, UserCommunitiesController> {
  @override
  void initState() {
    super.initState();
    controller.initValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: EnhanceDrawer().notSelectedCommunityDrawer(),
      appBar: appBar(LocaleKeys.myCommunities.tr()),
      body: Observer(
        builder: (context) {
          if (controller.pageState == PageState.loading)
            return Loading();
          else if (controller.pageState == PageState.fetchFailed)
            return RefreshPage(() {
              controller.initValues();
            });
          else
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/shared/four_persons.jpg",
                      height: 200,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _buildJoinedCommunities(context),
                    SizedBox(
                      height: 25,
                    ),
                    _buildAdminCommunities(context)
                  ],
                ),
              ),
            );
        },
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildJoinedCommunities(BuildContext context) {
    if (controller.joinedCommunities.length > 0) {
      List<Widget> children = [];
      controller.joinedCommunities.forEach((element) {
        children.add(communityCard(context, element, false));
      });
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.userJoinedCommunities.tr(),
            style: regularStyle(
                fontSize: 16,
                color: EnhanceColors.color(ColorType.primaryTextColor)),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            children: children,
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Modular.to.pushNamed("/userCommunities/searchCommunities");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Search for a community?",
                style: regularStyle(
                    fontSize: 16,
                    color: EnhanceColors.color(ColorType.secondary13)),
              ),
            ),
          ),
        ],
      );
    } else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Text(
                LocaleKeys.notJoinedCommunities.tr(),
                style: regularStyle(
                    fontSize: 16,
                    color: EnhanceColors.color(ColorType.primaryTextColor)),
              ),
              InkWell(
                onTap: () {
                  Modular.to.pushNamed("/userCommunities/searchCommunities");
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    LocaleKeys.joinNow.tr(),
                    style: boldStyle(
                        fontSize: 16,
                        color: EnhanceColors.color(ColorType.secondary13)),
                  ),
                ),
              )
            ],
          ),
        ],
      );
  }

  Widget _buildAdminCommunities(BuildContext context) {
    if (controller.adminCommunities.length > 0) {
      List<Widget> children = [];
      controller.adminCommunities.forEach((element) {
        children.add(communityCard(context, element, true));
      });
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.userAdminCommunities.tr(),
            style: regularStyle(
                fontSize: 16,
                color: EnhanceColors.color(ColorType.primaryTextColor)),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            children: children,
          ),
        ],
      );
    } else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Text(
                LocaleKeys.youCanCreateCommunity.tr(),
                style: regularStyle(
                    fontSize: 16,
                    color: EnhanceColors.color(ColorType.primaryTextColor)),
              ),
              InkWell(
                onTap: () {
                  _launchInBrowser("https://enhance-platform.web.app/");
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    LocaleKeys.createCommunity.tr(),
                    style: boldStyle(
                        fontSize: 16,
                        color: EnhanceColors.color(ColorType.secondary13)),
                  ),
                ),
              )
            ],
          ),
        ],
      );
  }

  Widget communityCard(
      BuildContext context, CommunityModel community, bool adminCommunity) {
    return InkWell(
      onTap: () {
        adminCommunity
            ? _launchInBrowser("https://enhance-platform.web.app/")
            : controller.navigateToHome(community);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.2,
        child: Card(
            color: EnhanceColors.color(ColorType.secondary13),
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   height: 30,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: EnhanceColors.color(ColorType.secondary13)
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10, left: 10, top: 20, bottom: 20),
                    child: Text(
                      community.label,
                      style: regularStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
