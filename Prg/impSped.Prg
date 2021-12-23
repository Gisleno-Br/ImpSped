#require "rddsql"
#require "sddmy"

#include <hmg.ch>
#include "hbthread.ch"



#include <hbdyn.ch>



#include "dbinfo.ch"
#include "error.ch"
// #include "simpleio.ch"



// #include "hmg.ch"


#require "hbxpp"


#define QUEBRA Chr(13)+Chr(10)



Static cArq1
Static cFname

Static aThread  := Nil
Static aThread2 := Nil
Static aThread3 := Nil
Static aThread4 := Nil
Static aThread5 := Nil
Static aThread6 := Nil

Static aThread7 := Nil
Static aThread8 := Nil

Static aThread9 := Nil

Static aThread10 := Nil
Static aThread11 := Nil

Static aThread12 := Nil
Static aThread13 := Nil

Static aThread14 := Nil
Static aThread15 := Nil

Static oServer170

Static oServer120

Static oServer200
Static oServer190

Static nSeqNt := 0



Static aThread16 := Nil

Static lAborted := .f.

Static lOkDb    := .t.

Static cSqlIns150
Static cSqlIns200

Static cSqlInsC100
Static cSqlInsC170

Static cSqlInsC190

Static cSqlInsEMP

Static cRazaoEmp := ''



Static lTermino := .f.

Static nLinha := 0

STATIC nIdCliente := 0
STATIC nseqProd   := 0

STATIC nIdSeq1 := 0

Static aMSped := {}

Static nQErros := 0

Static aM150 := {}
Static aM200 := {}

Static aMC100 := {}
Static aMC170 := {}

Static aMC190 := {}

Static aMy1 := {}
Static aMy2 := {}
Static aMy3 := {}
Static aMy4 := {}
Static aMy5 := {}
Static aMy6 := {}

Static aChaves := {}


Static aMz1 := {}
Static aMz2 := {}
Static aMz3 := {}
Static aMz4 := {}
Static aMz5 := {}
Static aMz6 := {}


Static cTermino := ''


Static oServer2

Static nSe1



/*
#define DBI_QUERY             1001
#define RDDI_CONNECT          1001
#define RDDI_DISCONNECT       1002
#define RDDI_EXECUTE          1003
#define RDDI_ERROR            1004
#define RDDI_ERRORNO          1005
#define RDDI_NEWID            1006
#define RDDI_AFFECTEDROWS     1007
#define RDDI_QUERY            1008
*/


REQUEST HB_LANG_PT
REQUEST HB_CODEPAGE_PT850


REQUEST SDDMY, SQLMIX

ANNOUNCE RDDSYS


Function ImpSped()

	Local oFile
	Local cNota
	Local cSerie
	Local cCodParti
	Local aMp

	Local lRet := .t.



	Local cArq1 := xGetArq()



	HB_SetCodePage( "PT850" )


	rddSetDefault( "SQLMIX" )
	RDDSETDEFAULT( "SQLMIX" )

	//Public oServer190


 /*
	oServer170 := GetConexao()
	oServer150 := GetConexao()
	oServer120 := GetConexao()

	oServer200 := GetConexao()
	oServer190 := GetConexao()

	*/






	nConnection := RDDINFO( RDDI_CONNECT, { "MYSQL", cServer, cUserDb, cPassDb, "impSped" } )


	IF nConnection = 0
		hb_alert( "Unable connect to the server!" + Chr( 13 ) + Chr( 10 ) + Str( RDDINFO( RDDI_ERRORNO ) ) + Chr( 13 ) + Chr( 10 ) + RDDINFO( RDDI_ERROR ) )
		Return nConnectionInfo := 1 // 0 in nLogin means Mediator is sucessfully logged
	ENDIF



	GetFormNameByHandle ( GetActiveWindow(), @cFname )

	nGauge := 0

	nSeqNt := 0

	nIdCliente := 0
	nseqProd   := 0

	nIdSeq1 := 0

	oServer  := GetConexao()
	oServer2 := GetConexao()




	IF !hb_mtvm()
		MSGSTOP( "There is no support for multi-threading" )
		QUIT
	ENDIF


	If !Empty( Alltrim( cArq1 ) )

		oFile := TFileRead():New( cArq1 )
		oFile:Open()

		oFile:MoreToRead()


		cLine := oFile:ReadLine()

		aMCabec := StrToArray( "|", Alltrim( cLine )  )

		If ( Val( aMCabec[ 2 ] ) < 13 )
			yAviso( ( 'Somente Arquivos SPED com versão do Layout da 13 em Diante poderão ser Importados.' ) + QUEBRA + ;
				'Favor providenciar uma versão do arquivo com Layout mais Recente.' )
			oFile:Close()
			Return
		End If

		oFile:Close()

		cSqlIns150 := cSqlz1(  'participantes' )
		cSqlIns200 := cSqlz1(  'produtos' )

		cSqlInsC100 := cSqlz1(  'notasfiscais' )
		cSqlInsC170 := cSqlz1(  'itemnf' )


		cSqlInsC190 := cSqlz1(  'resumonfe' )

		cSqlInsEMP := cSqlz1(  'empresas' )

		aMSped := {}

		yEfect( cFName  )


	Do Events


	xWaitMsg( "Aguarde Preparando Estrutura...", {|| lRet := xPMatriz( cArq1 ) } )




	cMs1 := "Qt Reg 1 " + StrTran( Alltrim( Transform(Len( aMz1 ),"999,999,999,999"   ) ), ',', '.' )   + QUEBRA
	cmS1 += "Qt Reg 2 " + Alltrim( Transform( Len( aMz2 ),"999,999,999,999"   )   ) + QUEBRA
	cmS1 += "Qt Reg 3 " + Alltrim( Transform( Len( aMz3 ),"999,999,999,999"   )   ) + QUEBRA
	cmS1 += "Qt Reg 4 " + Alltrim( Transform( Len( aMz4 ),"999,999,999,999"   )   ) + QUEBRA
	cmS1 += "Qt Reg Total " + Alltrim( Transform( Len( aMC100 ),"999,999,999,999"   )   ) + QUEBRA


	If ( Len( aM150 ) + Len( aM200 ) == 0 )
		MsgInfo( hb_AnsitoOem( 'Registros não localizado (M150,M200)!' ), .f. )
		Return
	End If


	If Len( aMC170 ) == 0
		msginfo( hb_AnsitoOem( 'Registros não localizado (M170)!' ), .f. )
		Return
	End If

	If Len( aMC190 ) == 0
		msginfo( hb_AnsitoOem( 'Registros não localizado (M190)!' ), .f. )
		Return
	End If


	If ( Len( aMC100 ) == 0 )
		msginfo( hb_AnsitoOem( 'Registros não localizado (MC100 + MC170)!' ), .f. )
		Return
	End If

	
	If ( Len( aMz1 ) == 0 ) 
		msginfo( hb_AnsitoOem( 'Registros não localizado (Z1 MC100 + MC170)!' ), .f. )
		Return
	else

	//	 msginfo( aMz2[1] )	

	End If



	


	cTermino := ''



	aThread  := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @DoSped() )


	aThread2 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aM150, 'Reg 150',    .f.    )
	aThread3 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aM200, 'Reg 200',    .f.    )

	// aThread  := hb_threadStart(  HB_THREAD_INHERIT_PUBLIC, @xRode(), cArqT1, cArqCSV )


	//aThread4 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMC100, 'Reg C100', .t.     )

	aThread5 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMC170, 'Reg C170', .t.    )


	aThread6 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMy1, 'Reg C190-1', .t.    )
	aThread7 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMy2, 'Reg C190-2', .t.    )
	aThread8 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMy3, 'Reg C190-3', .t.    )
	aThread9 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMy4, 'Reg C190-4', .t.    )

	aThread13 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMy5, 'Reg C190-5', .t.    )
	aThread14 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMy6, 'Reg C190-6', .t.    )


	aThread4  := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMz1, 'Reg C100-1', .t.       )
	aThread10 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMz2, 'Reg C100-2', .t.     )
	aThread11 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMz3, 'Reg C100-3', .t.     )
	aThread12 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMz4, 'Reg C100-4', .t.     )


	aThread15 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMz5, 'Reg C100-5', .t.     )
	aThread16 := hb_threadStart( HB_THREAD_INHERIT_PUBLIC, @ProcArq(),  aMz6, 'Reg C100-6', .t.    )





	lTermino := .f.
	lSAida   := .f.


