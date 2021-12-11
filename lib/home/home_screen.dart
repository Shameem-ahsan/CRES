import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xgensys_machine_test/database/db_helper.dart';
import 'package:xgensys_machine_test/home/model/student_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Student>> students;
  String _studentName;
  bool isUpdate = false;
  int studentIdForUpdate;
  DBHelper dbHelper;
  final _studentNameController = TextEditingController();
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshStudentList();
  }

  refreshStudentList() {
    setState(() {
      students = dbHelper.getStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRES STUDENT DATAS'),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formStateKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Student Name';
                      }
                      if (value.trim() == "")
                        return "Only Space is Not Valid!!!";
                      return null;
                    },
                    onSaved: (value) {
                      _studentName = value;
                    },
                    controller: _studentNameController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.purple,
                                width: 2,
                                style: BorderStyle.solid)),
                        // hintText: "Student Name",
                        labelText: "Student Name",
                        icon: Icon(
                          Icons.business_center,
                          color: Colors.purple,
                        ),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.purple,
                        )),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: InkWell(
                      onTap: () => _pickDateDialog(),
                      child: Row(
                        children: [
                          Text("Select DOB"),
                          IconButton(
                            icon: Icon(Icons.calendar_today),),
                        ],
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child:
                  Text(_selectedDate == null //ternary expression to check if date is null
                      ? 'No date was chosen!'
                      : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                    style: TextStyle(fontSize: 18), textAlign: TextAlign.start,),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.purple,
                child: Text(
                  (isUpdate ? 'UPDATE' : 'ADD'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (isUpdate) {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      dbHelper
                          .update(Student(studentIdForUpdate, _studentName, DateFormat.yMMMd().format(_selectedDate)))
                          .then((data) {
                        setState(() {
                          isUpdate = false;
                        });
                      });
                    }
                  } else {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      dbHelper.add(Student(null, _studentName, DateFormat.yMMMd().format(_selectedDate)));
                    }
                  }
                  _studentNameController.text = '';
                  _selectedDate = null;
                  //_studentDobController.text = '';
                  refreshStudentList();
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  (isUpdate ? 'CANCEL UPDATE' : 'CLEAR'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _studentNameController.text = '';
                  _selectedDate = null;
                  //_studentDobController.text = '';
                  setState(() {
                    isUpdate = false;
                    studentIdForUpdate = null;
                  });
                },
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: students,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateList(snapshot.data);
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Text('No Data Found');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView generateList(List<Student> students) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('NAME & DOB'),
            ),
            DataColumn(
              label: Text('DELETE'),
            ),
          ],
          rows: students
              .map(
                (student) =>
                DataRow(
                  cells: [
                    DataCell(Text('${student.name} - ${student.dob}'),
                        onTap: ()  {
                        setState(() {
                        isUpdate = true;
                        studentIdForUpdate = student.id;
                        });
                        _studentNameController.text = student.name;
                        _selectedDate=student.name as DateTime;
                    }
                    ),
                    //DataCell(Text(student.dob)),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          dbHelper.delete(student.id);
                          refreshStudentList();
                        },
                      ),
                    ),

                  ],
                ),
          )
              .toList(),
        ),
      ),
    );
  }


  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }


}