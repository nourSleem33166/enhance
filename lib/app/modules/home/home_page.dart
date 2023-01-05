import 'package:enhance/app/modules/home/home_controller.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/widgets/app_bar.dart';
import 'package:enhance/app/shared/widgets/drawer.dart';
import 'package:enhance/app/shared/widgets/loading_widget.dart';
import 'package:enhance/app/shared/widgets/post_widget.dart';
import 'package:enhance/app/shared/widgets/refresh_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController>
    with TickerProviderStateMixin {
  int selectedTabIndex;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    await controller.initValues(this);
    controller.tabController.addListener(() {
      // int previous = controller.tabController.previousIndex;
      // if (controller.loading) {
      //   setState(() {
      //     controller.tabController.index = previous;
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (controller.pageState == PageState.fetchDone)
          return DefaultTabController(
            length: controller.subCategories.length + 1,
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: EnhanceColors.color(ColorType.primary),
                  unselectedItemColor:
                      EnhanceColors.color(ColorType.primary).withOpacity(0.7),
                  backgroundColor: Color(0xfff96332),
                  unselectedLabelStyle: regularStyle(
                      fontSize: 12,
                      color: EnhanceColors.color(ColorType.primary)),
                  selectedLabelStyle: boldStyle(
                      fontSize: 13,
                      color: EnhanceColors.color(ColorType.primary)),
                  currentIndex:
                      controller.selectedPostsType == PostsType.suggestions
                          ? 0
                          : 1,
                  onTap: (type) {
                    controller.changePostsType(type);
                  },
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.lightbulb),
                      label: LocaleKeys.suggestions.tr(),
                      activeIcon: FaIcon(FontAwesomeIcons.solidLightbulb),
                      backgroundColor: Color(0xfff96332),
                    ),
                    BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.handPaper),
                        label: LocaleKeys.objections.tr(),
                        backgroundColor: Color(0xfff96332),
                        activeIcon: FaIcon(FontAwesomeIcons.solidHandPaper)),
                  ]),
              appBar: AppBar(
                backgroundColor: EnhanceColors.color(ColorType.secondary13),
                actions: [],
                title: Text(
                  LocaleKeys.home.tr(),
                  style: regularStyle(
                      fontSize: 15,
                      color: EnhanceColors.color(ColorType.primary)),
                ),
                bottom: TabBar(
                  controller: controller.tabController,
                  isScrollable: true,
                  labelStyle: regularStyle(
                      fontSize: 14,
                      color: EnhanceColors.color(ColorType.primary)),
                  onTap: (index) {
                    int previous = controller.tabController.previousIndex;
                    if (controller.loading) {
                      setState(() {
                        controller.tabController.index = previous;
                      });
                    } else {
                      if (index == 0)
                        controller.initPosts(-1);
                      else
                        controller
                            .initPosts(controller.subCategories[index - 1].id);
                    }
                  },
                  tabs: [
                    Tab(
                      text: "All",
                    ),
                    for (int i = 0; i < controller.subCategories.length; i++)
                      Tab(text: controller.subCategories[i].name)
                  ],
                ),
              ),
              drawer: EnhanceDrawer().drawer(),
              body: TabBarView(
                controller: controller.tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  for (int i = 0; i < controller.subCategories.length + 1; i++)
                    _buildPostsView()
                ],
              ),
            ),
          );
        else if (controller.pageState == PageState.loading)
          return Loading();
        else
          return RefreshPage(() {
            initData();
          });
      },
    );
  }

  Widget _buildPostsView() {
    var selectedPosts = controller.selectedPostsType == PostsType.suggestions
        ? controller.suggestions
        : controller.objections;
    return Observer(
      builder: (context) {
        return Column(mainAxisAlignment: controller.loading?MainAxisAlignment.center:MainAxisAlignment.start,
          children: [
            controller.tabController.index == 0||controller.loading ? Container() : _buildAddPost(),
            SizedBox(
              height: 10,
            ),
            controller.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : selectedPosts.length == 0
                    ? RefreshIndicator(
                        onRefresh: () {
                          controller
                              .initPosts(controller.selectedSubCategoryId);
                        },
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Text(
                                "There's no posts yet",
                                style: regularStyle(
                                    fontSize: 16,
                                    color: EnhanceColors.color(
                                        ColorType.secondary13)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset("assets/shared/crowd.jpg")
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await controller
                                .initPosts(controller.selectedSubCategoryId);
                            return null;
                          },
                          child: ListView.builder(
                            itemCount: selectedPosts.length,
                            itemBuilder: (context, index) {
                              return PostWidget(selectedPosts[index],
                                  controller.sendVote, controller.deletePost);
                            },
                          ),
                        ),
                      ),
          ],
        );
      },
    );
  }

  Widget _buildAddPost() {
    return InkWell(
      onTap: () {
        controller.navigateToAddPost();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                        image:
                            NetworkImage(RegisterRepository.user.profileImage),
                        placeholder:
                            AssetImage("assets/shared/placeholder.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  controller.selectedPostsType == PostsType.objections
                      ? LocaleKeys.doYouHaveAnObjection.tr()
                      : LocaleKeys.doYouHaveASuggestion.tr(),
                  style: lightStyle(
                      fontSize: 13,
                      color: EnhanceColors.color(ColorType.primaryTextColor)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
