import 'package:enhance/app/modules/community_profile/community_profile_repository.dart';
import 'package:enhance/app/modules/home/member_profile/member_profile_controller.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:enhance/app/shared/formatter.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/models/user_model.dart';
import 'package:enhance/app/shared/widgets/refresh_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MemberProfile extends StatefulWidget {
  int userId;

  MemberProfile(this.userId);

  @override
  _MemberProfileState createState() => _MemberProfileState();
}

class _MemberProfileState
    extends ModularState<MemberProfile, MemberProfileController> {
  @override
  void initState() {
    super.initState();
    controller.initValues(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          if (controller.pageState == PageState.fetchDone)
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: FadeInImage(
                            image: NetworkImage(UserCommunitiesRepository
                                .selectedCommunity.image),
                            placeholder:
                                AssetImage("assets/shared/placeholder.png"),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 2,
                        left: 2,
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: EnhanceColors.color(ColorType.secondary13),
                            ),
                            onPressed: () {
                              Modular.to.pop();
                            }),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment(0, 1.2),
                          child: Container(
                            height: 125,
                            width: 125,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(75),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: FadeInImage(
                                  image: NetworkImage(
                                      controller.user.profileImage),
                                  placeholder: AssetImage(
                                      "assets/shared/placeholder.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  controller.user.firstName + " " + controller.user.lastName,
                  style: boldStyle(
                      fontSize: 20,
                      color: EnhanceColors.color(ColorType.primaryTextColor)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Text(
                          controller.user.bio,
                          style: regularStyle(
                              fontSize: 13,
                              color: EnhanceColors.color(
                                  ColorType.secondaryTextColor)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      profileItem("Email:", controller.user.email),
                      profileItem("Username:", controller.user.username),
                      profileItem("Profession:", controller.user.profession),
                      profileItem("Lives in", controller.user.city.name),
                      profileItem("Age:", controller.user.age.toString()),
                      profileItem("Phone:", controller.user.phone),
                      profileItem(
                          "Joined at",
                          Formatters.humanDate(
                              context, controller.user.joinedAt)),
                      SizedBox(
                        height: 5,
                      ),

                    ],
                  ),
                )
              ],
            );
          else if (controller.pageState == PageState.loading)
            return Center(child: CircularProgressIndicator());
          else
            return RefreshPage(() {
              controller.initValues(widget.userId);
            });
        },
      ),
    );
  }

  Widget profileItem(String label, String value) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              label,
              style: boldStyle(
                  fontSize: 14,
                  color: EnhanceColors.color(ColorType.primaryTextColor)),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              value,
              style: regularStyle(
                  fontSize: 14,
                  color: EnhanceColors.color(ColorType.primaryTextColor)),
            )
          ],
        ),
      ],
    );
  }
}
