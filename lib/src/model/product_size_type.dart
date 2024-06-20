import 'package:laptop_harbor/src/model/categorical.dart';
import 'package:laptop_harbor/src/model/numerical.dart';

class ProductSizeType {
  List<Numerical>? numerical;
  List<Categorical>? categorical;

  ProductSizeType({this.numerical, this.categorical});
}
