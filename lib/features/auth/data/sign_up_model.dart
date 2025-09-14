class SignUpModel{
  final String name;
  final String email;
  final String password;
  final String phone;

  SignUpModel({required this.email, required this.password, required this.name, required this.phone,});



  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
    };
  }

}