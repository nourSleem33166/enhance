import 'package:bot_toast/bot_toast.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/user_communities/user_communities_controller.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../font_styles.dart';

class EnhanceDrawer {
  drawer() {
    return Container(
      width: 260,
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              color: EnhanceColors.color(ColorType.secondary13),
              child: Stack(
                children: [
                  SvgPicture.asset("assets/shared/drawer_pattern.svg"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Modular.to.pushNamed("/home/memberProfile",
                                    arguments: [RegisterRepository.user.id]);
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: FadeInImage(
                                      image: NetworkImage(
                                          RegisterRepository.user.profileImage),
                                      placeholder: AssetImage(
                                          "assets/shared/placeholder.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              RegisterRepository.user.firstName,
                              style: boldStyle(
                                  fontSize: 16,
                                  color:
                                      EnhanceColors.color(ColorType.primary)),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              RegisterRepository.user.profession,
                              style: regularStyle(
                                  fontSize: 11,
                                  color: EnhanceColors.color(ColorType.primary)
                                      .withOpacity(0.7)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            drawerItem("View Profile", "/profile", FontAwesomeIcons.solidUser),
            SizedBox(
              height: 10,
            ),
            drawerItem(UserCommunitiesRepository.selectedCommunity.label,
                "/community_profile", FontAwesomeIcons.users,
                args: [UserCommunitiesRepository.selectedCommunity.id]),
            SizedBox(
              height: 10,
            ),
            drawerItem("Search Community", "/userCommunities/searchCommunities",
                FontAwesomeIcons.search,
                args: [UserCommunitiesRepository.selectedCommunity.id]),
            SizedBox(
              height: 10,
            ),
            drawerItem(
                "My Communities", "/userCommunities", FontAwesomeIcons.home,
                pushReplacement: true),
            SizedBox(
              height: 10,
            ),
            drawerItem("Logout", "logout", FontAwesomeIcons.signOutAlt),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  notSelectedCommunityDrawer() {
    return Container(
      width: 260,
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              color: EnhanceColors.color(ColorType.secondary13),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(onTap: (){

                            },
                              child: Container(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: FadeInImage(
                                      image: NetworkImage(
                                          RegisterRepository.user.profileImage),
                                      placeholder: AssetImage(
                                          "assets/shared/placeholder.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              RegisterRepository.user.firstName +
                                  " " +
                                  RegisterRepository.user.lastName,
                              style: boldStyle(
                                  fontSize: 16,
                                  color:
                                      EnhanceColors.color(ColorType.primary)),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              RegisterRepository.user.profession,
                              style: regularStyle(
                                  fontSize: 11,
                                  color: EnhanceColors.color(ColorType.primary)
                                      .withOpacity(0.7)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            drawerItem("View Profile", "/profile", FontAwesomeIcons.solidUser),
            SizedBox(
              height: 10,
            ),
            drawerItem("Search Community", "/userCommunities/searchCommunities",
                FontAwesomeIcons.search,
                args: []),
            SizedBox(
              height: 10,
            ),
            drawerItem("Logout", "logout", FontAwesomeIcons.signOutAlt),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(String text, String navigation, IconData iconData,
      {var args, bool pushReplacement = false}) {
    return InkWell(
      onTap: () async {
        if (navigation == "logout") {
          BotToast.showLoading();
          await SharedPreferencesHelper.deleteUser();
          await SharedPreferencesHelper.deleteSelectedCommunity();
          await Future.delayed(Duration(seconds: 1));
          BotToast.closeAllLoading();
          Modular.to.pushReplacementNamed("/login");
        }
        if (pushReplacement)
          Modular.to.pushReplacementNamed(navigation, arguments: args);
        else
          Modular.to.pushNamed(navigation, arguments: args);
      },
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Icon(
            iconData,
            size: 18,
            color: navigation == "logout"
                ? Colors.red
                : EnhanceColors.color(ColorType.secondary12),
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            height: 50,
            child: Center(
              child: Text(
                text,
                style: regularStyle(
                  fontSize: 15,
                  color: navigation == "logout"
                      ? Colors.red
                      : EnhanceColors.color(ColorType.secondary12),
                ),
              ),
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
