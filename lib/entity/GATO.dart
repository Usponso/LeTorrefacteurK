class GATO{
  final int taste;
  final int bitterness;
  final int tenor;
  final int smell;

  GATO({required this.taste, required this.bitterness, required this.tenor, required this.smell});

  GATO.fromJson(Map<String, dynamic> json)
      :
        taste = json['taste'],
        bitterness = json['bitterness'],
        tenor = json['tenor'],
        smell = json['smell'];

  Map<String, dynamic> toJson() => {
    'taste': taste,
    'bitterness': bitterness,
    'tenor': tenor,
    'smell': smell,
  };
}