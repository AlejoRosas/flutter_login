import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/screens/add_page.dart';
import 'package:login/services/todo_service.dart';
import 'package:login/utils/snackbar_helper.dart';

import '../widgets/navbar.dart';

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  bool isLoading = true;
  List items = [];
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyNavBar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 61, 70),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(       
                style: BorderStyle.none,
                borderRadius: const BorderRadius.all(Radius.circular(20))  
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              
              children: [
                const TableRow(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 76, 74, 74),
                      borderRadius: BorderRadius.vertical(top:Radius.circular(20))//Color celda
                      ),
                  
                  children: [
                    TableCell(
                      
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(child: Text('Location')),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(child: Text('Value')),
                      ),
                    ),
                  ],
                ),
                ...List.generate(
                  items.length,
                  (index) => TableRow(
                    decoration: BoxDecoration(
                       gradient: index % 2 == 0 ? 
                       const LinearGradient(
                        colors: [
                          Colors.redAccent,
                          Colors.purpleAccent
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        
                      )
                       : const LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Colors.greenAccent
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        
                      ),
                       
                      //borderRadius: BorderRadius.all(Radius.circular(12))//Color celda
                      borderRadius: index == items.length - 1
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    : BorderRadius.zero,
                    ),
                    
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 12,
                          ),
                          child: Text(items[index]['nombre']),
                        ),
                      ),
                      TableCell(
                        
                        child: Padding(
                          
                          padding: const EdgeInsets.symmetric(horizontal: 65.0),
                          child: Text('${items[index]['valor']}'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add Todo'),
      ),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(location: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  void navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    // Delete the item
    final isSuccess = await TodoService.deleteById(id);

    if (isSuccess) {
      fetchTodo();
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message: 'Element deleted successfully');
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Failed to delete element');
    }
  }

  Future<void> fetchTodo() async {
    final response = await TodoService.fetchTodos();

    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Fetch Failed');
    }

    setState(() {
      isLoading = false;
    });
  }
}