End If

REturn



Function xPMatriz( cArqx )

	Local oFile
	Local nPasso
	Local cNota
	Local n
	Local cSerie
	Local cCodParti
	Local nCont1

	Local aMCabec

	oFile := TFileRead():New( cArqx )
	oFile:Open()

	nQErros := 0

	nIdSeq1 := 0

	aM150 := {}
	aM200 := {}

	aMC100 := {}
	aMC170 := {}

	aMC190 := {}

	cNota     := ''
	cSerie    := ''
	cCodParti := ''

	nCont1 := 0


	HB_SetCodePage("PT850")


	While oFile:MoreToRead()


		cLine := oFile:ReadLine()

		If Left( cLine, 6 ) = '|0150|'
			Aadd( aM150, Hb_Utf8ToStr( NoAcento(cLine)   ) )
		End If		


		If Left( cLine, 6 ) = '|0200|'
			Aadd( aM200, Hb_Utf8ToStr(cLine) )
		End If

		If Left( cLine, 6 ) = '|0100|'
			Aadd( aM150, Hb_Utf8ToStr(cLine) )
		End If


		If Left( cLine, 6 ) = '|C100|'

			aMP := StrToArray( "|", Alltrim( cLine )  )

			cNota     := ''
			cSerie    := ''
			cCodParti := ''			


			If ( Val( aMp[ 12 ] ) > 0 )

				cNota     := aMp[ 8 ]
				cSerie    := aMp[ 7 ]
				cCodParti := aMp[ 4 ]

				Aadd( aMC100, cLine )

			End If

		End If


		If ( Left( cLine, 6 ) = '|C170|' ) .And. ( !Empty(  Alltrim(cNota )  ) )
			Aadd( aMC170,  { cNota, cSerie, cCodParti,   hb_UTF8TOSTR(cLine) }  )

		End If

		If ( Left( cLine, 6 ) = '|C190|' ) .And. ( !Empty(  Alltrim(cNota )  ) )

			nCont1++
			Aadd( aMC190,  { cNota, cSerie, cCodParti, cLine, nCont1 }  )


		End If

		If Left( cLine, 6 ) = '|0000|'
			Aadd( aM150, cLine )
		End If

		If Left( cLine, 6 ) = '|0005|'
			Aadd( aM150, cLine )
		End If

	Do Events

Enddo


If lTermino
Return .f.
End If

n1 := 1

nPasso := 1

aMy1 := {}
aMy2 := {}
aMy3 := {}
aMy4 := {}

aMy5 := {}
aMy6 := {}

// Divide a Matriz principal em Seis menores para acelerar o processamento nos Threads.

While ( n1 <= nCont1 )

	If nPasso = 1
		Aadd( aMy1, aMC190[ n1 ] )
	End If

	If nPasso = 2
		Aadd( aMy2, aMC190[ n1 ] )
	End If

	If nPasso = 3
		Aadd( aMy3, aMC190[ n1 ] )
	End If

	If nPasso = 4
		Aadd( aMy4, aMC190[ n1 ] )
	End If

	If nPasso = 5
		Aadd( aMy5, aMC190[ n1 ] )
	End If

	If nPasso = 6
		Aadd( aMy6, aMC190[ n1 ] )
		nPasso := 0
	End If

	nPasso++
	n1++

