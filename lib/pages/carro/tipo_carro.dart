class TipoCarro {
  final String _tipo;

  TipoCarro.esportivos() : this._tipo = "esportivos";

  TipoCarro.classicos() : this._tipo = "classicos";

  TipoCarro.luxo() : this._tipo = "luxo";

  get tipo => _tipo;
}
