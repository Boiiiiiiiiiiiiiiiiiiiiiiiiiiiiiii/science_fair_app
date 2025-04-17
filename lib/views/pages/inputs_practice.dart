import 'package:flutter/material.dart';

class InputsPractice extends StatefulWidget {
  const InputsPractice({super.key});

  @override
  State<InputsPractice> createState() => _InputsPracticeState();
}

class _InputsPracticeState extends State<InputsPractice> {

  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  double sliderValue = 0.0;
  String? menuItem = 'e1';
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("SnackBar"), 
                    duration: Duration(seconds: 5),
                    behavior: SnackBarBehavior.floating
                  )
                );
              },
              child: Text('Open SnackBar')
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                  title: Text("Alert title"),
                  content: Text("Alert content"),
                  actions: [
                    FilledButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Text("Close")
                    )
                  ],
                );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white
              ),
              child: Text('Open Dialogue')
            ),
            DropdownButton(
              value: menuItem,
              underline: SizedBox(),
              items: [
                DropdownMenuItem(value: 'e1',child: Text('Element1'),),
                DropdownMenuItem(value: 'e2', child: Text('Element2')),
                DropdownMenuItem(value: 'e3',child: Text('Element3'),),
              ], 
              onChanged: (String? value) {
                setState(() {
                  menuItem = value;
                });
              },
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
              onEditingComplete: () => setState(() {}),
            ),
            Text(controller.text),
            Checkbox(
              tristate: true,
              value: isChecked, 
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value;
                });
              },
            ),
            CheckboxListTile(
              tristate: true,
              title: Text("ListTileCheckbox"),
              value: isChecked, 
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value;
                });
              },
            ),
            Switch(
              value: isSwitched, 
              onChanged: (bool value) {
                setState(() {
                  isSwitched = value;
                });
              }, 
            ),
            SwitchListTile(
              title: Text("SwitchListTile"),
              value: isSwitched, 
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
            Slider(
              value: sliderValue, 
              divisions: 10,
              onChanged: (double value) {
                setState(() {
                  sliderValue = value;
                });
                print(value);
              },
            ),
            InkWell(
              splashColor: Colors.teal.shade900,
              onTap: () {
                print("Image TAPped");
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.white12,
              )
            ),
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: Text('ClickMe')
            ),
            ElevatedButton(
              onPressed: () {
                
              },
              child: Text('ClickMe')
            ),
            FilledButton(
              onPressed: () {
                
              },
              child: Text('ClickMe')
            ),
            TextButton(
              onPressed: () {
                
              },
              child: Text('ClickMe')
            ),
            OutlinedButton(
              onPressed: () {
                
              },
              child: Text('ClickMe')
            ),
            CloseButton(
              onPressed: () {
                
              },
            ),
            BackButton(
              onPressed: () {
                
              },
            )
          ],
        ),
      ),
    );
  }
}