Do Events

Enddo


aMz1 := {}
aMz2 := {}
aMz3 := {}
aMz4 := {}

aMz5 := {}
aMz6 := {}

// Divide a Matriz principal em Quatro menores para acelerar o processamento nos Threads.

n := 1
nPasso := 1


While n <= Len( aMC100 )

	If nPasso = 1
		Aadd( aMz1, aMC100[ n ] )
	End If

	If nPasso = 2
		Aadd( aMz2, aMC100[ n ] )
	End If

	If nPasso = 3
		Aadd( aMz3, aMC100[ n ] )
	End If

	If nPasso = 4
		Aadd( aMz4, aMC100[ n ] )
	End If

	If nPasso = 5
		Aadd( aMz5, aMC100[ n ] )
	End If

	If nPasso = 6
		Aadd( aMz6, aMC100[ n ] )
		nPasso := 0
	End If

	nPasso++
	n++

Do Events

Enddo

oFile:Close()



//msginfo( Str( Len( aMC100 ) )  )



_ReleaseWindow( 'fWaitMsg' )

Return .t.

Function DoSped()

// yRun( 'Importação SPED ..'  ,  { || ProcArq(cArq1)  }  , .t. , cFname )
// cMensagem := 'Importação SPED ..'
// yaviso( 'Essa Rotina ira Importar as Informações contidas no Arquivo SPED.' , .f. )

	nSe1 := Seconds()

	yRun( 'Importar Arquivo SPED ..',  {|| xProgress()  }, .t., cFname )

REturn


Function xStop1()

	lTermino := .t.
	lAborted := .t.
	Do Events
	Do Events


// hb_threadDetach( aThread )   // close thread handle
// hb_threadQuitRequest( aThread )


// Msginfo('Processo Cancelado!')

Return


Function xProgress()

	// Local cFName
	nGauge := 0

	// nQErros := 0


	SetProperty( "fProgress", "lblMsg", "Value",  Hb_AnsitoOem(   "Aguarde ... Empresa " +  Alltrim(cRazaoEmp )  )     )

	lAviso  := .f.
	lAviso2 := .f.


	While !lTermino


		nGauge += 1

		SetProperty( 'fProgress', 'Progress1', 'Value', nGauge )

		If nGauge >= 30
			nGauge := 0
			SetProperty( 'fProgress', 'Progress1', 'Value', nGauge )
		End If

		If nQerros > 0
			SetProperty( "fProgress" , "LblErro1" , "Value" , Alltrim(Str(   nQErros ) ) + ' Erros Encontrados! ' )
		End If




	Do Events

	hb_idleSleep( .1  )



	If !lOkDb
		If !lAviso
			SetProperty( 'fProgress', 'LblMsg', 'Value', ' Tentando Conectar ao Banco de Dados.. ' )
			lAviso := .t.
		End If
	Else

		If ( ( lAviso ) .And. ( !lAviso2 ) )
			SetProperty( 'fProgress', 'LblMsg', 'Value', ' Lendo Linhas Arquivo e Gravando.. ' )
			lAviso2 := .t.
		End If

	End If

Enddo



SetProperty( 'fProgress', 'LblMsg', 'Value', ' Processo Finalizado! .. ' )

hb_threadDetach( aThread2 )   // close thread handle
hb_threadQuitRequest( aThread2 )   //

hb_threadDetach( aThread3 )   // close thread handle
hb_threadQuitRequest( aThread3 )   //

hb_threadDetach( aThread4 )   // close thread handle
hb_threadQuitRequest( aThread4 )   //

hb_threadDetach( aThread5 )   // close thread handle
hb_threadQuitRequest( aThread5 )   //

hb_threadDetach( aThread6 )   // close thread handle
hb_threadQuitRequest( aThread6 )   //

hb_threadDetach( aThread7 )   // close thread handle
hb_threadQuitRequest( aThread7 )   //

hb_threadDetach( aThread8 )   // close thread handle
hb_threadQuitRequest( aThread8 )   //

hb_threadDetach( aThread9 )   // close thread handle
hb_threadQuitRequest( aThread9 )   //

hb_threadDetach( aThread10 )   // close thread handle
hb_threadQuitRequest( aThread10 )   //

hb_threadDetach( aThread11 )   // close thread handle
hb_threadQuitRequest( aThread11 )   //

hb_threadDetach( aThread12 )   // close thread handle
hb_threadQuitRequest( aThread12 )   //

hb_threadDetach( aThread13 )   // close thread handle
hb_threadQuitRequest( aThread13 )   //


hb_threadDetach( aThread14 )   // close thread handle
hb_threadQuitRequest( aThread14 )   //

hb_threadDetach( aThread15 )   // close thread handle
hb_threadQuitRequest( aThread15 )   //


hb_threadDetach( aThread16 )   // close thread handle
hb_threadQuitRequest( aThread16 )   //




// SysWait(.2)

// DoMethod('fProgress','Release')

_ReleaseWindow( 'fProgress' )

If lAborted
	yAviso( 'Processo de Importação Interrompido pelo Usuario.', .f. )
Else
	yaviso( 'Processo Completo ! ' + QUEBRA + "Tempo Decorrido : " + timeAsString( Seconds() - nSe1  )   + ;
		Iif(nQErros > 0 , QUEBRA + 'Alguns Erros Ocorreram no Processamento(SqlError.txt)'  , '' )    , .f. )
End If


nQErros := 0


//

DoMethod( 'Main', 'Refresh' )
DoMethod( 'Main', 'Show' )

EfectEnd( cFname )

DoMethod( 'Main', 'SetFocus' )


