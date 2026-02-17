import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miigaik/features/root/tabs/map/models/category_model.dart';

part 'search_map_state.dart';

class SearchMapCubit extends Cubit<SearchMapState> {
  SearchMapCubit() : super(SearchMapState(searchText: ''));

  void setSearchText(String text) {
    emit(SearchMapState(searchText: text));
  }

  List<CategoryModel> search(List<CategoryModel> data){
    if (state.searchText.isEmpty) {
      return [];
    }
    final lowerSearchText = state.searchText.toLowerCase();
    final result = data.map((category) {
        final filteredRooms = category.rooms
            .where((room) => room.label.toLowerCase().contains(lowerSearchText))
            .toList();
        if (filteredRooms.isNotEmpty) {
          return CategoryModel(name: category.name, rooms: filteredRooms);
        }
        return null;
      })
      .whereType<CategoryModel>()
      .toList();
    return result;
  }
}
