import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_widget/search_widget.dart';
import 'package:test_fix/providers/account.dart';
import 'package:test_fix/widgets/pop_up_list_item.dart';
import 'package:test_fix/widgets/selected_item.dart';
import '../providers/accounts.dart';
import 'my_text_field_item.dart';
import 'no_item_found_item.dart';

class SearchAccountItem extends StatefulWidget {
  const SearchAccountItem({Key? key}) : super(key: key);

  @override
  State<SearchAccountItem> createState() => _SearchAccountItemState();
}

class _SearchAccountItemState extends State<SearchAccountItem> {
  @override
  Widget build(BuildContext context) {
    final listAccount =
        Provider.of<Accounts>(context, listen: false).getListEducation();
    Account selectedAccount;
    bool show = true;

    return Card(
      child: FutureBuilder(
          future: listAccount,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              List<Account> listItem = snapshot.data as List<Account>;
              return SearchWidget<Account>(
                dataList: listItem,
                hideSearchBoxWhenItemSelected: true,
                listContainerHeight: MediaQuery.of(context).size.height / 5,
                queryBuilder: (query, list) {
                  return list
                      .where((item) => item.userName
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                },
                popupListItemBuilder: (item) {
                  return PopupListItem(
                    account: item,
                  );
                },
                // widget customization
                noItemsFoundWidget: const NoItemsFoundItem(),
                textFieldBuilder: (controller, focusNode) {
                  return MyTextFieldItem(
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
                onItemSelected: (item) {
                  setState(() {
                    selectedAccount = item;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => SelectedItem(account: item),
                      ),
                    );
                  });
                },
              );
            } else {
              return const Center(
                child: Text('Errors'),
              );
            }
          }),
    );
  }
}
