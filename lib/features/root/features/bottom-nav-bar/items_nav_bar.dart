import 'package:flutter/material.dart';
import 'package:miigaik/generated/icons.g.dart';

enum ItemNavBar {
  schedule(I.schedule),
  map(I.map),
  news(I.news),
  notes(I.notes),
  profile(I.profile);

  final IconData icon;

  const ItemNavBar(this.icon);

  static ItemNavBar defaultItem() => ItemNavBar.schedule;

  bool isFirstOrLast() => [values.first, values.last].contains(this);
}