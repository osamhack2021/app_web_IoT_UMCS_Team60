validateId() => (String? value) {
    if (value!.isEmpty) {return "아이디를 입력하세요.";}
    else if (value.length < 3) {return "아이디의 최소 길이는 3자입니다.";}
    else { return null;}
  };

validatePw() => (String? value) {
    if (value!.isEmpty) {return "비밀번호를 입력하세요.";}
    else if (value.length > 12) {return "패스워드의 길이를 초과하였습니다.";} 
    else if (value.length < 4) { return "패스워드의 최소 길이는 4자입니다.";} 
    else { return null;}
  };