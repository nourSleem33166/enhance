import 'package:enhance/app/modules/home/add_post/add_post_controller.dart';
import 'package:enhance/app/modules/home/home_controller.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:enhance/app/shared/widgets/app_bar.dart';
import 'package:enhance/app/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPostPage extends StatefulWidget {
  PostsType postType;
  int subCategoryId;

  AddPostPage(this.postType, this.subCategoryId);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends ModularState<AddPostPage, AddPostController> {
  @override
  void initState() {
    super.initState();
    controller.initValues(widget.subCategoryId, widget.postType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EnhanceColors.color(ColorType.secondary13),
        actions: [
          InkWell(
            onTap: () {
              controller.createPost();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                "Post",
                style: boldStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          )
        ],
        title: Text(
          widget.postType == PostsType.objections
              ? "Add Objection"
              : "Add Suggestion",
          style: regularStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SingleChildScrollView(
          child: Observer(
            builder: (context) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Observer(
                                      builder: (context) {
                                        return FadeInImage(
                                          image: controller.isAnonymous
                                              ? AssetImage(
                                                  "assets/shared/placeholder.png")
                                              : NetworkImage(RegisterRepository
                                                  .user.profileImage),
                                          placeholder: AssetImage(
                                              "assets/shared/placeholder.png"),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Observer(
                                builder: (context) {
                                  return Text(
                                    controller.isAnonymous
                                        ? "Anonymous"
                                        : RegisterRepository.user.firstName +
                                            " " +
                                            RegisterRepository.user.lastName,
                                    style: boldStyle(
                                        fontSize: 14,
                                        color: EnhanceColors.color(
                                            ColorType.primaryTextColor)),
                                  );
                                },
                              ),
                              Spacer(),
                              Text(
                                "Anonymous",
                                style: boldStyle(
                                    fontSize: 12,
                                    color: EnhanceColors.color(
                                        ColorType.secondary13)),
                              ),
                              Observer(
                                builder: (context) {
                                  return Switch(
                                    value: controller.isAnonymous,
                                    onChanged: (x) {
                                      controller.changeAnonyState(x);
                                    },
                                    activeColor: EnhanceColors.color(
                                        ColorType.secondary13),
                                  );
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 58,
                            child: SharedTextField(
                              controller: controller.title,
                              borderTextFieldColor: Colors.transparent,
                              hintText: widget.postType == PostsType.objections
                                  ? "Objection Title"
                                  : "Suggestion Title",
                              hintColor:
                                  EnhanceColors.color(ColorType.secondary13),
                              underLineTextField: false,
                              isExpandable: true,
                              isTitle: true,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 120,
                            child: SharedTextField(
                              labelColor:
                                  EnhanceColors.color(ColorType.secondary13),
                              controller: controller.description,
                              borderTextFieldColor: Colors.transparent,
                              underLineTextField: false,
                              isExpandable: true,
                              hintText: "Description",
                            ),
                          ),
                          controller.imageFile != null
                              ? Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: FadeInImage(
                                          image:
                                              FileImage(controller.imageFile),
                                          placeholder: AssetImage(
                                              "assets/shared/placeholder.png"),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 10,
                                        child: IconButton(
                                          icon: Icon(
                                            FontAwesomeIcons.trash,
                                            color: EnhanceColors.color(
                                                ColorType.secondary13),
                                          ),
                                          onPressed: () {
                                            controller.deleteImage();
                                          },
                                        ))
                                  ],
                                )
                              : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.solidImage,
                                  size: 28,
                                  color: EnhanceColors.color(
                                      ColorType.secondary13),
                                ),
                                onPressed: () async {
                                  await controller.pickImage();
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    elevation: 5,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