Flag_AlphaBlend_Effect := .f.

BT_ClientAreaInvalidateAll ( 'Main' )


DoMethod( 'Main', 'Show' )

// CursorArrow(   GetFormHandle( 'Main'  )       )

Return


FUNCTION TimeAsString( nSeconds )
RETURN StrZero( INT( Mod(nSeconds / 3600, 24 ) ), 2, 0 ) + ":" + ;
		StrZero( INT( Mod(nSeconds / 60, 60 ) ), 2, 0 ) + ":" + ;
		StrZero( INT( Mod(nSeconds, 60 ) ), 2, 0 )


Function ProcArq(  aMtr1, cStr1, lProgress    )

// Local cArq := xGetArq()
	LOCAL cLine := ''
	Local n1
	Local nI
// msginfo(cArq)

	Local aMCabec := {}
	local am1 := {}
	Local am2 := {}

// Local aMtr1


	Local nq1 := 0
	Local nq2 := 0
	Local nq3 := 0
	Local nValor1 := 0
	Local nq4 := 0
	Local nq5 := 0
	Local lUmaVez := .f.
	Local nq6 := 0
	Local cChave1 := ''

	//Local nSeqProd := 0

	//Local nIdCliente := 0

	Local cNota := ''
	Local cSerie := ''
	Local cCodParti := ''

	Local nSeca := Seconds()

	Local oQuery

// Local oSrv2

// Local oSrv2

	Local nItem1 := 0

	Local oSrv2 := GetConexao()

	//DEFAULT oSrv := Nil 

	
	//Local aChaves := {}


	//oSrv2 := GetConexao()	


	SET DATE BRIT

	SET(_SET_DATEFORMAT,"DD/MM/YYYY")

	SET NAVIGATION EXTENDED

	HB_LANGSELECT( 'PT' )

	HB_SetCodePage("PT850")

	//Local oSrv3 := GetConexao()


	oSrv2:Query( 'SET GLOBAL connect_timeout=28800' )
	oSrv2:Query( 'SET GLOBAL wait_timeout=28800' )
	oSrv2:Query( 'SET GLOBAL interactive_timeout=28800' )



//	oSrv2:Query( 'SET global max_allowed_packet=104857600')

	//oSrv2:Query( 'SET autocommit=0')



//	oSrv2:Query( 'SET GLOBAL innodb_lock_wait_timeout = 25000')

    //oSrv2:Query( 'SET innodb_lock_wait_timeout = 25000' )	
//





	//rddSetDefault( "SQLMIX" )
	HB_SetCodePage( "PT850" )

	nIdEmp := 1

/*
 If Len(aMtr1) == 0
  msginfo( hb_OemToAnsi('Registros não Localizado! ')  + cStr1 )
  Return
 End If

 */

// msginfo( Str( Len(aMtr1) ))

