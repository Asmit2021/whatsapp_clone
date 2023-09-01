import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedGroupContactsNotifier extends StateNotifier<List<Contact>> {
  SelectedGroupContactsNotifier() : super([]);

  void add(Contact contact) {
    state = [...state, contact];
  }

  void clear() {
    state = [];
  }
}

final selectedGroupContactsProvider =
    StateNotifierProvider<SelectedGroupContactsNotifier, List<Contact>>(
        (ref) => SelectedGroupContactsNotifier());
