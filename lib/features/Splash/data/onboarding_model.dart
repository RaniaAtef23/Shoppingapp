
class onboarding_model{
  String image;
  String title;
  String description;
  onboarding_model({required this.title,required this.image,required this.description});
}
List<onboarding_model>contents=[
  onboarding_model(title: "Choose your product", image:"assets/onboarding1.gif",description:"Welcome to the world of limitless choices-Your perfect product awaits!" ),
  onboarding_model(title: "Select payment method", image: "assets/onboarding2.gif",description:"For Seamless Transactions,Choose Your Payment Path-Yout convienence ,Our periority" ),
  onboarding_model(title: "Deliver At Your Door Step", image: "assets/onboarding3.gif",description: "From Our Door Step To Yours"),
];