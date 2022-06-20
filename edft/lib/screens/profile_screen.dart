// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'package:edft/providers/app_user_provider.dart';
import 'package:edft/screens/personal_profile.dart';
import 'package:edft/screens/travel_profile.dart';
import 'package:edft/service/user_service.dart';
import 'package:edft/utils/colors.dart';
import 'package:edft/utils/globals.dart';
import 'package:edft/utils/styles.dart';
import 'package:edft/widgets/bottom_navigation.dart';
import 'package:edft/widgets/text_form_field_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../localization/localization_service.dart';
import '../utils/functions.dart';
import 'package:edft/models/app_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  Uint8List? _image;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  CircleAvatar getAvatar(AppUser user) {
    if (_image != null) {
      return CircleAvatar(
        radius: avatarRadius,
        backgroundImage: MemoryImage(_image!),
        backgroundColor: Colors.grey,
      );
    } else if (user.avatarUrl != null) {
      return CircleAvatar(
        radius: avatarRadius,
        backgroundImage: NetworkImage(user.avatarUrl!),
        backgroundColor: Colors.grey,
      );
    } else {
      return const CircleAvatar(
        radius: 128,
        backgroundImage: AssetImage('assets/images/l60Hf.png'),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserProvider>(context).getUser;
    _nameController.text = user.name;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar:
            const MyBottomNavigationBar(currentPage: profilePageIndex),
        appBar: AppBar(
          titleTextStyle: appBarTitle,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            LocalizationService.instance.getLocalizedString("profile"),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: getAvatar(user),
                  ),
                  GestureDetector(
                    onTap: selectImage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        LocalizationService.instance
                            .getLocalizedString("change_picture"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(user.email),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormFieldInput(
                      controller: _nameController,
                      isPass: false,
                      hintText: LocalizationService.instance
                          .getLocalizedString("enter_name"),
                      labelText: LocalizationService.instance
                          .getLocalizedString("name"),
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocalizationService.instance
                              .getLocalizedString("mandatory_field");
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonalProfileScreen(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            LocalizationService.instance
                                .getLocalizedString("personal_profile"),
                            style: Theme.of(context).textTheme.subtitle1!,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TravelProfileScreen(),
                              ),
                            );
                          },
                          child: Text(
                            LocalizationService.instance
                                .getLocalizedString("travel_profile"),
                            style: Theme.of(context).textTheme.subtitle1!,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: _isLoading
                          ? const CircularProgressIndicator(color: primaryColor)
                          : Text(LocalizationService.instance
                              .getLocalizedString("update")),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          user.name = _nameController.text;
                          UserService().updateUser(user, context);
                          showSnackBar(
                            context,
                            LocalizationService.instance
                                .getLocalizedString("update_successful"),
                            'success',
                          );
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            )),
      ),
    );
  }
}
