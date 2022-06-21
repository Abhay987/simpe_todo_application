import 'package:flutter/material.dart';
import 'package:simple_todo_application/list_names.dart';

class AddEditItemInfo extends StatefulWidget {
  const AddEditItemInfo({Key? key}) : super(key: key);

  @override
  State<AddEditItemInfo> createState() => _AddEditItemInfoState();
}

class _AddEditItemInfoState extends State<AddEditItemInfo> {
  String itemName="";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Info',style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.keyboard_arrow_left,color: Colors.black,),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height-kToolbarHeight-MediaQuery.of(context).padding.top,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    validator: (value){
                      if (value!.trim().isEmpty || value == 'null') {
                        return '* Required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Add_Edit Task',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(
                          20.0, 15.0, 20.0, 15.0),

                      border: OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.grey),
                          borderRadius:BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.grey,width: 2),
                          borderRadius:BorderRadius.circular(10)
                      ),
                    ),
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    initialValue: args['isEditOrNot'] == true ? todoList[args['index']] : "",
                    onChanged: (value){
                      itemName = value;
                    },
                    keyboardType: TextInputType.text,

                  ),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      if(args['isEditOrNot']==true){
                        todoList[args['index']] = itemName.isEmpty ? todoList[args['index']] : itemName;
                        Navigator.pushNamed(context, '/');
                      }else {
                        todoList.add(itemName);
                        Navigator.pushNamed(context, '/');
                      }
                    }
                  }, child: const Text('Submit')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}