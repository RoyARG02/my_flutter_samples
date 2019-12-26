class Category{
  final num min;
  final num max;
  final String description;
  final String tagColor;
  Category(this.min, this.max, this.description, this.tagColor);

  @override
  String toString(){
    return '${this.description} => Max: ${this.max}, Min: ${this.min}.\n';
  }
}