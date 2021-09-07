class tool{
  static String FormatContent(String content){
    if(!content.contains('[quote]')){
      return content;
    }
    var f1=content.split('):[/b]<br/><br/>')[1];
    var pair=f1.split('[/quote]<br/><br/>');
    return "回复："+pair[0].replaceAll(RegExp(r'<br/>') , " ")+"----------"+pair[1].replaceAll(RegExp(r'<br/>'), " ");
  }
}