import 'package:flutter/cupertino.dart';

abstract class ProfileTab extends StatelessWidget {
  final String title;
  final IconData icon;

  ProfileTab(this.title, this.icon);
}