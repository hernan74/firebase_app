class LoginModel {
  String _correo = '';
  String _clave = '';

  get correo => _correo;

  set correo(String correo) => this._correo = correo;

  get clave => _clave;

  set clave(String clave) => this._clave = clave;
}