// Return


	
	//saveLog('nota.txt' , cStr1 + '  z1  ' +  QUEBRA)


	nI := 1

	While ( nI <=  Len( aMtr1 ) ) .And. ( !lTermino )


		
		//saveLog('nota.txt' , cStr1 + '  z1  ' + aMtr1[ nI ] +  QUEBRA)


		If ( oSrv2 != Nil )

			lOkDb    := .t.


			If ( Alltrim( cStr1 ) != "Reg C170" ) .And. ( Alltrim( cStr1 ) != "Reg C190-1" ) .And. ( Alltrim( cStr1 ) != "Reg C190-2" ) .And. ;
					( Alltrim( cStr1 ) != "Reg C190-3" ) .And. ( Alltrim( cStr1 ) != "Reg C190-4" ) .And. ;
					( Alltrim( cStr1 ) != "Reg C190-5" ) .And. ( Alltrim( cStr1 ) != "Reg C190-6" )
				cLine    := Hb_AnsitoOem(aMtr1[ nI ])

			Else

				cNota     := aMtr1[ nI ][ 1 ]
				cSerie    := aMtr1[ nI ][ 2 ]
				cCodParti := aMtr1[ nI ][ 3 ]

				cLine     := Hb_ansiToOem(aMtr1[nI][4]	)


				If ( cChave1 != cNota + cSerie + cCodParti )
					nItem     := 0
					nItem1    := 0
					cChave1   := cNota + cSerie + cCodParti
				End If

			End If


			nLinha++

			cSqlx := ''
			lOkInsert := .f.

			If Left( cLine, 6 ) = '|0000|'

				aMCabec := StrToArray( "|", Alltrim( cLine )  )


			End If

			If Left( cLine, 6 ) = '|0005|'

				aM1 := StrToArray( "|", Alltrim( cLine )  )

			End If

			// Clientes / Fornecedores

			If Left( cLine, 6 ) = '|0150|'

				aMP := StrToArray( "|", Alltrim( cLine )  )

				nIdCliente++


				cSqlx := SqlInsert( cSqlIns150,   {  Alltrim( Str(nIdEmp ) ),  Alltrim( Str(nIdCliente ) ) , Hb_AnsiToOem(NoAcento((QuotedStr( aMp[ 3 ] )))), QuotedStr( aMp[ 5 ] ), QuotedStr( aMp[ 7 ] ), ;
				QuotedStr( aMp[ 6 ] ), QuotedStr( aMp[ 8 ] ), QuotedStr( fTiraChar( aMp[ 10 ] ) ), QuotedStr( NoAcento(fTiraChar( aMp[ 12 ] ) )), ;
				Hb_AnsiToOem(QuotedStr(NoAcento( fTiraChar(   aMp[ 13 ]  ))  )),  QuotedStr( aMp[ 2 ] )  } )


			End If



         *// Empresa
			If Left( cLine, 6 ) = '|0100|'

				aM2 := StrToArray( "|", Alltrim( cLine )  )


				cSqlx := SqlInsert( cSqlInsEMP, { Alltrim( Str(nIdEmp ) ),  QuotedStr( aMCabec[ 6 ] ), QuotedStr( aMCabec[ 7 ] ), QuotedStr( aMCabec[ 9 ] ), QuotedStr( aMCabec[ 10 ] ), ;
					QuotedStr( aMCabec[ 14 ] ), QuotedStr( aMCabec[ 15 ] ), QuotedStr( aM1[ 2 ] ),  QuotedStr( aM1[ 4 ] ), QuotedStr( aM1[ 5 ] ), QuotedStr( aM1[ 6 ] ), ;
					QuotedStr( aM1[ 7 ] ), QuotedStr( aM1[ 8 ] ), QuotedStr( aM1[ 10 ] ), QuotedStr( aM2[ 2 ] ), QuotedStr( aM2[ 3 ] ), QuotedStr( aM2[ 4 ] ) } )


				cRazaoEmp := Alltrim( aM1[ 2 ] )
		
			End If


			*// Produtos
			If Left( cLine, 6 ) = '|0200|'

				aMP := StrToArray( "|", Alltrim( cLine )  )

				nseqProd++


				cSqlx := SqlInsert(  cSqlIns200,    {  Alltrim( Str(nIdEmp ) ),   Alltrim( Str(nseqProd ) ) ,  QuotedStr( aMp[ 2 ] ), QuotedStr( Hb_ansiToOem(fTiraChar(aMp[ 3 ] )) ), QuotedStr( aMp[ 4 ] ), ;
					QuotedStr( aMp[ 6 ] ), QuotedStr( aMp[ 7 ] ), QuotedStr( aMp[ 8 ] ), ;
					QuotedStr( aMp[ 9 ] ), QuotedStr( aMp[ 10 ] ), QuotedStr( aMp[ 11 ] ), xFormat( aMp[ 12 ] ),  QuotedStr( aMp[ 13 ] )  } )



			End If

			*// Resumo NFE
			If ( Left( cLine, 6 ) = '|C190|' ) .And. ( !Empty( cNota ) )

				aMP := StrToArray( "|", Alltrim( cLine )  )

				nItem1++

				cSqlx := SqlInsert( cSqlInsC190,  {  Alltrim( Str(nIdEmp ) ), QuotedStr( cCodParti ), QuotedStr( cNota ), QuotedStr( cSerie ),  ;
					QuotedStr( aMp[ 2 ] ), QuotedStr( alltrim( aMp[ 3 ] ) ), Alltrim( xFormat( aMp[ 4 ] ) ), Alltrim( xFormat( aMp[ 5 ] ) ), Alltrim( xFormat( aMp[ 6 ] ) ), ;
					Alltrim( xFormat( aMp[ 7 ] ) ), Alltrim( xFormat( aMp[ 8 ] ) ), Alltrim( xFormat( aMp[ 9 ] ) ), Alltrim( xFormat( aMp[ 10 ] ) ), Alltrim( xFormat( aMp[ 11 ] ) ) } )


			End If

			If ( Left( cLine, 6 ) = '|C170|' ) .And. ( !Empty( cCodParti ) )

				aMP := StrToArray( "|", Alltrim( cLine )  )

				//lOkInsert := !CheckChv( 'itemnf', nIdEmp, 'CONCAT( codparti , numdoc , serie , coditem)', alltrim( QuotedStr( cCodParti + cNota + cSerie + aMp[ 3 ] ) )  )

				//nItem++

				nIdSeq1++

				//	If !lOkInsert

				cSqlx := SqlInsert( cSqlInsC170,  {  Alltrim( Str(nIdEmp ) ),   Alltrim( Str(  nIdSeq1   ) )  ,    QuotedStr( cCodParti ), QuotedStr( cNota ), QuotedStr( cSerie ),  ;
				QuotedStr( aMp[ 3 ] ), QuotedStr( NoAcento(fTiraChar( aMp[ 4 ] ) )), Alltrim( xFormat( aMp[ 5 ] ) ), ;
				QuotedStr( aMp[ 6 ] ), Alltrim( xFormat( aMp[ 7 ] ) ), Alltrim( xFormat( aMp[ 8 ] ) ), QuotedStr( Alltrim( aMp[ 10 ] ) ), QuotedStr( Alltrim( aMp[ 11 ] ) ), QuotedStr( Alltrim( aMp[ 12 ] ) ),  ;
				Alltrim( xFormat( aMp[ 13 ] ) ), Alltrim( xFormat( aMp[ 14 ] ) ), Alltrim( xFormat( aMp[ 15 ] ) ), Alltrim( xFormat( aMp[ 16 ] ) ), ;
				QuotedStr( Alltrim( aMp[ 17 ] ) ), Alltrim( xFormat( aMp[ 18 ] ) ), ;
				QuotedStr( Alltrim( aMp[ 20 ] ) ),   Alltrim( xFormat( aMp[ 22 ] ) ), Alltrim( xFormat( aMp[ 23 ] ) ), Alltrim( xFormat( aMp[ 24 ] ) ), ;
				QuotedStr( Alltrim( aMp[ 25 ] ) ), Alltrim( xFormat( aMp[ 26 ] ) ), Alltrim( xFormat( aMp[ 27 ] ) ), Alltrim( xFormat( aMp[ 30 ] ) ), ;
				QuotedStr( Alltrim( aMp[ 31 ] ) ), Alltrim( xFormat( aMp[ 32 ] ) ), Alltrim( xFormat( aMp[ 33 ] ) ), Alltrim( xFormat( aMp[ 36 ] ) ), ;
				Alltrim( xFormat( aMp[ 38 ] ) ) }  )

			End If



			*// Notas Entrada \Cabecalho
			If Left( cLine, 6 ) = '|C100|'

				aMP := StrToArray( "|", Alltrim( cLine )  )

				If ( Val( aMp[ 12 ] ) > 0 )

					//lOkInsert := !CheckChv( 'notasfiscais', nIdEmp, 'CONCAT( codparti ,  serie , numdoc , chave)', alltrim( QuotedStr( aMp[ 4 ] + aMp[ 7 ] + aMp[8] + Alltrim(aMp[ 9 ] )     ) )  )


					//nSeqNt := xGetMax(  oSrv )

					cAlias := "TMP"

					cSql := "Select Count(*) AS T1 From Notasfiscais"

					oQry13 := oSrv2:Query( cSql  )				

					
					oRow1 := oQry13:GetRow(1)

					nSeqNt := RandomN()
					//(oRow1:FieldGet(1)+1) 					

					oQry13 := Nil 


					//nSeqNt++
					If nSeqNt > 0 

						cSqlx := SqlInsert( cSqlInsC100,  {  Alltrim( Str(nIdEmp ) ),  Alltrim(Str(nSeqNt  ))  ,  QuotedStr( aMp[ 4 ] ), QuotedStr( aMp[ 5 ] ), QuotedStr( aMp[ 6 ] ), ;
						QuotedStr( aMp[ 7 ] ), QuotedStr( aMp[ 8 ] ), QuotedStr( fTiraChar( aMp[ 9 ] ) ), QuotedStr( ConvDt( aMp[ 10 ] ) ), ;
						QuotedStr( ConvDt( aMp[ 11 ] ) ),   Alltrim( xFormat( aMp[ 12 ] )  ),   alltrim ( QuotedStr( aMp[ 13 ] ) ), ;
						Alltrim( xFormat( aMp[ 14 ] ) ), Alltrim( QuotedStr( aMp[ 17 ] ) ), Alltrim( xFormat( aMp[ 18 ] ) ), Alltrim( xFormat( aMp[ 19 ] ) ), ;
						Alltrim( xFormat( aMp[ 20 ] ) ), Alltrim( xFormat( aMp[ 21 ] ) ), Alltrim( xFormat( aMp[ 22 ] ) ), Alltrim( xFormat( aMp[ 23 ] ) ), Alltrim( xFormat( aMp[ 24 ] ) ), ;
						Alltrim( xFormat( aMp[ 25 ] ) ), Alltrim( xFormat( aMp[ 26 ] ) ), Alltrim( xFormat( aMp[ 27 ] ) ), QuotedStr( alltrim( aMp[ 3 ] ) ), QuotedStr( alltrim( aMp[ 2 ] ) )  } )
						
					End If 	



					//End If					
					//hb_idlesleep(0.07)

					
   					//hb_threadWaitForAll()



					nItem     := 0
					nItem1    := 0

				Else

					cNota     := ''
					cSerie    := ''
					cCodParti := ''
					nItem     := 0
					nItem1    := 0

				End If

		End If




		If ( !Empty( cSqlx ) )

			oQuery := oSrv2:Query( cSqlx )

			IF oQuery:NetErr()
				Hb_MemoWrit( 'sqlError.txt', Hb_MemoRead( 'sqlError.txt' ) +  " Error : " + cStr1 + "  ] " + oQuery:Error() + QUEBRA + cSqlx + QUEBRA )
				nQErros++	
			End If
		
			oQuery:Destroy()
			oQuery := Nil


			SaveLog( 'LogImport.txt', time() + ' Seq C100 : ' + Alltrim(Str(   nSeqNt  )) + " Importando Linha Tipo "  + Left( cLine, 6 ) + " Linha Arquivo : " + Alltrim( Str(nI ) ) +  QUEBRA  )


			If Left( cLine, 6 ) = '|0100|'
				nQ1++
			End If

			If Left( cLine, 6 ) = '|0150|'
				nQ2++
			End If

			If Left( cLine, 6 ) = '|0200|'
				nQ3++
			End If

			If Left( cLine, 6 ) = '|C100|'
				nQ4++
			End If

			If Left( cLine, 6 ) = '|C170|'
				nQ5++
			End If

			If Left( cLine, 6 ) = '|C190|'
				nQ6++
			End If


		End If

