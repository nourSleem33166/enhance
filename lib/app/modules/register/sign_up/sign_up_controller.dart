import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/shared/exceptions/enhance_exception.dart';
import 'package:enhance/app/shared/models/community_profile_model.dart';
import 'package:enhance/app/shared/models/countries_model.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/regx/enhance_regx.dart';
import 'package:enhance/app/shared/services/storage_service.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';
import 'package:enhance/app/shared/widgets/textFieldEmptyChecker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'package:http/http.dart' as http;

part 'sign_up_controller.g.dart';

class SignUpController = _SignUpControllerBase with _$SignUpController;

abstract class _SignUpControllerBase with Store {
  RegisterRepository _registerRepository;

  _SignUpControllerBase(this._registerRepository);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  ObservableList<Category> selectedCategories = ObservableList<Category>();

  @observable
  City selectedCity;
  @observable
  CountryModel selectedCountry;
  PageController pageController = PageController();

  List<CountryModel> countries;
  List<Category> categories;

  PickedFile pickedImage;

  @observable
  File imageFile;

  ObservableList<City> cities = ObservableList<City>();

  //city selectedCity;
  TextEditingController addressController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  @observable
  bool inviteToOtherCommunities = false;

  @observable
  PageState pageState;

  @observable
  int currentPage = 0;

  @observable
  bool validEmail = false;

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
  Future pickImage() async {
    pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    print("pickedFile ${pickedImage.path}");
    imageFile = File(pickedImage.path);
  }

  Future<void> initValues() async {
    try {
      pageState = PageState.loading;
      countries = await _registerRepository.getCountries();
      categories = await _registerRepository.getCategories();
      selectedCountry = countries[0];
      cities.addAll(countries[0].cities);
      selectedCity = cities[0];
      pageState = PageState.fetchDone;
    } on EnhanceException catch (e) {
      showToast(e.key);
      pageState = PageState.fetchFailed;
    }
  }

  @action
  Future suggestionPressed(Category category) async {
    if(!selectedCategories.contains(category))
    selectedCategories.add(category);
  }

  @action
  Future deleteCategoryPressed(Category category) async {
    selectedCategories.remove(category);
  }

  @action
  List<Category> categoryTypingCallback(String pattern) {
    List<Category> callbackList = [];
    for (int i = 0; i < categories.length; i++) {
      if (categories[i].name.toLowerCase().contains(pattern.toLowerCase()))
        callbackList.add(categories[i]);
    }
    return callbackList;
  }

  @action
  Future signUp() async {
    if (selectedCategories.isEmpty || aboutMeController.text.isEmpty)
      showToast("Please fill all required data");
    else
      try {
        BotToast.showLoading();
        String profileImageLink;
        if (imageFile != null)
          profileImageLink = await _registerRepository.uploadImage(imageFile);
        SignUpParams signUpParams = SignUpParams(
          phone: phoneController.text,
          address: addressController.text,
          email: emailController.text,
          lastName: lastNameController.text,
          bio: aboutMeController.text,
          profession: professionController.text,
          cityId: selectedCity.id,
          password: passwordController.text,
          profileImage: profileImageLink == null ? null : profileImageLink,
          firstName: firstNameController.text,
          invitationOption: false,
          userName: userNameController.text,
          categories: [
            for (int i = 0; i < selectedCategories.length; i++)
              selectedCategories[i].id
          ],
          age: int.parse(ageController.text),
        );
        final user = await _registerRepository.signUp(signUpParams);
        await SharedPreferencesHelper.setUser(user);
        await SharedPreferencesHelper.setPassword(passwordController.text);
        RegisterRepository.user = user;
        BotToast.closeAllLoading();
        Modular.to.pushReplacementNamed("/userCommunities");
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
        if (notEmptyTextField([
              addressController,
              userNameController,
              passwordController,
              confirmPasswordController,
            ]) &&
            identicalPasswords())
          pageController
              .nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease)
              .then((value) {
            updateCurrentPage(pageController.page.round());
          });
        break;
      case 2:
        //signUpRequest
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
    if (EnhanceRegExp.phone.hasMatch(value) && !value.contains(".") ||
        !value.contains(" ") && !value.contains(",") && !value.contains("-")) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validPhone = true;
      });
      return null;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        phoneController.clear();
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

  bool identicalPasswords() {
    if (passwordController.text == confirmPasswordController.text)
      return true;
    else {
      showToast(LocaleKeys.notIdenticalPasswords.tr());
      return false;
    }
  }

  String passwordValidator(String value) {
    return null;
    // if (value.isEmpty) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     validPassword = false;
    //   });
    //   return LocaleKeys.mustFillPassword.tr();
    // } else {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     validPassword = true;
    //   });
    //   return null;
    // }
  }
}

class SignUpParams {
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
  String password;
  String bio;
  bool invitationOption;
  List<int> categories;

  SignUpParams(
      {this.firstName,
      this.lastName,
      this.email,
      this.age,
      this.phone,
      this.profession,
      this.cityId,
      this.address,
      this.userName,
      this.password,
      this.categories,
      this.bio,
      this.profileImage,
      this.invitationOption});
}
