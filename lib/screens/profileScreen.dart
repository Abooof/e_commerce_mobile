// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import '../Widget/homeAppBar.dart';
// import '../helpers/Sizes.dart';
// import '../helpers/search.dart';
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             THomeAppBar(),
//             SizedBox(height: Allsizes.spaceBtwSections),
//             Text('Profile Screen'),
//
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:e_commerce_mobile/Widget/homeAppBar.dart';
import 'package:flutter/material.dart';
import '../components/profile_menu.dart';
import '../components/profile_pic.dart';
import 'CompleteProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Profile"),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
             THomeAppBar(),

            const ProfilePic(imageUrl: '',),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {Navigator.pushNamed(context,
                  CompleteProfileScreen.routeName)},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bill Icon.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
