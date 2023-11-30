import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidden/screens/components/account_pages/about_page.dart';
import 'package:hidden/screens/components/account_pages/my_profile_page.dart';
import 'package:hidden/screens/components/account_pages/policy_page.dart';
import 'package:hidden/screens/components/account_pages/updates_page.dart';

class AccountScreen extends StatefulWidget {
  final List<String>? userInfo;
  const AccountScreen({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final screens = [
      MyProfileScreen(userInfo: widget.userInfo),
      PolicyScreen(),
      UpdateScreen(),
      AboutScreen(),
    ];
    final List<AccountSetting> accountItem_1 = [
      AccountSetting(
        title: 'My Profile',
        icon: 'assets/icons/profile.3.svg',
        color: Colors.blueAccent,
        pageRoute: 0,
      ),
    ];
    final List<AccountSetting> accountItem_2 = [
      AccountSetting(
        title: 'Privacy Management',
        icon: 'assets/icons/shield-done.4.svg',
        color: Colors.lightBlue,
        pageRoute: 1,
      ),
      AccountSetting(
        title: 'Check for updates',
        icon: 'assets/icons/arrow-up-square.2.svg',
        color: Colors.green,
        pageRoute: 2,
      ),
      AccountSetting(
        title: 'About',
        icon: 'assets/icons/info-square.3.svg',
        color: Colors.blue,
        pageRoute: 3,
      ),
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipOval(
              child: SvgPicture.asset(
                'assets/icons/profile.5.svg',
                fit: BoxFit.cover,
                color: Colors.blue,
                height: 75,
                width: 75,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 20,
            ),
          ),
          Center(
            child: Text(
              widget.userInfo![0],
              style: TextStyle(
                // color: kPrimaryColor,
                fontSize: 25,
                fontFamily: 'Comfortaa_bold',
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Profile',
                  style: TextStyle(
                    // color: kPrimaryColor,
                    fontSize: 15,
                    fontFamily: 'Comfortaa_bold',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    // height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        for (final element in accountItem_1)
                          settingsElement(
                            context,
                            element,
                            accountItem_1,
                            screens,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Others',
                  style: TextStyle(
                    // color: kPrimaryColor,
                    fontSize: 15,
                    fontFamily: 'Comfortaa_bold',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    // height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        for (final element in accountItem_2)
                          settingsElement(
                            context,
                            element,
                            accountItem_2,
                            screens,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsElement(BuildContext context, AccountSetting element,
      List<AccountSetting> accountItem, List<StatelessWidget> screens) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => screens[element.pageRoute]),
        ),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            child: SvgPicture.asset(
              element.icon,
              color: element.color,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              height: 50,
              decoration: element != accountItem.last
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context)
                              .iconTheme
                              .color!
                              .withOpacity(0.4),
                        ),
                      ),
                    )
                  : BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    element.title,
                    style: TextStyle(
                      // color: kPrimaryColor,
                      fontSize: 15,
                      fontFamily: 'Comfortaa_regular',
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/arrow-right-2.4.svg',
                    height: 20,
                    width: 20,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.7),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountSetting {
  final String title, icon;
  final Color color;
  final int pageRoute;

  const AccountSetting({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.pageRoute,
  });
}
