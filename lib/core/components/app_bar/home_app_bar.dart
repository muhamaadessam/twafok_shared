import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twafok/core/core.dart';

import '../../../features/profile/presentation/controllers/profile_cubit.dart';
import '../../../features/profile/presentation/screens/profile_screen.dart';
import '../../../notification/presentation/screens/notification_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.mainColor,
          ),
          height:
              heightRation(context, 128) + MediaQuery.paddingOf(context).top,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.paddingOf(context).top + 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state.status == ProfileStates.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                width: widthRation(context, 40),
                                height: heightRation(context, 40),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: CustomNetworkImage(
                                  image: state.user!.avatar,
                                  isUserImage: true,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OfflineProfileScreen(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: widthRation(context, 8),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBody14(
                                  '${state.user!.profile!.firstName} ${state.user!.profile!.lastName}',
                                  color: Colors.white,
                                ),
                                TextBody14(
                                  state.user!.jobTitle,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationsScreen()));
                      },
                      child: Badge.count(
                        count: 200,
                        // backgroundColor: const Color(0xffff0000),
                        textColor: Colors.white,
                        alignment: Alignment.topRight,
                        textStyle: const TextStyle(fontSize: 10),
                        largeSize: 8,
                        smallSize: 5,
                        padding: const EdgeInsets.all(3),
                        child: SvgPicture.asset(
                          Assets.bill,
                          width: widthRation(context, 28),
                          // ignore: deprecated_member_use
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // GestureDetector(
                //   onTap: () {
                //     // colorController.changeDark(CacheHelper.get(key: 'isDark'));
                //     colorController
                //         .changeTheme(!CacheHelper.get(key: 'isDark'));
                //   },
                //   child: Image.asset(
                //     CacheHelper.get(key: 'isDark')
                //         ? 'assets/png/darkMode.png'
                //         : 'assets/png/lightMode.png',
                //     height: heightRation(context, 24),
                //     width: widthRation(context, 24),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