// oSrv2:Destroy()
// oSrv2 := Nil

		nI++

// hb_memoWrit('Andamento1.txt', cStr1 + ' Linha : ' + Alltrim(Str(nI))  + QUEBRA )


	Else

		lOkDb    := .f.
		SaveLog( 'LogImport.txt', time() + ' Tentando Conexão com o Banco ..'  + QUEBRA )

	End If

// Do Events


Enddo



// hb_memoWrit('Andamento1.txt', cStr1 + ' Processo finalizdo! ' + time() + QUEBRA )

cTermino += Alltrim( cStr1 )

If ( At( 'Reg 150',cTermino ) > 0 ) .And. ;
		( At( 'Reg 200',cTermino ) > 0 ) .And. ;
		( At( 'Reg C170',cTermino ) > 0 ) .And. ;
		( At( 'Reg C100-1',cTermino ) > 0 ) .And. ;
		( At( 'Reg C100-2',cTermino ) > 0 ) .And. ;
		( At( 'Reg C100-3',cTermino ) > 0 ) .And. ;
		( At( 'Reg C100-4',cTermino ) > 0 ) .And. ;
		( At( 'Reg C190-1',cTermino ) > 0 ) .And. ;
		( At( 'Reg C190-2',cTermino ) > 0 ) .And. ;
		( At( 'Reg C190-3',cTermino ) > 0 ) .And. ;
		( At( 'Reg C190-4',cTermino ) > 0 ) .And. ;
		( At( 'Reg C190-5',cTermino ) > 0 ) .And. ;
		( At( 'Reg C190-6',cTermino ) > 0 ) .And. ;
		( At( 'Reg C100-5',cTermino ) > 0 ) .And. ;
		( At( 'Reg C100-6',cTermino ) > 0 )

	hb_memoWrit( 'Andamento21.txt', cTermino + QUEBRA )

	lTermino := .t.

