import 'dart:convert';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:miigaik/features/root/tabs/map/models/category_model.dart';
import 'package:miigaik/features/root/tabs/map/models/room_model.dart';

class MapWrapper {
  final InAppWebViewController controller;

  MapWrapper({required this.controller});

  Future<void> injectFix() async {
    await controller.evaluateJavascript(source: """
      (function() {
        var style = document.createElement('style');
        style.type = 'text/css';
        style.innerHTML = `
          .mapboxgl-ctrl-bottom-left,
          .map-overlay-inner,
          .mapboxgl-ctrl-bottom-right {
            display: none !important;
          }
        `;
        document.head.appendChild(style);
        
        if (typeof mapboxgl !== 'undefined') {
          // Подменяем конструктор Popup на пустышку
          mapboxgl.Popup = function() {
            return {
              setLngLat: function() { return this; },
              setHTML: function() { return this; },
              addTo: function() { return this; },
              remove: function() {}
            };
          };
        }
        
        // Удаляем уже существующие popup (на всякий случай)
        document.querySelectorAll('.mapboxgl-popup').forEach(el => el.remove());
      })();
    """);
  }

  Future<void> navigateToRoomByID(int roomId) async {
    final jsCode = "window.location.hash = '#id=$roomId';";
    await controller.evaluateJavascript(source: jsCode);
  }

  Future<void> navigateToRoomByLabel(String label) async {
    final jsCode = "window.location.hash = '#room=$label';";
    await controller.evaluateJavascript(source: jsCode);
  }

  Future<void> navigateToRoom(RoomModel room) async {
    if (room.id != 0) {
      await navigateToRoomByID(room.id);
    } else {
      await navigateToRoomByLabel(room.label);
    }
  }

  Future<void> changeFloor(int floor) async {
    final jsCode = "window.location.hash = '#l=$floor';";
    await controller.evaluateJavascript(source: jsCode);
  }

  Future<List<CategoryModel>> fetchCategoriesRooms() async {
    final result = await controller.evaluateJavascript(source: """
    (function() {
      if (typeof search_data === 'undefined') return '[]';
      
      // Фильтруем и нормализуем элементы
      var validItems = search_data.filter(function(item) {
        return item.label && 
               typeof item.label === 'string' && 
               item.label.trim() !== '' &&
               item.category && 
               typeof item.category === 'string' &&
               item.id_room != null &&
               item.floor != null;
      }).map(function(item) {
        return {
          label: item.label.trim(),
          category: item.category,
          id: item.id_room,
          floor: item.floor
        };
      });
      
      // Группировка по полю category
      var groups = {};
      validItems.forEach(function(item) {
        var cat = item.category;
        if (!groups[cat]) groups[cat] = [];
        groups[cat].push(item);
      });
      
      // Преобразуем в массив категорий
      var categories = [];
      for (var catName in groups) {
        categories.push({
          name: catName,
          rooms: groups[catName]
        });
      }
      
      return JSON.stringify(categories);
    })();
  """);

    final List<dynamic> list = jsonDecode(result);
    final categories = list.map(
      (json) => CategoryModel.fromJson(json as Map<String, dynamic>)
    ).toList();
    return categories;
  }
}