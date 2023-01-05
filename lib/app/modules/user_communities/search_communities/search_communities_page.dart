import 'dart:async';

import 'package:enhance/app/modules/user_communities/search_communities/search_communities_controller.dart';
import 'package:enhance/app/modules/user_communities/user_communities_controller.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/widgets/app_bar.dart';
import 'package:enhance/app/shared/widgets/drawer.dart';
import 'package:enhance/app/shared/widgets/loading_widget.dart';
import 'package:enhance/app/shared/widgets/refresh_page.dart';
import 'package:enhance/app/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchCommunitiesPage extends StatefulWidget {
  @override
  _SearchCommunitiesPageState createState() => _SearchCommunitiesPageState();
}

class _SearchCommunitiesPageState
    extends ModularState<SearchCommunitiesPage, SearchCommunitiesController> {
  Timer _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EnhanceColors.color(ColorType.secondary13),
        title: SharedTextField(
          controller: controller.searchController,
          onChanged: (x) {
            if (_debounce?.isActive ?? false) _debounce.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              controller.searchForCommunity(x);
            });
          },
          borderTextFieldColor: Colors.transparent,
          hintText: "Search Communities",
          hintColor: Colors.white.withOpacity(0.8),
          textColor: Colors.white,
          suffixIcon: Icons.search,
          suffixIconColor: Colors.white,
        ),
      ),
      body: Observer(
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  !controller.isSearching &&
                          controller.searchedCommunities.isEmpty &&
                          controller.searchController.text.isNotEmpty
                      ? Center(
                          child: Text(
                            "No results found",
                            style: regularStyle(fontSize: 16, color: null),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.searchedCommunities.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(onTap: (){
                              controller.onCommunitySelected(controller.searchedCommunities[index].id);
                            },
                              title: Text(
                                controller.searchedCommunities[index].label,
                                style: regularStyle(
                                    fontSize: 16,
                                    color: EnhanceColors.color(
                                        ColorType.primaryTextColor)),
                              ),
                              leading: Container(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: FadeInImage(
                                    image: NetworkImage(controller
                                        .searchedCommunities[index].image),
                                    placeholder: AssetImage(
                                        "assets/shared/community_placeholder.png"),
                                  ),
                                ),
                              ),
                            );
                          })
                  // : Center(
                  //     child: Observer(
                  //       builder: (context) {
                  //         return Text(
                  //           controller.searchedCommunities.isEmpty
                  //               ? "No results Found"
                  //               : "",
                  //           style: regularStyle(
                  //               fontSize: 16,
                  //               color: EnhanceColors.color(
                  //                   ColorType.secondary13)),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  ,
                  SizedBox(
                    height: 25,
                  ),
                  Image.asset("assets/shared/crowd.jpg")
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
}