End If


cMsg := ''


If ( nQ6 > 0 )

// If nQ6 > 0
// cMsg += "Qtde. Resumo NF Incluidos (C190): " + Alltrim(Str(  nQ6 )) + QUEBRA
// End If

// lTermino := .t.

    /*
  If nQ2 > 0
   cMsg += "Qtde. Participantes Incluidos (0150): " + Alltrim(Str(  nQ2 )) + QUEBRA
  End If

  If nQ3 > 0
   cMsg += "Qtde. Produtos Incluidos (0200): " + Alltrim(Str(  nQ3 )) + QUEBRA
  End If

  If nQ1 > 0
   cMsg += "Qtde. Empresas Incluidos (0100): " + Alltrim(Str(  nQ1 )) + QUEBRA
  End If

  If nQ4 > 0
   cMsg += "Qtde. Notas Fiscais (C100): " + Alltrim(Str(  nQ4 )) + QUEBRA
  End If

  If nQ5 > 0
   cMsg += "Qtde. Itens NF Incluidos (C170): " + Alltrim(Str(  nQ5 )) + QUEBRA
  End If

  If nQ6 > 0
   cMsg += "Qtde. Resumo NF Incluidos (C190): " + Alltrim(Str(  nQ6 )) + QUEBRA
  End If
  */

// msginfo( Hb_ansiToOem("Processo de Importação Concluido!") +  QUEBRA +   cMsg )

Else
// msginfo( Hb_ansiToOem("Processo de Importação Concluido!") )
End If

SaveLog( 'LogFin1.txt', Dtoc( date() ) + ' ' + time() + ' Concluido !  Importação ' + cStr1 + ' Tempo : ' + timeAsString( Seconds() - nSeca ) + QUEBRA )

oSrv2:Destroy()
oSrv2 := Nil


Do Events
// Do Events

Return

/*/{PrxGetMax()



REturn 
	(long_description)
	@type  Function
	@author user
	@since 23/12/2021
	@version version
	@param param_name, param_type, param_descr
	@return return_var, return_type, return_description
	@example
	(examples)
	@see (links_or_references)
	/*/
Function xGetMax(  oSrsv1 )
  
//	Local oSrvx1 := GetConexao()

	Local cSql := "Select Count(*) AS T1 From Notasfiscais"
	Local nQt1 := 0
	Local oQry 
	Local oRow1 

	Local cAlias := 'TMP'


/*
	oQry := oSrsv1:Query(cSql)
	//SaveLog('sqlcheck.txt'  , cSql + QUEBRA)
	//SaveLo


	If oSrsv1:NetErr()

		MsgInfo( "Error ao Executar a Consulta COUNT : " + cSql + " : " + QUEBRA + oSrsv1:Error()  )

		hb_memoWrit('sqlcheck.txt'  , cSql )		
		oQry := Nil
		Return 0

	End If


	oRow1 := oQry:GetRow(1)

	nQt1 := oRow1:FieldGet(1)

	//oSrvx1:Destroy()
	//oSrvx1:=Nil 


	oQry := NIL
	*/

	dbUseArea( .T.,,  cSql, cAlias )
	dbSelectArea( cAlias )
	dbGoTop()

	hb_memoWrit('sqlcheck.txt'  , cSql )

	nQt1 := T1

	dbSelectArea( cAlias )
	Use  


REturn nQt1 
	
Return return_var


Function xFormat( nPar1 )

	Local cVal := Alltrim( Transform( Val(nPar1 ), "99999,99" ) )

	cVal := QuotedStr( StrTran( nPar1,',','.' )   )


	If Empty( nPar1 )
		cVal := QuotedStr( '0' )
	End If

Return cVal


// |0150|SA101019L1T4301|LUCAS FELIPE DA SILVA|1058||11464979464||2704302||RUA JURACI PEREIRA QD-9 N|41|CONJ SANTA MARIA   88244190|CIDADE UNIVERSITARIA|

Function StrToArray( cLetra, cChar )

	Local aMtr := {}
	Local i    := 1
	Local nCol := 1

	Local cc2 := ''

	While i <= Len( cChar )

		If ( Substr( cChar,i,1 ) = cLetra )

			If ( i > 1 )

				If ( Substr( cChar,i - 1,1 ) = cLetra )
					cC2 := 'Vazio'
				End If

				if !Empty( cC2 )
					Aadd( aMtr, Iif( cC2 = 'Vazio','', Hb_AnsitoOem(  cC2   )     )  )
					nCol++
				End If

			End If

			cC2 := ''

		Else
			cC2 += Substr( cChar, i, 1 )
		End If


		i++

	Enddo

// msginfo(Str(len(aMtr)) )

Return aMtr







Function xGetArq()

	Local cFile := Getfile ( { { 'SPed','*.Txt' } }, 'Open File', '', .f., .t. )

Return cFile




Function CheckChv(  cTabela, nIdEmp , cCampo ,  nId1 )

	Local lRet := .f.
	Local cAlias := 'TMP'
	Local oQry
	Local oRow1

	Local oSrvx1 := GetConexao()


	Local cSql := "Select Count(*) as N1 from " + cTabela  + " where idEmpresa = " + Alltrim(Str(nIdEmp)) + " and " + cCampo + " = " + ;
	Alltrim(Str(  nId1 ))


	//oQry := oSrvx1:Query(cSql)

	oQry := oSrvx1:Query(cSql)

   
	SaveLog('sqlcheck.txt'  , cSql + QUEBRA)


	//SaveLo


	If oSrvx1:NetErr()

		MsgInfo( "Error ao Executar a Consulta : " + cSql + " : " + QUEBRA + oSrvx1:Error()  )

		hb_memoWrit('sqlcheck.txt'  , cSql )

		//oQry:Destroy()
		oQry := Nil



		Return ''


	End If


	oRow1 := oQry:GetRow(1)
	lRet := (oRow1:FieldGet(1) > 0)

	oSrvx1:Destroy()
	oSrvx1:=Nil 


	oQry := NIL


