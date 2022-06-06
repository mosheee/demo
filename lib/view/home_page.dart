import 'package:demo_architecture/view/components/avatar.dart';
import 'package:demo_architecture/view/components/button.dart';
import 'package:demo_architecture/view/components/swipes.dart';
import 'package:demo_architecture/view/drawer.dart';
import 'package:demo_architecture/view/loading_page.dart';
import 'package:demo_architecture/viewModel/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ViewModel, HomePageState>(
        selector: (_, model) => model.homePageState,
        builder: (_, homePageState, child) {
          switch (homePageState) {
            case HomePageState.loading:
              {
                return const LoadingPage();
              }
            case HomePageState.dataReady:
              {
                return const Ui();
              }
            case HomePageState.error:
              {
                return const ErrorCard();
              }
            default:
            return const SizedBox();
          }
        });
  }
}

class Ui extends StatelessWidget {
  const Ui({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        actions: [
          TextButton(
              child: const Text(
                "Change Group",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.pushNamed(context, '/switch')),
          TextButton(
              onPressed: () =>
                  Provider.of<ViewModel>(context, listen: false).throwError(),
              child: const Text(
                "throw random error",
                style: TextStyle(color: Colors.white),
              ))
        ],
        leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Selector<ViewModel, Widget>(
                selector: (_, model) => model.currentUser!.avatar,
                builder: (context, avatar, _) {
                  return GestureDetector(
                    child: UserAvatar(
                      avatar: avatar,
                    ),
                    onTap: () => Scaffold.of(context).openDrawer(),
                  );
                })),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Swipes(),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [XButton(), LikeButton()],
          ),
        ],
      ),
    );
  }
}
