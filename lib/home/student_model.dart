class Student {
  int id;
  String name;
  String dob;
  Student(this.id, this.name,this.dob);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'dob': dob,
    };
    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    dob = map['dob'];
  }
}