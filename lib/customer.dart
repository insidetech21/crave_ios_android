class Customer {
  String id;
  final String image;
  final String name;
  final String email;
  final String genderValue;
  final String mobilenumber;
  final String addressStreet1;
  //final String addressStreet2;
  final String pincode;
  final String cityValue1;
  final String stateValue1;
  final String countryValue1;
  final String companyName;
  final String companyAdd;
  final String companyMail;
  final String website;
  final String interestedInValue;
  final String nextStepsValue;
  final String reachOutValue;
  final String dateOfNextStepscontroller;
  final String comments;


  Customer({
    this.id = '',
    required this.image,
    required this.name,
    required this.email,
    required this.genderValue,
    required this.mobilenumber,
    required this.addressStreet1,
    //required this.addressStreet2,
    required this.pincode,
    required this.cityValue1,
    required this.stateValue1,
    required this.countryValue1,
    required this.companyName,
    required this.companyAdd,
    required this.companyMail,
    required this.website,
    required this.interestedInValue,
    required this.nextStepsValue,
    required this.reachOutValue,
    required this.dateOfNextStepscontroller,
    required this.comments,

  });

  Map<String, dynamic> toJson() => {
    'image':image,
    'id': id,
    'name': name,
    'email': email,
    'genderValue': genderValue,
    'mobilenumber': mobilenumber,
    'addressStreet1': addressStreet1,
    //'addressStreet2': addressStreet2,
    'pincode': pincode,
    'cityValue1': cityValue1,
    'stateValue1': stateValue1,
    'countryValue1': countryValue1,
    'companyName':companyName,
    'companyAdd': companyAdd,
    'companyMail': companyMail,
    'website': website,
    'interestedInValue' : interestedInValue,
    'nextStepsValue' : nextStepsValue,
    'reachOutValue' : reachOutValue,
    'dateOfNextStepscontroller' : dateOfNextStepscontroller,
    'comments' : comments,
  };

  static Customer fromJson(Map<String, dynamic> json) =>
      Customer(
        image: json['image'],
        name: json['name'],
        email: json['email'],
        genderValue: json['genderValue'],
        mobilenumber: json['mobilenumber'],
        pincode: json['pincode'],
        addressStreet1: json ['addressStreet1'],
        //addressStreet2: json ['addressStreet2'],
        cityValue1: json['cityValue1'],
        stateValue1: json['stateValue1'],
        countryValue1: json['countryValue1'],
        companyName: json['companyName'],
        companyAdd: json['companyAdd'],
        companyMail: json['companyMail'],
        website: json['website'],
        interestedInValue: json['interestedInValue'],
        nextStepsValue: json['nextStepsValue'],
        reachOutValue: json['reachOutValue'],
        dateOfNextStepscontroller: json['dateOfNextStepscontroller'],
        comments: json['comments'],
      );
}