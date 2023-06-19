class FieldValidator{
  
  static String? ValidarNome(String? value){
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "Este campo deve ser preenchido";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }else {
      return null;
    }
  }

  static String? ValidarEmail(String? value){
    String patttern = r'(^[\w+.]+@\w+\.\w{2,}(?:\.\w{2})?$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "Este campo deve ser preenchido";
    } else if (!regExp.hasMatch(value)) {
      return "Informe um email valido";
    }else {
      return null;
    }
  }

  static String? ValidarSenha(String? value){
    //String patttern = r'(^[\w+.]+@\w+\.\w{2,}(?:\.\w{2})?$)';
    //RegExp regExp = new RegExp(patttern);
    if (value!.isEmpty) {
      return "Este campo deve ser preenchido";
    //} else if (!regExp.hasMatch(value)) {
      //return "Informe um email valido";
    }else {
      return null;
    }
  }
}