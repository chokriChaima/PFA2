class Director{
  String? directorUID;
  String? passwordDirector;
  String? emailDirector;

  Director({this.emailDirector,this.directorUID,this.passwordDirector});

  // this is a names constructor
  factory Director.fromMap(map){
    return Director(
      emailDirector : map['emailDirector'],
      directorUID :  map['directorUID'],
      passwordDirector : map['passwordDirector'],
    );
  }
}