REturn lRet





Function cSqlz1(  cTabela )

	Local cSql := "select * from " + alltrim( cTabela )
	Local cAlias := 'Tmp'
	Local cSql2
	Local cValues := ''

// Local nId     := GetReg(cTabela)+1
	Local cSql1

// Default aCamposF := {}

	dbUseArea( .T.,,  cSql, cAlias )
	dbSelectArea( cAlias )
	dbGoTop()

	cSql2 := 'insert into ' + cTabela + '('

	For n1 := 1 To FCount()
		cSql2 += ( Alltrim( Fieldname(n1 ) )  + ',' ) + QUEBRA
	Next

// - 1
	cSql1 := Left( cSql2, Len( cSql2 ) - 3 ) 
	

	dbSelectArea( cAlias )
	Use

REturn cSql1




Function SqlInsert( cSql1, aValores, aCamposF )

	Local cAlias := 'Tmp'
	Local cSql2
	Local cValues := ''
	Local cSqlx1 := ''

	cValues := ''

	For n1 := 1 to Len(   aValores )
		cValues += Hb_AnsiToOem(aValores[ n1 ]) + "," + QUEBRA
	Next

	cSqlx1 := cSql1 + ") Values (" + Left( cValues, Len( cValues ) - 3 ) + ")"

REturn cSqlx1

Static FUNCTION GetReg( cTabela, cCampoId )

	LOCAL oServ := GetConexao()
	LOCAL oQuery := oServ:Query( 'select count(*) as t1 from ' + cTabela )
	LOCAL nQreg  := 0

	Default cCampoid := ''

	If !Empty( cCampoid )
		oQuery := oServ:Query( "select max(" + cCampoid + ") as t1 from " + cTabela )
	End If

	IF oQuery:LastRec() > 0

		oR1 := oQuery:GetRow( 1 )
		nQreg := oR1:FieldGet( 1 )

	END IF

	oServ:Destroy()
	oServ := Nil

	oQuery:Destroy()
	oQuery := Nil

RETURN nQreg



Static Function QuotedStr( cVar )
Return Chr( 39 ) + cVar + Chr( 39 )

Static FUNCTION ConvDt( dDt1 )

	LOCAL d1 := Right(  dDt1, 4 ) + '-' + SubStr(  dDt1, 3, 2 ) + "-" + Left(  dDt1, 2 )

RETURN d1





Static FUNCTION fTiraChar( wCampo )

// // Remover Caracteres Especiais (/,*)

	LOCAL lRet  := .T.
	LOCAL cStr1 := ''
	LOCAL i     := 1


	FOR i := 1 TO Len( wCampo )
		IF SubStr( wCampo, i, 1 ) == "'" .OR. SubStr( wCampo, i, 1 ) == ")" .OR. SubStr( wCampo, i, 1 ) == "(" .OR. SubStr( wCampo, i, 1 ) == "*" .OR. SubStr( wCampo, i, 1 ) == "/"  .OR. SubStr( wCampo, i, 1 ) == "\"  .OR. SubStr( wCampo, i, 1 ) == '%' .OR. SubStr( wCampo, i, 1 ) == "-" ;
				.OR. SubStr( wCampo, i, 1 ) == "\" .or. SubStr( wCampo, i, 1 ) == "á"

		ELSE
			cStr1 += SubStr( wCampo, i, 1 )
		ENDIF
	NEXT i

RETURN cStr1

static FUNCTION NoAcento(cString)
	Local cChar  := ""
	Local nX     := 0
	Local nY     := 0
	Local cVogal := "aeiouAEIOU"  
	Local cAgudo := "áéíóú"+"ÁÉÍÓÚ"
	Local cCircu := "âêîôû"+"ÂÊÎÔÛ"
	Local cTrema := "äëïöü"+"ÄËÏÖÜ"
	Local cCrase := "àèìòù"+"ÀÈÌÒÙ"
	Local cTio   := "ãõÃÕ"
	Local cCecid := "çÇ"
	Local cMaior := "&lt;"   
	Local cMenor := "&gt;"
	Local c1 := "½"

	//¢
	//"á"


	For nX:= 1 To Len(cString)
		cChar:=SubStr(cString, nX, 1)
		IF cChar$cAgudo+cCircu+cTrema+cCecid+cTio+cCrase
			nY:= At(cChar,cAgudo)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))				
   				//SaveLog('acento.txt',cString + '  ' + SubStr(cVogal,nY,1) + QUEBRA)

			EndIf
			nY:= At(cChar,cCircu)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
			EndIf
			nY:= At(cChar,cTrema)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
			EndIf
			nY:= At(cChar,cCrase)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
			EndIf
			nY:= At(cChar,cTio)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr("aoAO",nY,1))
			EndIf
			nY:= At(cChar,cCecid)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr("cC",nY,1))
			EndIf
		Endif
	Next

	If cMaior$ cString
		cString := strTran( cString, cMaior, "" )
	EndIf
	If cMenor$ cString
		cString := strTran( cString, cMenor, "" )
	EndIf

	cString := StrTran( cString, CRLF, " " )

Return hb_AnsiToOem(cString)




FUNCTION RandomN()

   LOCAL cString

   //hb_default( @cPath, hb_DirTemp() )
   //hb_default( @cExt, "tmp" )

   RETURN Int( 2.5 * hb_Random( Val(  '323' + StrTran( Time(), ":" )   ) ) )

