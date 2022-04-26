import 'package:flutter/material.dart';
import 'package:hope_nest/models/search.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/enum/user_type.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/advert_vm.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/navigation_bar/navigation_bar.dart';
import 'package:hope_nest/views/components/owner_info_tile/circular_user_image.dart';
import 'package:hope_nest/views/components/search_filter/search_filter.dart';
import 'package:hope_nest/views/components/styles/input_style.dart';
import 'package:hope_nest/views/home_page/blog/blog_provider.dart';
import 'package:hope_nest/views/home_page/home/home_provider.dart';
import 'package:hope_nest/views/home_page/messages/messages_provider.dart';
import 'package:provider/provider.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({Key? key}) : super(key: key);

  @override
  _HomeRootPageState createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {
  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    final _advertVM = Provider.of<AdvertVM>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(10),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    margin: EdgeInsets.all(DynamicSize.height(context, 0.02)),
                    height: DynamicSize.height(context, 0.06),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Palette.NAVBAR_BACKGROUND,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                            child: const CustomNavigationBar(),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: CircularUserImage(
                              image: _appUserVM.appUser!.image != ""
                                  ? Image.network(
                                      _appUserVM.appUser!.image!,
                                    )
                                  : Image.asset("assets/user/user.png"),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, NavigationConstants.PROFILE,
                                  arguments: UserType.mainUser);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ];
          },
          body: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DynamicSize.height(context, 0.02)),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    readOnly: true,
                    controller: TextEditingController(text:_advertVM.searchAdvert.toString()),
                    decoration: inputStyle.copyWith(
                      fillColor: Colors.white
                    ),
                    onChanged: (value) {
                      _advertVM.searchAdvert = SearchAdvert(location: value);
                      print(value);
                    },
                    onTap: (){
                      SearchFilter().dialog(context: context);
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DynamicSize.height(context, 0.03)),
                  child: const TabBarView(
                    //physics: ScrollPhysics(),
                    children: [
                      HomeProvider(),
                      BlogProvider(),
                      MessagesProvider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
*
*
* appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            margin: EdgeInsets.all(DynamicSize.height(context, 0.03)),
            height: DynamicSize.height(context, 0.06),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Palette.NAVBAR_BACKGROUND,
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    child: const CustomNavigationBar(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: CircularUserImage(
                      image: _appUserVM.appUser!.image != ""
                          ? Image.network(
                              _appUserVM.appUser!.image!,
                            )
                          : Image.asset("assets/user/user.png"),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, NavigationConstants.PROFILE,
                          arguments: UserType.mainUser);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            Flexible(
                flex: 7,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DynamicSize.height(context, 0.03)),
                  child: const TabBarView(
                    //physics: ScrollPhysics(),
                    children: [
                      HomeProvider(),
                      BlogProvider(),
                      MessagesProvider(),
                    ],
                  ),
                )),
          ],
        ),
*
* */
