import 'package:flutter/material.dart';
import 'package:miigaik/generated/icons.g.dart';

enum ItemNavBar {
  home(I.home),
  schedule(I.schedule),
  map(I.mapBottomNavBar),
  notes(I.notes),
  profile(I.profile);

  final IconData icon;

  const ItemNavBar(this.icon);

  static ItemNavBar defaultItem() => ItemNavBar.schedule;

  bool isFirstOrLast() => values.first == this || values.last == this;
}