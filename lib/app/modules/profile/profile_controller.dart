import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/modules/profile/profile_repository.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:enhance/app/shared/exceptions/enhance_exception.dart';
import 'package:enhance/app/shared/models/community_profile_model.dart';
import 'package:enhance/app/shared/models/countries_model.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/models/user_model.dart';
import 'package:enhance/app/shared/regx/enhance_regx.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';
import 'package:enhance/app/shared/widgets/textFieldEmptyChecker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:enhance/generated/locale_keys.g.dart';

part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  ProfileRepository _profileRepository;

  _ProfileControllerBase(this._profileRepository);

  TextEditingController firstNameController =
      TextEditingController(text: RegisterRepository.user.firstName);
  TextEditingController lastNameController =
      TextEditingController(text: RegisterRepository.user.lastName);
  TextEditingController emailController =
      TextEditingController(text: RegisterRepository.user.email);
  TextEditingController ageController =
      TextEditingController(text: RegisterRepository.user.age.toString());
  TextEditingController phoneController =
      TextEditingController(text: RegisterRepository.user.phone);
  TextEditingController professionController =
      TextEditingController(text: RegisterRepository.user.profession);
  @observable
  City selectedCity;
  @observable
  CountryModel selectedCountry;
  PageController pageController = PageController();

  List<CountryModel> countries;

  List<Category> allCategories = [];
  ObservableList<Category> selectedCategories = ObservableList<Category>();

  ObservableList<City> cities = ObservableList<City>();

  TextEditingController aboutMeController =
      TextEditingController(text: RegisterRepository.user.bio);
  TextEditingController categoriesController = TextEditingController();
  @observable
  bool inviteToOtherCommunities = false;

  @observable
  PageState pageState;

  @observable
  int currentPage = 0;

  @observable
  bool validEmail = false;

  PickedFile pickedImage;

  @observable
  File imageFile;

  @observable
  bool validFirstName = false;
  @observable
  bool validLastName = false;
  @observable
  bool validAge = false;
  @observable
  bool validPhone = false;
  @observable
  bool validProfession;

  @observable
  bool validPassword = false;

  @computed
  bool get validData =>
      validEmail &&
      validPassword &&
      validFirstName &&
      validLastName &&
      validAge &&
      validPhone &&
      validProfession;

  @action
  Future suggestionPressed(Category category) async {
    if (!selectedCategories.contains(category))
      selectedCategories.add(category);
  }

  @action
  Future deleteCategoryPressed(Category category) async {
    selectedCategories.remove(category);
  }

  Future<void> initValues() async {
    try {
      pageState = PageState.loading;
      countries = await _profileRepository.getCountries();
      allCategories = await _profileRepository.getCategories();
      selectedCountry = countries[0];
      cities.addAll(countries[0].cities);
      for (int i = 0; i < RegisterRepository.user.categories.length; i++)
        selectedCategories.add(RegisterRepository.user.categories[i]);
      selectedCity = cities.singleWhere(
          (element) => element.id == RegisterRepository.user.city.id);
      pageState = PageState.fetchDone;
    } on EnhanceException catch (e) {
      showToast(e.key);
      pageState = PageState.fetchFailed;
    }
  }

  @action
  Future pickImage() async {
    pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    print("pickedFile ${pickedImage.path}");
    imageFile = File(pickedImage.path);
  }

  @action
  List<Category> categoryTypingCallback(String pattern) {
    List<Category> callbackList = [];
    for (int i = 0; i < allCategories.length; i++) {
      if (allCategories[i].name.toLowerCase().contains(pattern.toLowerCase()))
        callbackList.add(allCategories[i]);
    }
    return callbackList;
  }

  @action
  Future updateUser() async {
    try {
      if (selectedCategories.isEmpty || aboutMeController.text.isEmpty)
        showToast("Please fill all required data");
      else
        BotToast.showLoading();
      String profileImageLink = RegisterRepository.user.profileImage;
      if (imageFile != null)
        profileImageLink = await _profileRepository.uploadImage(imageFile);

      print("profile image link $profileImageLink");
      List<int> addedCategories = [];
      List<int> deletedCategories = [];
      for (int i = 0; i < selectedCategories.length; i++) {
        if (!RegisterRepository.user.categories.contains(selectedCategories[i]))
          addedCategories.add(selectedCategories[i].id);
      }
      for (int i = 0; i < RegisterRepository.user.categories.length; i++) {
        if (!selectedCategories.contains(RegisterRepository.user.categories[i]))
          deletedCategories.add(RegisterRepository.user.categories[i].id);
      }
      UpdateUserParams updateUserParams = UpdateUserParams(
        phone: phoneController.text,
        email: emailController.text,
        profession: professionController.text,
        addedCategories: addedCategories,
        deletedCategories: deletedCategories,
        lastName: lastNameController.text,
        firstName: firstNameController.text,
        profileImage: profileImageLink,
        invitationOption: false,
        cityId: selectedCity.id,
        bio: aboutMeController.text,
        age: int.parse(ageController.text),
      );
      final res = await _profileRepository.updateUser(updateUserParams);
      BotToast.closeAllLoading();

      if (res) {
        Modular.to.pushReplacementNamed("/home",
            arguments: UserCommunitiesRepository.selectedCommunity.id);
      }
    } on EnhanceException catch (e) {
      BotToast.closeAllLoading();
      showToast(e.key);
    }
  }

  @action
  selectCity(City city) {
    selectedCity = city;
  }

  nextPressed() {
    print("validData $validData");
    switch (currentPage) {
      case 0:
        if (notEmptyTextField([
          firstNameController,
          lastNameController,
          emailController,
          ageController,
          phoneController,
          professionController
        ]))
          pageController
              .nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease)
              .then((value) {
            updateCurrentPage(pageController.page.round());
          });
        break;
      case 1:
        break;
      default:
        break;
    }
  }

  previousPressed() {
    if (currentPage != 0)
      pageController
          .animateToPage((pageController.page - 1).round(),
              duration: Duration(milliseconds: 500), curve: Curves.ease)
          .then((value) {
        updateCurrentPage(pageController.page.round());
      });
  }

  @action
  changeInviteValue(bool value) {
    inviteToOtherCommunities = value;
  }

  String emailValidator(String value) {
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validEmail = false;
      });
      return LocaleKeys.mustFillEmail.tr();
    }
    if (EnhanceRegExp.email.hasMatch(value)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validEmail = true;
      });
      return null;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validEmail = false;
      });
      return LocaleKeys.invalidEmail.tr();
    }
  }

  String firstNameValidator(String value) {
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validFirstName = false;
      });
      return LocaleKeys.mustFill.tr();
    }
    if (EnhanceRegExp.name.hasMatch(value)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validFirstName = true;
      });
      return null;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validFirstName = false;
      });
      return LocaleKeys.invalid.tr();
    }
  }

  String lastNameValidator(String value) {
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validLastName = false;
      });
      return LocaleKeys.mustFill.tr();
    }
    if (EnhanceRegExp.name.hasMatch(value)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validLastName = true;
      });
      return null;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validLastName = false;
      });
      return LocaleKeys.invalid.tr();
    }
  }
  String ageValidator(String value) {
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validAge = false;
      });
      return LocaleKeys.mustFill.tr();
    }

    if (EnhanceRegExp.age.hasMatch(value) &&
        int.parse(value) < 100 &&
        int.parse(value) > 13) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validAge = true;
      });
      return null;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validAge = false;
      });
      return LocaleKeys.invalid.tr();
    }
  }


  String phoneValidator(String value) {
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validPhone = false;
      });
      return LocaleKeys.mustFill.tr();
    }
    if (EnhanceRegExp.phone.hasMatch(value)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validPhone = true;
      });
      return null;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validPhone = false;
      });
      return LocaleKeys.invalid.tr();
    }
  }

  String professionValidator(String value) {
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validProfession = false;
      });
      return LocaleKeys.mustFill.tr();
    }
    if (EnhanceRegExp.name.hasMatch(value)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validProfession = true;
      });
      return null;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validProfession = false;
      });
      return LocaleKeys.invalid.tr();
    }
  }

  @action
  selectCountry(CountryModel country) {
    selectedCountry = country;
    cities.clear();
    cities.addAll(selectedCountry.cities);
    selectedCity = cities[0];
  }

  @action
  updateCurrentPage(int pageIndex) {
    currentPage = pageIndex;
  }

  @action
  Future resetPassword() async {
    Modular.to.pushNamed("/login/resetPassword");
  }
}

class UpdateUserParams {
  String firstName;
  String lastName;
  String email;
  int age;
  String profileImage;
  String phone;
  String profession;
  int cityId;
  String address;
  String userName;
  String bio;
  bool invitationOption;
  List<int> addedCategories;
  List<int> deletedCategories;

  UpdateUserParams(
      {this.firstName,
      this.lastName,
      this.email,
      this.age,
      this.phone,
      this.profession,
      this.cityId,
      this.address,
      this.userName,
      this.addedCategories,
      this.deletedCategories,
      this.bio,
      this.profileImage,
      this.invitationOption});
}
