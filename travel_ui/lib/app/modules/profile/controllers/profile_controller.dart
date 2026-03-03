import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  final List<ProfileTabItem> tabs = const [
    ProfileTabItem(label: 'Settings'),
    ProfileTabItem(label: 'Account'),
    ProfileTabItem(label: 'Plans'),
  ];

  final List<ProfileActionItem> settingsActions = const [
    ProfileActionItem(
      title: 'Notifications',
      subtitle: 'Push and email alerts',
    ),
    ProfileActionItem(
      title: 'Privacy',
      subtitle: 'Manage visibility and activity',
    ),
    ProfileActionItem(
      title: 'Security',
      subtitle: 'Passcode, biometrics and devices',
    ),
  ];

  final List<ProfileActionItem> accountActions = const [
    ProfileActionItem(
      title: 'Personal info',
      subtitle: 'Name, email and phone',
    ),
    ProfileActionItem(
      title: 'Payment methods',
      subtitle: 'Cards and billing details',
    ),
    ProfileActionItem(
      title: 'Travel preferences',
      subtitle: 'Room, meal and trip defaults',
    ),
  ];

  final List<ProfileActionItem> subscriptionActions = const [
    ProfileActionItem(
      title: 'Premium Traveler',
      subtitle: 'Active until Dec 31, 2026',
    ),
    ProfileActionItem(
      title: 'Lounge Access',
      subtitle: '8 visits remaining this year',
    ),
    ProfileActionItem(
      title: 'Rewards wallet',
      subtitle: '12,450 points available',
    ),
  ];

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  List<ProfileActionItem> get activeItems {
    switch (selectedTabIndex.value) {
      case 1:
        return accountActions;
      case 2:
        return subscriptionActions;
      default:
        return settingsActions;
    }
  }
}

class ProfileTabItem {
  final String label;

  const ProfileTabItem({required this.label});
}

class ProfileActionItem {
  final String title;
  final String subtitle;

  const ProfileActionItem({required this.title, required this.subtitle});
}
