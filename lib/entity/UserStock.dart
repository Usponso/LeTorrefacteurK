class UserStock{
  double arbrista;
  double rubisca;
  double goldoria;
  double roupetta;
  double tourista;

  UserStock({required this.arbrista, required this.rubisca, required this.goldoria, required this.roupetta, required this.tourista});

  UserStock.fromJson(Map<String, dynamic> json)
      :
        arbrista = json['arbrista'].toDouble(),
        rubisca = json['rubisca'].toDouble(),
        goldoria = json['goldoria'].toDouble(),
        roupetta = json['roupetta'].toDouble(),
        tourista = json['tourista'].toDouble();
}