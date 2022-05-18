import 'package:flutter/material.dart';
import 'package:flutter_test1/Models/TableModel.dart';
import 'package:flutter_test1/Models/records.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();
  String dropdownValue = '1';
  int dropdownTable = 1;
  List<TableModel> availibleTables = [];
  List<Reservations> reservedTables = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    availibleTables = tables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Choose Reservation Date and time",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Selected Date :" +
                    "${selectedDate.toLocal()}".split(' ')[0]),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select date'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Choose Hour'),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: hours.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Choose Table'),
                DropdownButton<int>(
                  value: dropdownTable,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      dropdownTable = newValue!;
                    });
                  },
                  items: tableDropDown(
                      selectedDate.toString(), dropdownValue.toString()),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  reservedTables.add(Reservations(
                      reservedDate: selectedDate.toString(),
                      reservedHour: dropdownValue.toString(),
                      table_id: dropdownTable));

                  setState(() {
                    dropdownTable = tableDropDown(
                            selectedDate.toString(), dropdownValue.toString())
                        .first
                        .value!;
                  });
                },
                child: Text("Reserve Table")),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text("Reserved Tables"),
                  ...reservations(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> reservations() {
    List<Widget> list = [];

    reservedTables.forEach((element) {
      int hour = int.parse(element.reservedHour) + 1;
      list.add(Text("Table number ${element.table_id} is reserved for " +
          "${element.reservedDate}".split(' ')[0] +
          "from  ${element.reservedHour}  to ${hour}"));
    });
    return list;
  }

  List<DropdownMenuItem<int>> tableDropDown(String date, String hour) {
    List<DropdownMenuItem<int>> list = [];

    availibleTables.forEach((element) {
      if (reservedTables.isNotEmpty) {
        print("reserved table not empty");
        reservedTables.forEach((reservedTable) {
          if (element.id == reservedTable.table_id &&
              reservedTable.reservedDate == date &&
              reservedTable.reservedHour == hour) {
            print("Do not add");
          } else {
            list.add(DropdownMenuItem<int>(
              value: element.id,
              child: Text(element.id.toString()),
            ));
          }
        });
      } else {
        list.add(DropdownMenuItem<int>(
          value: element.id,
          child: Text(element.id.toString()),
        ));
      }
    });

    return list;
  }
}

List<String> hours = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24'
];

List<TableModel> tables() {
  List<TableModel> mytables = [];

  for (var i = 1; i <= 10; i++) {
    mytables.add(TableModel(id: i, reservedDate: '0', reservedHour: '0'));
  }

  return mytables;
}
