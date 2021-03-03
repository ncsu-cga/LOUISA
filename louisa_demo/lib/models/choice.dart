class Choice {
  String _text;
  int _value;
  bool _isSelected;
  bool _isFreeText;

  Choice();

  Choice.withParams(String text, int value, 
      [bool isSelected=false,bool isFreeText = false]) {
    this._text = text;
    this._value = value;
    this._isSelected = isSelected;
    this._isFreeText = isFreeText;
  }

  get text => this._text;
  set text(String text) {
    this._text = text;
  }

  get value => this._value;
  set value(int value) {
    this._value = value;
  }

  get isSelected => this._isSelected;
  set isSelected(bool isSelected) {
    this._isSelected = isSelected;
  }

  get isFreeText => this._isFreeText;
  set isFreeText(bool isFreeText) {
    this._isFreeText = isFreeText;
  }

  @override
  String toString() {
    // ignore: unnecessary_brace_in_string_interps
    return 'Choice: {text: ${_text}, value: ${_value}, isSelected: ${_isSelected}, isFreeText: ${_isFreeText}}';
  }
}
