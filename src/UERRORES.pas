unit UERRORES;
//Resumen: unidad encargada de reportar errores lexicos y sintacticos de forma
//clara y profesional: indica numero de linea, columna, que se esperaba, que se
//encontro y muestra la linea fuente con un cursor (^) que senala el error.
interface
USES UTIPOS,SysUtils;

//Devuelve el numero de linea (base 1) de una posicion dada en el archivo fuente
Function CalcularLinea(Var Fuente:TFuente;Posicion:LongInt):LongInt;
//Devuelve la columna (base 1) de una posicion y deja en Linea el numero de linea correspondiente
Function CalcularColumna(Var Fuente:TFuente;Posicion:LongInt;Var Linea:LongInt):LongInt;
//Devuelve el texto (sin fin de linea) de una linea indicada del archivo fuente
Function LeerLinea(Var Fuente:TFuente;Linea:LongInt):String;
//Devuelve un nombre legible para un terminal o componente lexico
Function NombreAmigable(T:VARIABLESYTERMINALES):String;
//Muestra un error sintactico con linea, columna, lo esperado, lo encontrado y el contexto
Procedure ErrorSintactico(Var Fuente:TFuente;Posicion:LongInt;Esperado:VARIABLESYTERMINALES;Encontrado:VARIABLESYTERMINALES;Lexema:String);
//Muestra un error de simbolo inesperado (cuando la TAS no define la combinacion variable+terminal)
Procedure ErrorInesperado(Var Fuente:TFuente;Posicion:LongInt;Encontrado:VARIABLESYTERMINALES;Lexema:String;Contexto:String);
//Muestra un error lexico con linea, columna, el simbolo invalido y el contexto
Procedure ReportarErrorLexico(Var Fuente:TFuente;Posicion:LongInt);

implementation

//Devuelve el numero de linea (base 1) de una posicion dada en el archivo fuente
Function CalcularLinea(Var Fuente:TFuente;Posicion:LongInt):LongInt;
Var
	i:LongInt;
	c:Char;
	linea:LongInt;
Begin
	linea:=1;
	CalcularLinea:=1;
	If Posicion<=0 Then Exit;
	Seek(Fuente,0);
	For i:=0 To Posicion-1 Do
	Begin
		If Eof(Fuente) Then Break;
		Read(Fuente,c);
		If c=#10 Then Inc(linea);
	End;
	CalcularLinea:=linea;
End;

//Devuelve la columna (base 1) de una posicion y deja en Linea el numero de linea correspondiente
Function CalcularColumna(Var Fuente:TFuente;Posicion:LongInt;Var Linea:LongInt):LongInt;
Var
	i:LongInt;
	c:Char;
	col:LongInt;
Begin
	Linea:=1;
	CalcularColumna:=1;
	If Posicion<=0 Then Exit;
	Seek(Fuente,0);
	col:=0;
	For i:=0 To Posicion-1 Do
	Begin
		If Eof(Fuente) Then Break;
		Read(Fuente,c);
		If c=#10 Then
		Begin
			Inc(Linea);
			col:=0;
		End
		Else
			Inc(col);
	End;
	CalcularColumna:=col+1;
End;

//Devuelve el texto (sin fin de linea) de una linea indicada del archivo fuente
Function LeerLinea(Var Fuente:TFuente;Linea:LongInt):String;
Var
	c:Char;
	actual:LongInt;
	s:String;
