import 'package:enhance/app/modules/profile/profile_controller.dart';
import 'package:enhance/app/modules/profile/profile_repository.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_controller.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/widgets/app_bar.dart';
import 'package:enhance/app/shared/widgets/flat_button.dart';
import 'package:enhance/app/shared/widgets/loading_widget.dart';
import 'package:enhance/app/shared/widgets/refresh_page.dart';
import 'package:enhance/app/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfileController> {
  @override
  void initState() {
    super.initState();
    controller.initValues();
    controller.emailValidator(controller.emailController.text);
    controller.firstNameValidator(controller.firstNameController.text);
    controller.lastNameValidator(controller.lastNameController.text);
    controller.ageValidator(controller.ageController.text);
    controller.phoneValidator(controller.phoneController.text);
    controller.professionValidator(controller.professionController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Profile"),
      body: Observer(
        builder: (context) {
          if (controller.pageState == PageState.fetchDone)
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 140,
                              width: 140,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: FadeInImage(
                                    image: controller.imageFile == null
                                        ? NetworkImage(RegisterRepository
                                            .user.profileImage)
                                        : FileImage(controller.imageFile),
                                    placeholder: AssetImage(
                                        "assets/shared/placeholder.png"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              RegisterRepository.user.firstName +
                                  " " +
                                  RegisterRepository.user.lastName,
                              style: regularStyle(
                                  fontSize: 18, color: Colors.black),
                            )
                          ],
                        ),
                        Positioned(
                          bottom: 30,
                          right: 10,
                          child: InkWell(
                            onTap: () async {
                              await controller.pickImage();
                              setState(() {});
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: EnhanceColors.color(
                                      ColorType.secondary13)),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      children: [
                        firstStepPage(),
                        secondStepPage(),
                      ],
                    ),
                  ),
                  Observer(
                    builder: (context) {
                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.previousPressed();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    size: 14,
                                    color: controller.currentPage == 0
                                        ? EnhanceColors.color(
                                            ColorType.secondaryTextColor)
                                        : EnhanceColors.color(
                                            ColorType.secondary),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleKeys.previous.tr(),
                                    style: boldStyle(
                                        fontSize: 15,
                                        color: controller.currentPage == 0
                                            ? EnhanceColors.color(
                                                ColorType.secondaryTextColor)
                                            : EnhanceColors.color(
                                                ColorType.secondary)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              controller.currentPage != 1
                                  ? controller.nextPressed()
                                  : controller.updateUser();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    controller.currentPage != 1
                                        ? LocaleKeys.next.tr()
                                        : "Done",
                                    style: boldStyle(
                                        fontSize: 15,
                                        color: EnhanceColors.color(
                                            ColorType.secondary)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: EnhanceColors.color(
                                        ColorType.secondary),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            );
          else if (controller.pageState == PageState.loading)
            return Loading();
          else
            return RefreshPage(() {
              controller.initValues();
            });
        },
      ),
    );
  }

  firstStepPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SharedTextField(
              controller: controller.firstNameController,
              underLineTextField: false,
              validator: controller.firstNameValidator,
              labelText: LocaleKeys.firstName.tr(),
            ),
            SizedBox(
              height: 10,
            ),
            SharedTextField(
              controller: controller.lastNameController,
              underLineTextField: false,
              validator: controller.lastNameValidator,
              labelText: LocaleKeys.lastName.tr(),
            ),
            SizedBox(
              height: 10,
            ),
            SharedTextField(
              controller: controller.emailController,
              validator: controller.emailValidator,
              underLineTextField: false,
              labelText: LocaleKeys.email.tr(),
            ),
            SizedBox(
              height: 10,
            ),
            SharedTextField(
              controller: controller.ageController,
              underLineTextField: false,
              validator: controller.ageValidator,
              labelText: LocaleKeys.age.tr(),
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            SharedTextField(
              controller: controller.phoneController,
              validator: controller.phoneValidator,
              underLineTextField: false,
              labelText: LocaleKeys.phone.tr(),
              textInputType: TextInputType.numberWithOptions(),
            ),
            SizedBox(
              height: 10,
            ),
            SharedTextField(
              controller: controller.professionController,
              validator: controller.professionValidator,
              underLineTextField: false,
              labelText: LocaleKeys.profession.tr(),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  secondStepPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: dropDownButton(controller.countries,
                        controller.selectCountry, controller.selectedCountry)),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                    child: dropDownButton(controller.cities,
                        controller.selectCity, controller.selectedCity))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              child: SharedTextField(
                controller: controller.aboutMeController,
                underLineTextField: false,
                isExpandable: true,
                labelText: LocaleKeys.aboutMe.tr(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Categories",
              style: regularStyle(fontSize: 16, color: Colors.black),
            ),
            TypeAheadFormField(
                getImmediateSuggestions: false,
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    controller: controller.categoriesController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: EnhanceColors.color(
                                    ColorType.secondary13))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: EnhanceColors.color(
                                    ColorType.secondary13))),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: EnhanceColors.color(
                                    ColorType.secondary13))))),
                suggestionsCallback: (pattern) async {
                  return controller.categoryTypingCallback(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                      title: Text(suggestion.name,
                          style: regularStyle(
                              fontSize: 14,
                              color:
                                  EnhanceColors.color(ColorType.secondary))));
                },
                onSuggestionSelected: (category) {
                  controller.suggestionPressed(category);
                }),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                for (int i = 0; i < controller.selectedCategories.length; i++)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Chip(
                      deleteIcon: Icon(
                        FontAwesomeIcons.times,
                        color: Colors.white,
                        size: 18,
                      ),
                      onDeleted: () {
                        controller.deleteCategoryPressed(
                            controller.selectedCategories[i]);
                      },
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.selectedCategories[i].name,
                          style:
                              regularStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      backgroundColor:
                          EnhanceColors.color(ColorType.secondary13),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  thirdStepPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              child: SharedTextField(
                controller: controller.aboutMeController,
                underLineTextField: false,
                isExpandable: true,
                labelText: LocaleKeys.aboutMe.tr(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Observer(
              builder: (context) {
                return Row(
                  children: [
                    Switch(
                        value: controller.inviteToOtherCommunities,
                        onChanged: (value) {
                          controller.changeInviteValue(value);
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        LocaleKeys.invitePeopleToOtherCommunities.tr(),
                        style: regularStyle(
                            fontSize: 15,
                            color: EnhanceColors.color(ColorType.secondary13)),
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget dropDownButton(
      List data, Function onChangedFunction, dynamic content) {
    return DropdownButton<dynamic>(
      value: content,
      iconEnabledColor: EnhanceColors.color(ColorType.secondary13),
      isExpanded: true,
      items: data.map((value) {
        return new DropdownMenuItem(
          value: value,
          child: Text(
            value.name,
            style: regularStyle(
                fontSize: 14,
                color: EnhanceColors.color(ColorType.primaryTextColor)),
          ),
        );
      }).toList(),
      onChanged: (value) {
        onChangedFunction(value);
      },
    );
  }
}
