import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(String) deleteTodo;
  const TodoCard({
    super.key,
    required this.index,
    required this.item,
    required this.navigateEdit,
    required this.deleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    final id = item['id'].toString();
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['nombre']),
        subtitle: Text('Value ${item['valor'].toString()}'),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              // Open edit page
              navigateEdit(item);
            } else if (value == 'delete') {
              // Delete and remove the item
              deleteTodo(id);
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ];
          },
        ),
      ),
    );
  }
}