Begin
	s:='';
	actual:=1;
	Seek(Fuente,0);
	While (Not Eof(Fuente)) And (actual<=Linea) Do
	Begin
		Read(Fuente,c);
		If c=#10 Then
		Begin
			If actual=Linea Then Break;
			Inc(actual);
			s:='';
		End
		Else If (c<>#13) And (actual=Linea) Then
			s:=s+c;
	End;
	LeerLinea:=s;
End;

//Devuelve un nombre legible para un terminal o componente lexico
Function NombreAmigable(T:VARIABLESYTERMINALES):String;
Begin
	Case T Of
		ID:NombreAmigable:='identificador';
		PARENTESISA:NombreAmigable:='(';
		PARENTESISB:NombreAmigable:=')';
		PUNTO:NombreAmigable:='.';
		DOSPUNTOS:NombreAmigable:=':';
		COMA:NombreAmigable:=',';
		ASIGNACION1:NombreAmigable:=':=';
		SUMA:NombreAmigable:='+';
		RESTA:NombreAmigable:='-';
		MULT:NombreAmigable:='*';
		DIB:NombreAmigable:='/';
		RAIZ:NombreAmigable:='raiz';
		POTEN:NombreAmigable:='^';
		CONSTANTEREAL:NombreAmigable:='constante real';
		CONSTANTECADENA:NombreAmigable:='constante de texto';
		LEER:NombreAmigable:='leer';
		MOSTRAR:NombreAmigable:='mostrar';
		SI:NombreAmigable:='si';
		SINO:NombreAmigable:='sino';
		MIENTRAS:NombreAmigable:='mientras';
		PARA:NombreAmigable:='para';
		CASOS:NombreAmigable:='casos';
		MENOR:NombreAmigable:='<';
		MAYOR:NombreAmigable:='>';
		MAYORI:NombreAmigable:='>=';
		MENORI:NombreAmigable:='<=';
		DISTINTO:NombreAmigable:='<>';
		IGUAL:NombreAmigable:='=';
		AN:NombreAmigable:='and';
		O:NombreAmigable:='or';
		FUNCION:NombreAmigable:='funcion';
		FIN:NombreAmigable:='fin';
		HASTA:NombreAmigable:='hasta';
		PESOS:NombreAmigable:='fin de archivo';
		ERRORLEXICO:NombreAmigable:='simbolo no valido';
		Else NombreAmigable:=NOMBREVARIABLEOTERMINAL[T];
	End;
End;

//Imprime una linea fuente y, debajo, un cursor que senala la columna del error
Procedure ImprimirContexto(Var Fuente:TFuente;Linea:LongInt;Columna:LongInt);
Var
	texto:String;
	i:LongInt;
Begin
	texto:=LeerLinea(Fuente,Linea);
	Writeln('  ',Linea,' | ',texto);
	Write('  ',Linea,' | ');
	If Columna>1 Then For i:=1 To Columna-1 Do Write(' ');
	Writeln('^');
End;

//Muestra un error sintactico con linea, columna, lo esperado, lo encontrado y el contexto
Procedure ErrorSintactico(Var Fuente:TFuente;Posicion:LongInt;Esperado:VARIABLESYTERMINALES;Encontrado:VARIABLESYTERMINALES;Lexema:String);
Var
	linea,columna:LongInt;
	encontradoTxt:String;
Begin
	columna:=CalcularColumna(Fuente,Posicion,linea);
	If Lexema<>'' Then
		encontradoTxt:=''''+Lexema+''''
	Else
		encontradoTxt:=NombreAmigable(Encontrado);
	Writeln;
	Writeln('Error sintactico (linea ',linea,', columna ',columna,'):');
	Writeln('  se esperaba: ',NombreAmigable(Esperado));
	Writeln('  se encontro: ',encontradoTxt);
	Writeln;
	ImprimirContexto(Fuente,linea,columna);
	Writeln;
End;

//Muestra un error de simbolo inesperado (cuando la TAS no define la combinacion variable+terminal)
Procedure ErrorInesperado(Var Fuente:TFuente;Posicion:LongInt;Encontrado:VARIABLESYTERMINALES;Lexema:String;Contexto:String);
Var
	linea,columna:LongInt;
	encontradoTxt:String;
Begin
	columna:=CalcularColumna(Fuente,Posicion,linea);
	If Lexema<>'' Then
		encontradoTxt:=''''+Lexema+''''
	Else
		encontradoTxt:=NombreAmigable(Encontrado);
	Writeln;
	Writeln('Error sintactico (linea ',linea,', columna ',columna,'):');
	Writeln('  simbolo inesperado: ',encontradoTxt);
	If Contexto<>'' Then Writeln('  mientras se parseaba: ',Contexto);
	Writeln;
	ImprimirContexto(Fuente,linea,columna);
	Writeln;
End;

//Muestra un error lexico con linea, columna, el simbolo invalido y el contexto
Procedure ReportarErrorLexico(Var Fuente:TFuente;Posicion:LongInt);
Var
	linea,columna:LongInt;
	ch:Char;
	simboloTxt:String;
Begin
	columna:=CalcularColumna(Fuente,Posicion,linea);
	Seek(Fuente,Posicion);
	ch:=#0;
	If Not Eof(Fuente) Then Read(Fuente,ch);
	If (ch<=#32) Or (ch=#127) Then
		simboloTxt:='codigo '+IntToStr(Ord(ch))
	Else
		simboloTxt:=''''+ch+'''';
	Writeln;
	Writeln('Error lexico (linea ',linea,', columna ',columna,'):');
	Writeln('  simbolo no valido: ',simboloTxt);
	Writeln;
	ImprimirContexto(Fuente,linea,columna);
	Writeln;
End;

begin
end.
