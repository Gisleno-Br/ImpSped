#include <hmg.ch>

#define QUEBRA Chr(13)+Chr(10)
#define WM_HSCROLL          276

#define WS_BORDER           0x00800000
#define WM_SETREDRAW        0x0b
#define WM_SETFOCUS 7
#define NROWINI 52
#include "dbinfo.ch"
#include "error.ch"

#define WM_CLOSE            0x0010

#include "hmg.ch"

#define IDC_BTN_1   2001
#define IDC_BTN_2   2002
#define IDC_BTN_3   2003
#define IDC_BTN_4   2104
#define IDC_BTN_5   2005
// #define IDC_BTN_YES 201
// #define IDC_BTN_NO  1102

#define FONTCOR {0,106,133}
#define BACK1 {229,237,242}

#define CORSEL     {216,228,236}


#define DBI_QUERY             1001
#define RDDI_CONNECT          1001
#define RDDI_DISCONNECT       1002
#define RDDI_EXECUTE          1003
#define RDDI_ERROR            1004
#define RDDI_ERRORNO          1005
#define RDDI_NEWID            1006
#define RDDI_AFFECTEDROWS     1007
#define RDDI_QUERY            1008




REQUEST SQLMIX

Define Window Main

REQUEST HB_LANG_PT
REQUEST HB_CODEPAGE_PT850


FUNCTION CadCli( nHandle5 , aLbl)

	LOCAL wCad := 'clientes'
	Local aOp1 := {'Consultas','Relatorios','Parametros' }

	Local cControl
	Local cform


	Local aOp2 := { {'2-Geral' , { || msginfo('ok') } } ,   ;
	{'2-Geral1' , { || msginfo('ok1')} },;
	{'2-Geral2' , { || msginfo('ok3')} } ,;
	{'3-Geral4' , { || msginfo('ok4') } },;
	{'3-Geralzão' , { || msginfo('ok5') } } } 


	LOCAL aTam    := GetCamposInf( wCad, 'TAM' )
	LOCAL aCabec  := GetCamposInf( wCad, 'CABEC' )
	LOCAL aCampos := GetCamposDic( wCad, 'S', .T. )



	Private nItMax := 18
	Private nItx1  := nItMax

	Private lArrastou := .f.

	Private lDrag     := .f.
	Private nObjDrag  := 0

	private cButVerde := ".Filtrar."

	//Private nTotWidth := 0

	Private nRowIni2 := 10

	Private cTituloJan := ''  
	Private nQRegx     := 0

	Private lAumentou := .f.

	Private aMtrHeader := {}
	
	Private nEven1 := 0
	Private nEven2 := 0
	

	Private nPosAnt  := -1
	
	Private nInd2 := 0
	
	Private lAscendente := .t.

	Private lDragMode := .f.


	Private nSaveScr := 0

	Private nColIni := 0

	Private cLblConsu := ''

	Private nTotWidth := 0

	Private nObjSize := 0
	Private lmodeSize := .f.


	


	SET LANGUAGE TO PORTUGUESE   
	SET CODEPAGE TO PORTUGUESE

	HB_SetCodePage( "PT850" )
	hb_langSelect( "PT" )

	// MSGINFO(HB_LANGSELECT() )

	_HMG_SYSDATA[ 348 ] := { 199, 250, 225 }
	_HMG_SYSDATA[ 349 ] := { 007, 071, 041 }
	_HMG_SYSDATA[ 350 ] := { 235, 237, 095 }
	_HMG_SYSDATA[ 351 ] := { 069, 015, 135 }

	Private nHanOri := nHandle5
	Private aLblOri := aLbl   

	ManutDb( aCabec, aCampos,  GetSql( "clientes", .F. ), "Clien", aTam, "Cadastro de Clientes" ,"Clientes" , aOp1  , aOp2)      

RETURN


Function EnchMtrConsul(cTab1)


	LOCAL cSql := "select * from consultas where (tabela = '"  + cTab1 +  "') And ((idfilial = 0) or (idfilial = "  + AllTrim( Str( nIdEmp ) )  + ")) And (Status = 'Ativo') order by descricao"
	Local oServer := GetConexao()
	Local oQuery  := oServer:Query( cSql )
	Local oRow

	aConsultas := {}


	For n1 := 1 TO oQuery:LastRec()

		oRow := oQuery:GetRow(n1)       
		aadd(aConsultas , '1-' + alltrim(GetCampo(oRow , 'descricao')) )

	Next

	oQuery:Destroy()
	oQuery := Nil

	oServer:Destroy()
	oServer := Nil   

Return


FUNCTION ManutDb( aHeader, aCampos, cSql, cAlias, aTam1, cTitulo ,cTabelax , aOpx1 ,aOpx2 )


	Local cIndice1 := RetIndJan()

	Private cTitle := ''


	PRIVATE aHeaderDb := aHeader
	PRIVATE aCamposDb := aCampos
	
	Private lOpcaoAberta := .f.

	Private cTabela := cTabelax

	Private nScrolTam := 0

	Private cTituloCon := ''

	Private nScr1 := 0

	Private aOpz1 := aOpx1
	Private aOpz2 := aOpx2

	Private nQtElem := 0

	Private nHan2 := 0

	Private cTitFiltro := ''
	
	Private cConsuAtiva := ''
	Private cSqlConsulta := ''

	PRIVATE aDynBack := {}
	PRIVATE aForBack := {}

	PRIVATE cAli1     := cAlias


	Private nLinRow := 0

	Private nIdConsulta := 0

	Private cOpSel := ''
	PRIVATE aWidths := aTam1

	Private lScrOk := .f.

	Private nHanConsu := 0

	FOR n1 := 1 TO Len( aHeaderDb )
		AAdd( aDynBack, bColor )
		AAdd( aForBack, fColor )
	NEXT

	PRIVATE nTxColorE  := Rgb( 79, 79, 79 )
	PRIVATE nFrColorE  := Rgb( 207, 207, 207 )

	Private nPosScr := 0

	PRIVATE nBkColorE1 := Rgb( 251, 251, 251 )
	PRIVATE nBkColorE2 := Rgb( 230, 230, 230 )

	PRIVATE nGradDirE  := 0
	PRIVATE nTxColorD  := 0x808080

	PRIVATE nFrColorD  := Rgb( 232,232,232 )
	//{ 9, 111, 137 }

	PRIVATE nBkColorD1 := 0XE0E0E0
	PRIVATE nBkColorD2 := 0XE0E0E0
	PRIVATE nGradDirD  := 0
	PRIVATE nTxColorF  := Rgb( 45, 55, 56 )
	PRIVATE nFrColorF  := nFrColorE

	Private nTxColorG := Rgb( 64 , 128 , 128 )
	Private nBkColorG1 := Rgb( 64 , 128 , 128 )
	//Private nFrColorG


	PRIVATE nBkColorF1 :=  0xFFFFFF
	PRIVATE nBkColorF2 :=  Rgb( 192, 192, 192 )

	Private aMrow := {}

	PRIVATE nGradDirF  := 0
	PRIVATE cFontName  := 'Arial'
	PRIVATE nFontSize  := 9

	PRIVATE aBtnFont  := { cFontName , 8 , .F., .F., .F., .F. }


	Private aLbly1 := {}


	Private aConsultas := {}

	PRIVATE fColorGrid := {|| iif(  This.CellRowIndex = 1, {255,255,255}  , { 78,78,78 }     )}


	PRIVATE bColorGrid := {|| iif( This.CellRowIndex / 2 <> Int( This.CellRowIndex / 2 ), { 241,241,241 }, {255,255,255}  ) }



	PRIVATE aBtnColor := ;
	{ { nTxColorE, nFrColorE, nBkColorE1, nBkColorE2, nGradDirE }, { nTxColorD, nFrColorD, nBkColorD1, nBkColorD2, nGradDirD }, { nTxColorF, nFrColorF, nBkColorF1, nBkColorF2, 		 					nGradDirF } }

	PRIVATE aBtnSel := ;
	{ { nTxColorF, nFrColorF, nBkColorF1, nBkColorF2, nGradDirF }, { nTxColorD, nFrColorD, nBkColorD1, nBkColorD2, nGradDirD }, { nTxColorF, nFrColorF, nBkColorF1, nBkColorF2, 						nGradDirF } }

	PRIVATE aBtnG1 := ;
	{ { Rgb(255,255,255) , Rgb( 178 , 178 , 178 ) , Rgb( 58 , 174 , 203 ) , Rgb( 58 , 174 , 203 ), nGradDirE }, { Rgb( 178 , 178 , 178 ) , nFrColorD, Rgb( 178 , 178 , 178 ), nBkColorD2, nGradDirD }, { RGB(255,255,255) , nFrColorF, Rgb( 54 , 100 , 109 )  , Rgb( 54 , 100 , 109 )  , 		 					nGradDirF } }

	PRIVATE aBtnG2 := ;
	{ { Rgb(255,255,255) , {54,100,109} , Rgb( 44 , 169 , 139 ) , Rgb( 20 , 158 , 192 ), nGradDirE }, { {255,255,255}  , nFrColorD, nBkColorD1, nBkColorD2, nGradDirD }, { RGB(255,255,255) , Rgb( 54 , 100 , 109 ) , Rgb( 54 , 100 , 109 ) ,  Rgb( 54 , 100 , 109 )  , 		 					nGradDirF } }




	PRIVATE aButtons := {  { "Incluir", {|| fx1( "novo") }, .T., "Cadastra um novo cliente", 0 }, ;
	{ "Modificar", {|| fx1( "edit" ) }, .T., "Teste02", 0 }, ;
	{ "Excluir", {|| fx1( "excluir" ) }, .T., "Teste05", 0 } ,;
	{ "Filtrar", {|| ProcFiltro( cTabelax )    }, .T., "Filtra Registros", 0 } ,;
	{ Hb_AnsiToOem("Opções") , {|| xSetOpcao()  }, .T., Hb_AnsiToOem("Opções Diversas") , 0 } }



	rddSetDefault( "SQLMIX" )
	HB_SetCodePage( "PT850" )


	IF rddInfo( RDDI_CONNECT, { "MYSQL", cServer, cUserDb, cPassDb, cBanco } ) == 0
		MSGSTOP( "Unable connect to the server" )
		RETURN
	ENDIF

	//rddSetDefault( "SQLMIX" )

	Private fScrName := 'fScrx' + cAlias


	Private cBrowName := 'fBrow' + cAlias

	PRIVATE cAuxName := 'fCad2'

	// Private cAuxMenu :=

	cFormPrin := 'F' + cAlias

	cAuxName := 'FCad' + cAlias
	cForm := cAuxName

	PRIVATE cMenuName := 'fMenu' + cAlias


	If ascan(aOpx1, 'Consultas') > 0
		EnchMtrConsul( cTabelax )
	End If


	Load Window fClientes as &cFormPrin

	cActiveJan := cFormPrin

	cTitle := cTitulo

	SetProperty( cFormPrin , "Title" , cTitle)

	ON KEY ESCAPE OF &cFormPrin Action FechaJan('Img' + cIndice1 , , nEven1 , nEven2 ) 

	//ON KEY ESCAPE OF &cFormPrin Action FechaJan( ThisWindow.name )


	SetProperty( cFormPrin, "row", 60 )   
	SetProperty( cFormPrin, "col", 1 )


	SetProperty( cFormPrin, "Height", nDeskTopHeight - 140 )
	SetProperty( cFormPrin, "Width", nDeskTopWidth )

	//SetProperty( cForm, "LblTxt1", "Value", DToC( dDataBase ) +  '   ' +  AllTrim( Transform(RecCount(),'999,999,999' ) ) + ' Registros ' )

	RefreshCli()


	//CREATE EVENT PROCNAME Check_Grid_Events()	 

	Activate Window &cFormPrin
	Use

RETURN

Function xSetOpcao()

   Local n1
   Local cLabelx

   If (!lOpcaoAberta) 
   
      lOpcaoAberta := .t.
      InitTela(  .f.  ,  183 )      
      
      OBTN_Caption(cAuxName   , aButtons[5][5]  , hb_AnsiToOem("Sair Opções") )       
   
   Else
   
      For n1 := 1 To Len(aOpz1)

					cLabelx := Right(cFormPrin,3) + StrZero(n1,3)
					
					If _IsControlDefined( cLabelx, cFormPrin )
					   _ReleaseControl( cLabelx, cFormPrin )
					End If
							
			 Next				
   
      lOpcaoAberta := .f.
      InitTela(  .f.  ,  1 ) 
      
      OBTN_Caption(cAuxName   , aButtons[5][5]  ,hb_AnsiToOem("Opções")) 
      
   
   End If

Return


Function ProcFiltro( cTab1 )

	Local cFiltros := ''
	Local nHan1
	Local cTexto
	
	Local cCapt := Alltrim(OBTN_Caption(cAuxName   , aButtons[4][5] ))
	
	//msginfo(cLblSelected)
	
	If (lOpcaoAberta)
	   yAviso("Não é possivel Executar Filtros com a Tela de opções Ativa.")
	   Return	
	End If
	
	
	If (cCapt = "Limpar Filtro" )		    
		  OpenReg( ''  , ,   1 )
		  OBTN_Caption(cAuxName   , aButtons[4][5]  , "Filtrar" )
		  EventProcessAllHookMessage(nEven1 := (EventCreate({ || LabelEventBrow() }, GetControlHandle( 'br_grid' , cFormPrin )  ) )  , .T.)  
		  Return
  End If 


	lAtivaBlack := .t.
	CaptTelas()
	Flag_AlphaBlend_Effect := .T.
	Grayness_effect_start(  cFormPrin  )  
	ShowButTop( .f. ) 

	cFiltros := LoadFitros(cTab1 )

	Grayness_effect_end()
	Flag_AlphaBlend_Effect := .f.
	
	//ShowButTop( .t. )

	lativaBlack := .f.
	
	//PlaceJan(cLblSelected)
	
	cTexto := GetProperty('fSplit2' ,cLblSelected , 'Value')
	
	//msginfo(cTexto)
	
	

	If !Empty(cFiltros)
		
		nHan1 := aButtons[4][5]
		
		 OpenReg(cFiltros  , ,   1 )
		 OBTN_Caption(cAuxName   , nHan1  , "Limpar Filtro" )
		 EventProcessAllHookMessage(nEven1 := (EventCreate({ || LabelEventBrow() }, GetControlHandle( 'br_grid' , cFormPrin )  ) )  , .T.)  
		
	End If
	
	 ResButSel()
	
	/*
	_ReleaseControl('Image_5' , 'fSplit2' )
	_ReleaseControl('Img' + Right(cLblSelected ,4) , 'fSplit2' )
	
	
	PutImagem(nColSel , cTexto , Right(cLblSelected ,4) ) 
	
	SetProperty('fSplit2','Image_1','Visible', .t.)
	*/
	
	//_ReleaseControl('Image_5' , 'fSplit2' )
  //_ReleaseControl('Img' + Right(cLblSelected ,4) , 'fSplit2' )
  
  //DoMethod( 'fSplit2'  , 'Img' + Right(cLblSelected ,4)  , 'Show' ) 
  //DoMethod( 'fSplit2'  , 'Img' + Right(cLblSelected ,4)  , 'Refresh' ) 
  
  //DoMethod( 'fSplit2'  , 'Image_5' , 'Show' ) 
  //DoMethod( 'fSplit2'  , 'Image_5' , 'Refresh' ) 
  
  //DoMethod( 'fSplit2'  , 'Img' + Right(cLblSelected ,4)  , 'Refresh' ) 
	
  //sysWait(.2)
	
	//msginfo(Str(nColSel))

REturn

Function ResButSel()

  Local cTexto  
  Local lok := .f.
  
  If _isWindowDefined('fSplit2')  
     If _isControlDefined( cLblSelected , 'fSplit2')
		     cTexto := GetProperty('fSplit2' ,cLblSelected , 'Value')
		     
			  _ReleaseControl('Image_5' , 'fSplit2' )
				_ReleaseControl('Img' + Right(cLblSelected ,4) , 'fSplit2' )	
				
				PutImagem(nColSel , cTexto , Right(cLblSelected ,4) ) 
				
				SetProperty('fSplit2','Image_1','Visible', .t.)	
				lOk := .t.
				
		End If
	End If


Return lOk

Function InitTela(  lIni1  , nColz1)

	Local i

	Default lIni1 := .f.
	
	Default nColz1 := 1
	

	DoMethod(cMenuName,"Hide")
	
	//If (!lIni1) .And. (nColz1 > 1)
	IntCli()   
	//End If    

	SetProperty( cAuxName , 'Width' , GetDeskTopWidth() )

	SetProperty( cAuxName , 'Height' , 52)


	//SetProperty( cFormPrin ,  'Frame_1' , 'Width' , GetDeskTopWidth() - 5 )

	OpenReg( , ,   nColz1 )
	

	RefreshAll(cMenuName) 

	If (!lIni1) .And. (nColz1 > 1)
	   	CrieMenuLabel(aOpz1)     
	End If	 

	
	*//Critico
	RefreshAll(cFormPrin) 
	//SysWait(2)
	
	If nEven1 > 0
	   EventRemove ( nEven1 )
	End If
	
	If nEven1 > 2
	   EventRemove ( nEven2 )
	End If

	EventProcessAllHookMessage(nEven1 := (EventCreate({ || LabelEventBrow() }, GetControlHandle( 'br_grid' , cFormPrin )  ) )  , .T.)  
	EventProcessAllHookMessage(nEven2 := (EventCreate({ || LabelEventBrow() }, GetControlHandle( 'ImgCabec' , cBrowName ) ) ) , .T.)  
	
	//EventRemove ( nIndex )
	
  //msginfo(Str(nEven1) + ' ' + Str(nEven2) )
  
  
	hBit21 := CreateBmp()
	
	_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  cBrowname )  ,  0 )    
	LISTVIEW_SCROLL( GetControlHandle( 'br_grid', cFormPrin ), 1 , 0 )    
	
Return



Function HScroll()

	Local nPos1 := Getproperty(fScrName , "HscrollBar" , "Value")
	Local l1    := nPosScr+1 
	//msginfo('hscr')

	IF nPos1 > nScrolTam
		msginfo('Posição invalida!')
		Return
	End If

	_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  cBrowname )  ,  nPos1 )    
	nSaveScr := nPos1
	//LISTVIEW_SCROLL( GetControlHandle( 'br_grid', cFormPrin ),  nPos1 - nPosScr , 0 )

	nPosScr := nPos1  
	ShowScrollBar( GetControlHandle( 'br_grid', cFormPrin ), 0, .F. )		    

REturn

Function LeftScr(   lPositivo )


	Local nIncr := 10
	//nPos1 := GetScrollPos( GetControlHandle( 'br_grid', cFormPrin ) , 0 )
	Local nMax  := GetScrollRangeMax (GetControlHandle( 'br_grid', cFormPrin ) , 0 )

	Local nMax2  := GetScrollRangeMax (GetFormHandle( fScrName ) , 0 )



	If lPositivo

		If nPosScr <= nScrolTam
			//nTotWidth
			//msginfo(Str(nPosScr) + '  ' + Str( nScrolTam) ) 
			nPosScr += nincr
		Else
			//msginfo('Maximo atingido!')  	    
			Return
		End If	  
	Else     

		nIncr   := -10       
		nPosScr -= 10     

		If nPosScr < 0
			nPosScr := 0
			Return
		End If


	End If 	 


	//_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  cBrowname )  , 127)

	_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  cBrowname )  ,  nPosScr )    
	LISTVIEW_SCROLL( GetControlHandle( 'br_grid', cFormPrin ),  nIncr , 0 )    

	ShowScrollBar( GetControlHandle( 'br_grid', cFormPrin ), 0, .F. )		         
	ShowScrollBar( GetFormHandle(  cBrowname ), 0, .F. )		         


	nPos2 := GetScrollPos( GetControlHandle( 'br_grid', cFormPrin ) , 0 )      
	nPos3 := GetScrollPos( GetFormHandle(  fScrName) , 0 )      

	//msginfo(Str(nMax) + ' ' + Str(nMax2) +' ' + Str(nPos3) )
	//Syswait(.2)


	If !lPositivo

	End If

	//For i := 1 to Len(aMtrHeader)
	//  PostMessage( GetControlHandle( aMtrHeader[i] , cBrowName ) , WM_MOUSELEAVE, 0, 0)         
	//Next  


Return


Function xGetItMtr(nCol)

	//Aadd(aMtrHeader , {  nColL , aTams[n2]  , Alltrim(aCabec[n2])  } )

	Local nInd1 := Ascan( aMtrHeader ,  { | a|  (a[1] <= nCol) .And. (nCol <= a[1]+a[2])  }  )


Return (nInd1)


Function OpenReg( cFiltro1  , cFiltro2  , nColz)

	//PRIVATE aHeaderDb := aHeader
	//PRIVATE aCamposDb := aCampos

	Local cSqlx1 := ''
	Local n1 := 1
	Local aCampos := GetCamposDic( cTabela, 'S' , .t. , .t. )
	Local aCabec  := GetCamposDic( cTabela, 'S' , .f. , .t. )
	Local aTams   := GetCamposInf( cTabela, 'TAM' )   
	Local aTips   := GetCamposInf( cTabela, 'TIPO' )
	LOCAL nQReg := GetReg( cTabela )
	Local qReg1 := 200
	Local calias := "TMP"
	local cTab1  
	local aCabex:={}

	LOCAL lBold      := .F.
	LOCAL lItalic    := .F.
	LOCAL lUnderline := .F.
	LOCAL lStrikeOut := .F.

	Local aDynfont   := {}
	
	Local nColy

	// Local aTams := {}

	Local am1 := {}
	Local aItens := {}

	local cGridname := 'Br_grid'

	Local bGrid1 := {}
	Local bGrid2 := {}
	
	Local nW1

	Local oServer

	Local cLabelx := 'Lblx01'
	
	Default nColz := 183
	
	
	nColy := nColz

	aMtrHeader := {}

	Default cFiltro1 := ''
	Default cFiltro2 := ''

	cSqlx1 := 'Select '
	Refreshall(cFormPrin)

	csq2:=''

	If !Empty(cFiltro1)
		cSq2 := GetSql( cTabela  , .f. )  + ' Where ' + cFiltro1 

	Else   
		cSq2 := GetSql( cTabela  , .f. )   
	End If

	If (Select(calias) > 0)
		dbSelectArea( cAlias )
		Use    
	End If

	cSqlx2 := cSqlx1

	SaveLog("st121.txt" , cSq2 )


	dbUseArea( .T.,,  cSq2, cAlias )
	//DBUSEAREA( .T.,, "select * from test", "test" )
	dbSelectArea( cAlias )
	dbGoTop()

	aItens := {}

	nF1 := {|| ARRAY FONT "Arial"   SIZE 9 }
	nF1 := {|| ARRAY FONT "Arial"   SIZE 9 BOLD}

	aDynFont := {}

	While !Eof()


		aM1 := {}
		aDynFont := {}
		For nx1 := 1 To Fcount()

			cValor := hb_ansitoOem(FieldGet(nx1)) 

			//msginfo( fieldName(nx1) )             

			lNum := .f.

			If aTips[nx1] == 'B'
				cValor := PadL(alltrim(Transform( FieldGet(nx1) , "@E 999,999,999.99" )),14) 
				lNum := .t.
			End If

			If (aTips[nx1] == 'I') 

				If (nX1 > 1)
					cValor := Padl(alltrim( Str( FieldGet(nx1) )),25)
					lNum := .t.
				Else
					cValor := Alltrim( Str( FieldGet(nx1) ) )
				End If		

			End If


			If (lNum)
				Aadd(aDynFont , {|| ARRAY FONT "Courier"   SIZE 12 ITALIC UNDERLINE } )
			Else
			
			  If FieldName(nx1)  = 'Codigo'
					 Aadd(aDynFont , {|| ARRAY FONT "Arial"  SIZE 8 BOLD } )
				Else
				   Aadd(aDynFont , {|| ARRAY FONT "Arial"   SIZE 8 } )
				End If	 
				
			End If    

			Aadd(aM1 , cValor )

		Next

		Aadd(aItens , aM1 )         

		Dbskip()

	Enddo

	n2 := 1

	bGrid1 := {}
	bGrid2 := {}

	aJustify := {}

	//aeval(atams , { |a| msginfo(str(a)) } )


	aCabex := {}
	cCabecy := ''
	nColl   := 5
	//10
	nSeqx   := 345
	For n2 := 1 TO Len(aTips)          

		AAdd( aJustify, GRID_JTFY_LEFT )

		cLabelx := "BtnHeader" + StrZero(n2,3)

		Aadd(aMtrHeader , {  nColL , aTams[n2]  , Alltrim(aCabec[n2])  } )

		nColL += aTams[n2]       			

	Next


	If _IsControlDefined(cGridname , cFormPrin )
		_ReleaseControl( cGridname , cFormPrin )
	End If		

	If _IsControlDefined(cLabelx , cFormPrin )
		_ReleaseControl( cLabelx , cFormPrin )
	End If		

 cLabelx := 'Lblb01x'
 
  If _IsControlDefined(cLabelx , cFormPrin )
		_ReleaseControl( cLabelx , cFormPrin )
	End If		


	DEFINE LABEL &(cLabelx )
				PARENT    &cFormPrin
				//PARENT    Main 
				ROW       52
				COL       Iif(nColz = 1 ,1 , 180 )
				WIDTH     GetDeskTopWidth() 
				HEIGHT    18
				VALUE    Space(135) + Alltrim (cTitle) + '  ' + Dtoc(dDataBase) + "  " + Alltrim(cUserName) + ' ' + +  AllTrim( Transform(  Len(aItens) ,'999,999,999' ) ) + ' Registros '
				ALIGNMENT LEFT
				FONTNAME 'Arial'
				FONTSIZE 9
				FONTBOLD .f.
				BACKCOLOR {7,101,125}
				FONTCOLOR {255,255,255}			         
				TRANSPARENT .f.
	END LABEL  

	//SetProperty( cForm, "LblTxt1", "Value", DToC( dDataBase ) +  '   ' +  AllTrim( Transform(  Len(aItens) ,'999,999,999' ) ) + ' Registros ' )      
	//SetProperty(cFormPrin , cLabelx  , "BACKCOLOR", {7,101,125})

	DbGoTop()
	bGrid1 := {}
	bGrid2 := {}

	//bColorGrid := {|| iif( ( LastRec() > 0 ) .AND. ( RecNo() / 2 == Int(RecNo() / 2 ) ), { 235,243,242 }, {211,231,230} ) }
	aZ1 := {}

	FOR n2 := 1 TO Len(aCabec)    

		AAdd( bGrid1, bColorGrid  )
		AAdd( bGrid2, fColorGrid )

		//msginfo(aCabec[n2] + ' ' + Str( aTams[n2]) )


	NEXT


	
	Do Events     

	aM6 := {}        
	aadd(aM6 , aCabec )


	_HMG_SYSDATA [ 348 ] := {255,255,255}
	_HMG_SYSDATA [ 349 ] := {28,157,189}
	_HMG_SYSDATA [ 350 ] := {255,255,255}
	_HMG_SYSDATA [ 351 ] := {28,157,189}

	//270
	//@ 101, 183 GRID &cGridName ;
	
	nW1 := GetDeskTopWidth() - 180 
	
	If (nColy = 1)
	   nW1 := GetDeskTopWidth() 
	End If
	
	@ 101, nColy  GRID &cGridName ;
	OF &cFormPrin ;
	WIDTH nW1 ;
	HEIGHT GetDeskTopHeight() - 243 ;
	NOLINES ;      
	HEADERS aCabec ;      
	FONT 'Arial' SIZE 9;      
	ITEMS aItens ;      
	FONTCOLOR { 78, 78, 78 } ;      
	JUSTIFY aJustify ;
	CELLNAVIGATION ;
	WIDTHS aTams ;            
	NOHEADERS;               
	BACKCOLOR {255,255,255} ;
	DYNAMICBACKCOLOR bGrid1

	//CELLNAVIGATION ;

	SetProperty( cFormPrin , cGridName , "PaintDoubleBuffer" , .t.)         

	If aTips[1] $ "BN"
		SetProperty(cFormPrin , cGridName , "COLUMNDYNAMICFONT" ,  1 , {|| ARRAY FONT "Arial" SIZE 8 BOLD   } )      
	End If   

	For nz1 := 2 to Len(aTips)
		If (aTips[nz1] $ "BN") 
			SetProperty(cFormPrin , cGridName , "COLUMNDYNAMICFONT" ,  nZ1 , {|| ARRAY FONT "Courier New" SIZE 9 BOLD   } )         	
		End If
		
		If aCabec[nz1 - 1] = 'Codigo'
		   //msginfo('lp')
		    SetProperty(cFormPrin , cGridName , "COLUMNDYNAMICFONT" ,  nZ1 - 1 , {|| ARRAY FONT "Arial" SIZE 9 BOLD   } )         	
		End If
		
	Next

	nTotWidth := 0
	l1        := 0   

	Aeval( aTams , { |a| (l1++ , nTotWidth += get_grid_colwidth('br_grid', cFormPrin , l1)    )   } )   	


	nW1 := GetDeskTopWidth() - 180
	nScrolTam := 0

	If nTotWidth > nW1
		nScrolTam := (ntotWidth - nW1)    		 
	End If		 

	nTamBarra := (nw1 - nScrolTam - 40)		

	//msginfo(Str(nTotWidth) + '  ' + Str( GetDeskTopWidth() - 180 ) )


	SetProperty(cFormPrin , cGridName , "Value" , {1,1} )
	
	
	SetProperty(cBrowName ,  "COL" , nColy )


	SetProperty(cFormPrin , cLabelx  , "BACKCOLOR", {7,101,125})

	cTituloJan := GetProperty(cFormPrin , "Title" )    
	nQRegx     := Tmp->(ReccOunt())

	

	cTitFiltro := ''

	DbGotop()

	
	If !Empty(cFiltro1)
		cTitFiltro := cFiltro1 + ' (' + cFiltro2 + ')'
	End If



	DbGotop()
	Use

	//sysWait(.1)

	SETSCROLLRANGE ( GetControlHandle( 'br_grid', cFormPrin ) ,  0  , 0 , nTotWidth  , .T. )  

	
	SetProperty( cBrowName , "VirtualWidth" ,  nTotWidth)    

	SetProperty( cBrowName , "Height" ,  31)    

	//SetProperty( cBrowName , "ImgCabec" , "Width" ,  nTotWidth)    

	SetProperty( cBrowName , "Width" ,  nTotWidth)  
	//GetDeskTopWidth() - 190)  

	//SETSCROLLRANGE ( GetFormHandle( fScrName) ,  0  , 0 , nScrolTam  , .T. )

	SETSCROLLRANGE ( GetFormHandle( cBrowName) ,  0  , 0 , nScrolTam  , .T. )
	ShowScrollBar( GetFormHandle(  cBrowname ), 0, .F. )		      



Return

Function xMouseMov()

	Local aR1
	Local nCol
	Local nRow

	GetCursorPos (@nCol, @nRow)
	aR1 := GetPos_ScreenToClient( GetFormHandle(cBrowName)  , nRow, nCol )


	saveLog('MouseX.log',  Str(ar1[1]) + ' ' + str(ar1[2])   +QUEBRA )

Return

Function CreateBmp()

	Local Width := GetProperty(cBrowName , "Width" )+3
	LOCAL BTstruct 	

	local nH1 := 28

	Local hBitmap := BT_BitmapCreateNew (Width , nH1 , {255,255,255} )
	Local nColx

	// Create hDC to a bitmap
	Local hDC := BT_CreateDC (hBitmap, BT_HDC_BITMAP, @BTstruct)     



	Local nTypeText    := BT_TEXT_TRANSPARENT +  BT_TEXT_BOLD
	Local nPos1
	//+ BT_TEXT_BOLD
	Local nAlingText   := BT_TEXT_CENTER + BT_TEXT_TOP
	Local nOrientation := BT_TEXT_NORMAL_ORIENTATION							
	Local nPos3 
	Local nText

	BT_DrawGradientFillVertical (hDC,  1  ,  1  ,  width ,   nH1   ,  ;
	Corg1 , cOrg2 )  

	nCol1:=0 	    	    

	nColx:=5
	
	nColx := aMtrHeader[1][1]

	For n1 := 1 to Len(aMtrHeader)          

		BT_DrawRectangle (hDC, 1, aMtrHeader[n1][1]+1 , aMtrHeader[n1][2] , nH1 , GRAY, 1)         
		
		If n1 > 1
			//nColx +=  aMtrHeader[n1 - 1][2]+5       	   
			//nColx += ((aMtrHeader[n1 - 1][1]+1) + aMtrHeader[n1 - 1][2] )
			
			nColx :=  aMtrHeader[n1 - 1][2]+25+aMtrHeader[n1 - 1][1]
		Else
		   nColx := 25			
		End If	             

		BT_DrawText ( hDC, 2 ,nColx+25 ,  alltrim(aMtrHeader[n1][3])   , "Arial Narrow", 9 , WHITE,  BLACK, nTypeText, nAlingText, nOrientation )		 

		nCol1 += aMtrHeader[n1][2]
		
	Next	    	    

	//BT_BitmapSaveFile (hBitmap, "Cabec.bmp") 	      


	BT_HMGSetImage (cBrowName , "ImgCabec",   hBitmap , .t.)   	    

	BT_DeleteDC (BTstruct)  




Return hBitMap


Function xDrawSize( nColx1 )

	Local hBit2 := CreateBmp()
	Local cGrid := 'Br_Grid'
	Local BTstruct
	Local BTstruct2
	Local hDC := BT_CreateDC (hBit2, BT_HDC_BITMAP, @BTstruct)
	Local hDC2

	Local nPos1 := GetScrollPos( GetControlHandle( 'br_grid', cFormPrin ) , 0 ) 

	Local hBit4 := BT_BitmapCreateNew (  abs( (nColx1+nPos1)  - aMtrHeader[nObjSize][1])  , 31 , {255,255,255} )



	hDC2 := BT_CreateDC (hBit4, BT_HDC_BITMAP, @BTstruct2)
	//BT_DrawGradientFillVertical (hDC2,  1  , 1   ,   aMtrHeader[nObjSize][1]+3+nPos1 ,   26   , RED, BLUE )    

	//BT_DrawGradientFillVertical (hDC2 ,  1  , aMtrHeader[nObjSize][1]+nPos1  ,  nColx1  ,   26   , RED , BLUE )       

	BT_DrawGradientFillVertical (hDC2 ,  1  , 1  ,  abs( (nColx1+nPos1)  - aMtrHeader[nObjSize][1])  ,   26   , RED , BLUE )       
	//aMtrHeader[nObjSize][1]+nPos1

	//BT_DrawText ( hDC2 , 2 , nColx+nColIni ,  alltrim(aMtrHeader[nObjSize][3])   , "Arial Narrow", 9, WHITE,  BLACK, nTypeText, nAlingText, nOrientation )		 

	//BT_BitmapSaveFile (hBit4 , "redim.bmp") 	      
	BT_DeleteDC (BTstruct2)  


	BT_DrawBitmapAlphaBlend (hDC, 1 ,  aMtrHeader[nObjSize][1] , nil, nil, 120 , BT_COPY  , hBit4 )      

	BT_HMGSetImage (cBrowName , "ImgCabec",   hBit2 , .f.)  
	BT_DeleteDC (BTstruct) 


Return

Function xDrawCabec(  lConsulta  )

	Local cChar1 := ''
	Local n1

	Local hDc
	LOCAL Width  := BT_ClientAreaWidth  (cBrowName)
	LOCAL Height := BT_ClientAreaHeight (cBrowName)

	Local nRow := 35
	Local nCol := 0

	Local nColx

	Local nRx1 := 0

	Local nt1 := 0

	LOCAL BTstruct 	

	Local cGrid := 'Br_Grid'

	LOCAL cFormName := cBrowName

	Local nTypeText    := BT_TEXT_TRANSPARENT +  BT_TEXT_BOLD
	//Local nPos1
	//+ BT_TEXT_BOLD
	Local nAlingText   := BT_TEXT_CENTER + BT_TEXT_TOP
	Local nOrientation := BT_TEXT_NORMAL_ORIENTATION				

	Local nPos3 
	Local nText

	Local ar1
	//Local nColx
	Local nP1	
	
	Local nPos1 := GetScrollPos( GetControlHandle( 'br_grid', cFormPrin ) , 0 )  	
	
	Default lConsulta := .f.


	If (Len(aMtrHeader) > 0) 

    If !lConsulta
    
		   hBit2 := CreateBmp()
		   
		Else
		
		   hBit2 := xConsBmp( aMtrHeader , nTotWidth+450 )		   
		   //BT_BitmapSaveFile (hBit2 , "Cabeg243.bmp") 	      	
		   
		End If   
		
		hDC := BT_CreateDC (hBit2, BT_HDC_BITMAP, @BTstruct)

		nP1 := GetColx()

		BT_DrawGradientFillVertical (hDC,  1  , aMtrHeader[nP1][1]+3  ,   aMtrHeader[nP1][2] - 3 ,   26   , {7,101,125} , {4,57,70} )       

		nColx:=25
			 
		If np1 > 1
		   	nColx :=  aMtrHeader[np1 - 1][2]+aMtrHeader[np1 - 1][1]+15
		   	//+10       	   
		End If	      
		
		BT_DrawText ( hDC, 2 , nColx+35 ,  aMtrHeader[np1][3]   , "Arial Narrow", 9, WHITE,  BLACK, nTypeText, nAlingText, nOrientation )		 
	
    //BT_BitmapSaveFile (hBit2 , "Cabec21.bmp") 	      	

		BT_HMGSetImage (cBrowName , "ImgCabec",   hBit2 , .f.)  
		
		BT_DeleteDC (BTstruct) 


	End If




Return



Function Check_Grid_Events()
	Local nMsg := EventMsg()
	Local wParam := EventWPARAM()
	Local nHWnd := EventHWND()
	Local lScrollMove:=.F.
	Local cControl
	Local cForm    
	Local nPos2
	Local lPositivo := .t.

	GetControlNameByHandle(nHWnd, @cControl, @cForm)

	// savelog('lp221.txt',' ok ' + cControl + ' ' + str(wParam) + QUEBRA )

	If cControl = fScrName

		If nMsg == WM_LBUTTONDOWN
			//msginfo('nutton ')
		End If

	End If

	If cControl = 'Br_grid'
		//savelog('lp221.txt',' ok ' + cControl + ' ' + str(wParam) + QUEBRA )



		DO CASE
			CASE nMsg = 6
			lScrollMove:=.T.
			//CASE nMsg == WM_LBUTTONDOWN
			//  lScrollMove:=.T.
			CASE nMsg == WM_KEYUP
			lScrollMove:=.T.
			//msginfo('up') 
			CASE nMsg == WM_KEYDOWN

			If wParam = 37
				lPositivo := .f.		             
			End If
			lScrollMove:=.T.


			CASE nMsg == 161
			//msginfo(Str(wParam))

			If LoWord(wParam) < 8
				lScrollMove:=.T.
				//msginfo('kk')
			EndIf

			CASE nMsg == WM_MOUSEWHEEL
			lScrollMove:=.T.
			OTHERWISE
			// Form_1.StatusBar.Item(1):=Str(nMsg)
		ENDCASE

		If lScrollMove

			nPos2 := GetScrollPos( GetControlHandle( 'br_grid', cFormPrin ) , 0 )      		      

			_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle( fScrName)   ,  nPos2 )    		      
			_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  cBrowname )  ,  nPos2 )    	

		Endif

	Endif
Return Nil

Function AtuBrw()


	OpenReg()  

	DoMethod('Main' , "SetFocus" )  

	//DoMethod('Main' , "Show" )  

Return

//PROC RDDSYS();  RETURN


Function get_grid_colwidth(ControlName,ParentForm,nColumn)

	Local c := GetControlHandle (ControlName,ParentForm)

Return ListView_GetColumnWidth ( c , nColumn - 1 )



Function RedrawMenu( aopcoes  , nindice , nLinha1  )

	Local n1
	Local cLabelx
	Local nRow := NROWINI 

	For n1 := 1 To Len(aOpcoes)

		cLabelx := Right(cFormPrin,3) + StrZero(n1,3)             

		IF _IsControlDefined( cLabelx, cFormPrin )  

			SetProperty( cFormPrin , cLabelx , "row" , nRow )        

			DoMethod(cFormPrin , cLabelx , "Refresh" )

			If nIndice = n1
				msginfo('lp')
				nRow += nLinha1
			Else
				nRow += 22
			End If	 


		End If      

	Next    


Return

Function CrieMenuLabel(aOpcoes , nInd1 , nHeight1 )

	Local n1 := 1
	Local cLabelx := ""
	Local cParent := cFormPrin
	Local nRow := NROWINI 
	Local nHandle1 

	Default nInd1    := 0
	Default nHeight1 := 0

	//If !_isControlDefined( 'G4343' , cFormPrin)
	//OpenReg()
	//End If  


	If Len(aMRow) == 0
		For n1 := 1 To Len(aOpcoes)
			aadd(aMrow , { aOpcoes[n1] , 0   } )  	     
		Next  
	End If

	For n1 := 1 To Len(aOpcoes)

		cLabelx := Right(cFormPrin,3) + StrZero(n1,3)

		If Empty(cLblConsu) .and. (aOpcoes[n1] == 'Consultas')
			cLblConsu := cLabelX         
			//msginfo(cLblConsu)
		End If

		IF !_IsControlDefined( cLabelx, cMenuName )
			DEFINE LABEL &(cLabelx )
			PARENT    &cParent
			//PARENT    Main 
			ROW       nRow
			COL       2
			WIDTH     180
			HEIGHT    20
			VALUE     Hb_AnsiToOem( alltrim(aOpcoes[n1]) )
			ALIGNMENT CENTER
			FONTNAME "Arial"
			FONTSIZE 9
			BACKCOLOR {7,101,125}
			FONTCOLOR {255,255,255}			         
			TRANSPARENT .f.
		END LABEL  

		If aMrow[n1][2] == 0
			aMrow[n1][2] := nRow
		End If   

		SetProperty(cParent, cLabelx  , "BACKCOLOR", {7,101,125})                 

		nHandle1 := GetControlHandle( cLabelx, cParent )    
		//SetHandCursor( nHandle1  , "Finger.cur" )   

		If (aOpcoes[n1] == 'Consultas') .and. (nHanConsu == 0)
			nHanConsu := GetControlHandle( cLabelx, cParent ) 
		End If

		If (nHan2 == 0)
			nHan2 := nHandle1
			//msginfo(Str(nHan2))
		End If

		EventProcessAllHookMessage(EventCreate({ || LabelEventH4() }, nHandle1  ), .T.)       

		If nInd1 > 0 
			If nInd1 = n1
				nRow += nHeight1
			Else
				nRow += 20
			End If         
		Else
			nRow += 20        
		End If    

	End If

	Next   


Return

FUNCTION LabelEventBrow()

	//STATIC lTracking6 := .F.
	STATIC lTracking25 := .F.
	STATIC lTracking125 := .f.
	LOCAL  nHWnd   := EventHWND()
	LOCAL  nMsg    := EventMSG()
	LOCAL  nWParam := EventWPARAM()
	Local cControl
	Local cForm
	Local nCol
	Local hDC
	Local nRow  
	Local BTstruct
	Local BTstruct2
	Local hBit2
	Local nColx
	Local nZ1
	Local nOrd1

	Local nInd1
	//Local nind2
	Local nInd3
	
	Local cTab

	Local lT1

	Local nTypeText    := BT_TEXT_TRANSPARENT +  BT_TEXT_BOLD
	Local nPos1
	//+ BT_TEXT_BOLD
	Local nAlingText   := BT_TEXT_CENTER + BT_TEXT_TOP
	Local nOrientation := BT_TEXT_NORMAL_ORIENTATION							


	nPos1 := GetScrollPos( GetControlHandle( 'br_grid', cFormPrin ) , 0 )


	GetControlNameByHandle(nHWnd, @cControl, @cForm)

	SaveLog('compo122.log', cControl + ' ' + cForm + '  Msg : ' + Str(nmsg) + ' Wparam :  ' + Str( LoWord( nwParam )  )  + QUEBRA  )


	If (nMsg == WM_KEYDOWN) 

		If nWParam = VK_ESCAPE
			msginfo('esc')
		End If

	End If

	If (nMsg == 275) .OR. (nMsg == 276) .or. ;
	(( nMsg == 512) .And. ( LoWord( nwParam ) ==1 ) )  .or. ;
	(  (nMsg == WM_KEYDOWN) .And. (nWParam = 37)    ) .or. ;
	(  (nMsg == WM_KEYDOWN) .And. (nWParam = 39)    )

    //msginfo('Scol')

		If (nPosAnt != nPos1)				    	      

			nMax4  := GetScrollRangeMax (GetControlHandle( 'br_grid', cFormPrin ), 0 )				    

			nSaveScr := nPos1


			_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  cBrowname )  ,  nPos1 )    
			nPosAnt := nPos1			
			//msginfo('Scol')

			//SysWait(.2)

		End If

		//sysWait(.2)


	End If


	If (nMsg == WM_LBUTTONUP)

		//msginfo('ok')


		If (!lDragMode) .And. (Alltrim(cControl) = 'ImgCabec' ) .And. (lModeSize) .And. (lAumentou)
			//msginfo('Soltour')
			SysWait(.1)

			nPos1 := GetScrollPos( GetControlHandle('br_Grid' , cFormPrin  ) , 0 )   

			GetCursorPos (@nCol, @nRow)  					
			aR1 := GetPos_ScreenToClient( GetFormHandle(cForm)  , nRow, nCol ) 					


			nTamanho1 := Abs( nColIni - (ar1[2]+nPos1)  )

			//msginfo(aMtrHeader[nObjSize ][3] + '  ' + Str(nTamanho1) )
			
			cTab := Iif(Empty(cConsuAtiva) , cTabela , cConsuAtiva )

			If SetCampoTam(cTab , aMtrHeader[nObjSize ][3] , nTamanho1 )
			
			   //msginfo(cTab)
			
			  If Empty(cConsuAtiva)
				   InitTela( .t. )     
				Else
				
				   //msginfo(cTab+ '  ' + cSqlConsulta)
				   
				   BrowConsulta( cSqlConsulta , GetCamposInf( cTab , 'CABEC'  ) , ;
				   GetCamposInf( cTab , 'TAM'  ), ;
				    GetCamposInf( cTab , 'CAMPOS'  )  , cFormPrin  , GetCamposInf( cTab , 'TIPO'  ) )
				    
				End If   


				_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  cBrowname )  ,  1 )    
				_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  cBrowname )  ,  nSaveScr )      			       


				LISTVIEW_SCROLL( GetControlHandle( 'br_grid', cFormPrin ),  nSaveScr , 0 )   			       
			

				lModeSize := .f.
				lAumentou := .f.  			   
				SysWait(.1)

			End If     


			Return



		End If



		lModeSize := .f.
		nObjSize  := 0

		If (Alltrim(cControl) = 'ImgCabec' ) .And. (lArrastou)

			lArrastou := .f.

			nPos1 := GetScrollPos( GetControlHandle('br_Grid' , cFormPrin  ) , 0 )   

			GetCursorPos (@nCol, @nRow)  					
			aR1 := GetPos_ScreenToClient( GetFormHandle(cForm)  , nRow, nCol ) 					

			nInd2 := xGetItMtr( ar1[2]+nPos1 )

			
			cTab := Iif(Empty(cConsuAtiva) , cTabela , cConsuAtiva )

			If (nInd2 > 0) .And. (nObjDrag > 0)
			

				//SetWaitCursor(  GetControlHandle('imgCabec' , cBrowName )  )
								//SysWait(.1)

				nInd1 := GetCampoOrdem( cTab , aMtrHeader[nind2][3]  )  			     

				For nZ1 := nObjDrag to nInd2 

          If nZ1 <= Len(aMtrHeader)
							nOrd1 := GetCampoOrdem( cTab , aMtrHeader[nZ1][3] ) 
		
							If !SetCampoOrdem(cTab , aMtrHeader[nZ1][3]  , nOrd1 - 1 )  			         								
								MsgInfo('Houve Falha no processo de Realocação de coluna.')
							End If							
					End If

				Next
				SetCampoOrdem(cTab , aMtrHeader[nObjDrag ][3]  , nInd1 )


				//InitTela( .t. )  			     
				
				If Empty(cConsuAtiva)
				   InitTela( .t. )     
				Else
				   
				   BrowConsulta( cSqlConsulta , GetCamposInf( cTab , 'CABEC'  ) , ;
				   GetCamposInf( cTab , 'TAM'  ), ;
				   GetCamposInf( cTab , 'CAMPOS'  )  , cFormPrin  , GetCamposInf( cTab , 'TIPO'  ) )
				    
				End If   

  

				_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  cBrowname )  ,  1 )    
				_HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  cBrowname )  ,  nSaveScr )      			       


				LISTVIEW_SCROLL( GetControlHandle( 'br_grid', cFormPrin ),  nSaveScr , 0 )   			       
		


			End If              

		End If

		lDragMode := .f. 
		nObjDrag := 0



	End If



	If (nMsg == WM_MOUSEMOVE) 

		GetCursorPos (@nCol, @nRow)  					
		aR1 := GetPos_ScreenToClient( GetFormHandle(cForm)  , nRow, nCol ) 		
		nPos1 := GetScrollPos( GetControlHandle('br_Grid' , cFormPrin  ) , 0 )     
		nInd2 := xGetItMtr( ar1[2]+nPos1 )

		If (!lDragMode) .And. (Alltrim(cControl) = 'ImgCabec' ) .And. (lModeSize) .And. (lAumentou)

			//msginfo('aqui ' + aMtrHeader[ nObjSize ][3] )
			
			//xConsBmp( aM12 , nWidth1)
			


				xDrawSize( ar1[2])
				//Bt_Clientareainvalidateall( cBrowName  )            		         
				DoMethod(cBrowName , 'imgCabec', 'Refresh' )
				syswait(.1)
				
			

			Return

		End If

		If (!lDragMode) .And. (Alltrim(cControl) = 'ImgCabec' ) .And. (lModeSize) .And. (!lAumentou) .And. ;
		   (nInd2 > 0)
			//  SetArrowCursor(  GetControlHandle('imgCabec' , cBrowName )  )  

			nIdx1 := Ascan(aMtrHeader , { |a| (((a[1]+a[2]) - ar1[2]) <= 5) .And. (a[3] == aMtrHeader[nInd2][3])    } )           
			//msginfo('ke')

			If nIdx1 == 0
			    
				lmodeSize := .f.
				nObjSize  := 0
				//msginfo('ke')
			End If


		End If

		If (!lDragMode) .And. (Alltrim(cControl) = 'ImgCabec' ) .And. (!lModeSize)

			lT1 := .f.
		
			lModeSize := .f.  		
			lAumentou := .f.
			
			If (nInd2 = 0)
			    Return			
			End If

			For nZ1 := 1 to Len(aMtrHeader)
			
				nLim := aMtrHeader[nZ1][1]+aMtrHeader[nZ1][2]

				If (nLim - (ar1[2]+npos1) ) <= 5 			       

					lt1 := .t.
					
					If nInd2 <= Len(aMtrHeader)
					
							If (aMtrHeader[nZ1][3] == aMtrHeader[nInd2][3]) 
							
								//SetSizeCursor(  GetControlHandle('imgCabec' , cBrowName )  )
		
								nObjSize  := nInd2  			               
								lModeSize := .t.  		
								nColIni   := aMtrHeader[nZ1][1]
		
							End If    					
							
					End If

				End If

			Next  			   

			Return


		End If


		If (lDragMode) .And. (Alltrim(cControl) = 'ImgCabec' ) 

			nColz1   := aMtrHeader[nObjDrag][1]       
			nWidth   := aMtrHeader[nObjDrag][2] 

			GetCursorPos (@nCol, @nRow)  					
			aR1 := GetPos_ScreenToClient( GetFormHandle(cForm)  , nRow, nCol ) 					

			nPos1 := GetScrollPos( GetControlHandle('br_Grid' , cFormPrin  ) , 0 )   


			If ((nPos1+ar1[2]) > (nColz1+nWidth))

//				SETDRAGCURSOR(  GetControlHandle('imgCabec' , cBrowName )  )

				//hBit4 := CreateBmp()
				nColx:=5
				hBit4 := BT_BitmapCreateNew (aMtrHeader[nObjDrag][2] - 3 , 31 , {255,255,255} )

				// nColx := ar1[2]+2 

				hDC2 := BT_CreateDC (hBit4, BT_HDC_BITMAP, @BTstruct2)
				BT_DrawGradientFillVertical (hDC2,  1  , 1   ,   aMtrHeader[nObjDrag][2] - 3 ,   31   , RED, BLUE )    
				BT_DrawText ( hDC2 , 2 , nColx+nColIni ,  alltrim(aMtrHeader[nObjDrag][3])   , "Arial Narrow", 9, WHITE,  BLACK, nTypeText, nAlingText, nOrientation )		 
				BT_DeleteDC (BTstruct2)  

				//BT_BitmapSaveFile (hBit4, "novo1.bmp") 	 

				hBit2 := CreateBmp()
				hDC := BT_CreateDC (hBit2, BT_HDC_BITMAP, @BTstruct)

				nColIni := ar1[2]+1

				lArrastou := .t.


				BT_DrawBitmapAlphaBlend (hDC, 1 ,  nColIni+npos1  , nil, nil, 120 , BT_COPY  , hBit4 )  


				BT_DrawText ( hDC, 2 , nColx+nColIni+npos1+30 ,  alltrim(aMtrHeader[nObjDrag][3])   , "Arial", 9, WHITE,  BLACK, nTypeText, nAlingText, nOrientation )		 

				BT_HMGSetImage (cBrowName , "ImgCabec",   hBit2 , .f.)  

				BT_DeleteDC (BTstruct) 

				//Bt_Clientareainvalidateall( cBrowName  )            
				
				DoMethod(cBrowName , 'imgCabec', 'Refresh' )

				//SETarrowCursor( GetControlHandle('imgCabec' , cBrowName ) )

				syswait(.1)

			End If

		End If

		lTracking125 := TrackMouseEvent(nHWnd) //TME_LEAVE is default flag        
		return 


	End If


	If (nMsg == WM_MOUSELEAVE)

		lTracking125 := .f.


	End If
	
		If (nMsg = WM_LBUTTONDBLCLK) .And. (Alltrim(cControl) = 'ImgCabec' )
		   
		    GetCursorPos (@nCol, @nRow)  					
		    aR1 := GetPos_ScreenToClient( GetFormHandle(cForm)  , nRow, nCol ) 		
		    nPos1 := GetScrollPos( GetControlHandle('br_Grid' , cFormPrin  ) , 0 )     
		    nInd2 := xGetItMtr( ar1[2]+nPos1 )
		    
		    nCount1 := GetProperty( cFormPrin , 'br_grid', 'ItemCount' )
		    
		    aM1 := {}
		    
		    For n21 := 1 to nCount1		    
		        Aadd(aM1 , GetProperty( cFormPrin , 'br_grid', 'Item' , n21 )		)    
		    Next
		   
		    If !lAscendente 
		       aM2 := Asort(aM1 ,,,   { |a,b| a[nInd2] <= b[nInd2] } )
		       lAscendente := .t.
		    Else
		       aM2 := Asort(aM1 ,,,   { |a,b| a[nInd2] >= b[nInd2] } )
		       lAscendente := .f.
		    End If   
		    
		    DoMethod(cFormPrin , 'br_grid' , 'DeleteAllItems' )
		    
		    For n21 := 1 to Len(aM2)	    
		        //Aadd(aM1 , GetProperty( cFormPrin , 'br_grid', 'Item' , n21 )		)    
		        
		        aZ1 := {}
		        
		        For n1 := 1 To Len(  aMtrHeader )
		            Aadd(aZ1 , aM2[n21][n1])
		        Next		        
		        
		        DoMethod(cFormPrin , 'br_grid' , 'AddItem' ,  az1  )
		        
		    Next
		    
		    DoMethod(cFormPrin , 'br_grid' , 'Refresh' )
		    
		    Return
		   
		   
		End If


	If (nMsg == WM_LBUTTONDOWN    )
		//msginfo('ok')
		
	

		If (nWParam = MK_LBUTTON) .And. (Alltrim(cControl) = 'Br_grid' )           //msginfo('ok2')
			//msginfo('ok')
			lDragMode := .f.
			lModeSize := .f.
			lAumentou := .f.			
			//SysWait(.1)
			
			CreateBmp()
			DoMethod(cBrowName , 'imgCabec', 'Refresh' )
			
			nInd2 := 0
			nObjDrag := 0
			
		End If

		If (nWParam = MK_LBUTTON) .And. (Alltrim(cControl) = 'ImgCabec' )
			//.And. (!lModeSize)          //msginfo('ok2')

			GetCursorPos (@nCol, @nRow)  					
			aR1 := GetPos_ScreenToClient( GetFormHandle(cForm)  , nRow, nCol ) 					


			nPos1 := GetScrollPos( GetControlHandle( 'br_grid', cFormPrin ) , 0 )			  	
			nInd2 := xGetItMtr(ar1[2]+nPos1)

			nObjDrag := nInd2

			If (!lModeSize )
				lDragMode := .t.
			End If    
			
			//msginfo('s')

			nColIni := aMtrHeader[nInd2][1]
			//msginfo(Str(nColIni))

			If (nInd2 > 0) .And. (!lModeSize)
		      //msginfo('lp')
				xDrawCabec( !Empty( Alltrim(cConsuAtiva))  )				
				DoMethod(cBrowName , 'imgCabec', 'Refresh' )

			End If    


			If (lModeSize )			
				lAumentou := .t.
			End If



		End If

	End If        



	//  SetHandCursor( nHandle1  , "Finger.cur" )   


REturn


Function GetColx()

	Local nRow
	Local nCol
	Local aR1
	Local nPos1

	GetCursorPos (@nCol, @nRow)  					
	aR1 := GetPos_ScreenToClient( GetFormHandle(cBrowName)  , nRow, nCol ) 					


	nPos1 := GetScrollPos( GetControlHandle( 'br_grid', cFormPrin ) , 0 )  	

	nInd2 := xGetItMtr(ar1[2]+nPos1)


REturn (nInd2)


FUNCTION LabelEventH5(aLabel)

	//STATIC lTracking6 := .F.
	STATIC lTracking25 := .F.
	LOCAL  nHWnd   := EventHWND()
	LOCAL  nMsg    := EventMSG()
	LOCAL  nWParam := EventWPARAM()
	LOCAL  cControl
	LOCAL  cForm
	Local cOpcao
	Local nTam
	Local nLinha
	Local nLine1
	Local nPulo := 130
	Local i
	Local cControlName  
	Local cFormName
	Local nRow
	Local nCol

	GetControlNameByHandle(nHWnd, @cControl, @cForm)

	SWITCH nMsg


	CASE WM_RBUTTONDOWN

	//nWidth := GetProperty(cForm , cControl , "Width" )
	//msginfo(Str(nWidth))

	HMG_ResizeControlWithCursor()  

	nWidth := GetProperty(cForm , cControl , "Width" )         

	If SvTamCampo( GetProperty(cForm , cControl , "Value" ) , cTabela , nWidth  )

		//sysWait(.1)

		OpenReg()            

		//sysWait(.3)            

		For n1 := 1 to Len(aMtrHeader)
			EventProcessAllHookMessage(EventCreate({ || LabelEventH5() }, GetControlHandle( aMtrHeader[n1] , cBrowName )  ), .T.)  
		Next		 					   

		DoMethod( cformPrin , 'br_Grid' ,'Show' )

		For i := 1 to Len(aMtrHeader)
			PostMessage( GetControlHandle( aMtrHeader[i] , cBrowName ) , WM_MOUSELEAVE, 0, 0)    
		Next   				 

		RefreshAll(cFormPrin)

	End If





	CASE WM_LBUTTONDOWN    
	//msginfo('ok')

	If nWParam = MK_LBUTTON 
		//msginfo('ok2')


		lDragMode := .t.
		cObjDrag := cControl    	

		SetProperty( cForm , cObjDrag , "BACKCOLOR" , BLUE )

		nColIni := GetProperty(cForm , cObjDrag , "Col" )

		//          GetCursorPos (@nCol, @nRow)
		//        aR1 := GetPos_ScreenToClient( GetFormHandle(cForm)  , nRow, nCol )

		//      nWidth   := GetProperty(cForm , cObjDrag , "Width" ) 
		//    nHeight  := GetProperty(cForm , cObjDrag , "Height" ) 	          

		//SetProperty( 'fDragJan','Visible',.t.)

		//SetProperty(cForm , cControl , "Visible" , .f. )    




		//CriejanDrag()

		//msginfo(cObjDrag + '  ' + str(GetProperty(cForm , cObjDrag , "Col" ))   )


		//          SaveLog("Mouse1221.txt" , str(nCol) + ' ' + str(nRow) + QUEBRA )

	Else

		If Left(cControl,3) = 'Btn'   		 


			nRow := GetProperty(cForm , cControl , "Row" ) 
			nCol := GetProperty(cForm , cControl , "Col" ) 

			nWidth   := GetProperty(cForm , cControl , "Width" ) 
			nHeight  := GetProperty(cForm , cControl , "Height" ) 

			// MoveWindow(nHWnd  , nCol + 22 , nRow, nWidth, nHeight, .T.)

			//msginfo('ok')

		End If   

	End If

	/* 
	If Left(cControl,3) = 'Btn'

	aM1 := {}        
	For i := 1 to Len(aMtrHeader)
	nW1  := GetProperty(cForm , aMtrHeader[i] , "Width" )  
	Aadd(aM1 , {   i ,GetProperty(cForm , aMtrHeader[i] , "Col" ) ,   GetProperty(cForm , aMtrHeader[i] , "Col" )+nW1      }  )

	Next

	// SetHandC()

	// syswait(.1)

	HMG_MoveControlWithCursor()  		        


	nW1 := GetProperty(cForm , cControl , "Col" )     

	nZ1 := ascan(aM1 , { |a| ( nW1 >= a[2]) .and. (  nW1  <= a[3]) } )

	If nZ1 > 0
	msginfo(Str( am1[nz1][1] ))
	End If


	For i := 1 to Len(aMtrHeader)
	PostMessage( GetControlHandle( aMtrHeader[i] , cBrowName ) , WM_MOUSELEAVE, 0, 0)    
	Next   			

	RefreshAll(cFormPrin)

	End If
	*/       


	//msginfo(Str(nW1))


	CASE (WM_MOUSEMOVE) 

	If lDragMode

		GetCursorPos (@nCol, @nRow)  					
		aR1 := GetPos_ScreenToClient( GetFormHandle(cForm)  , nRow, nCol )

		//nRow := _HMG_SYSDATA [ 191 ] 
		//nCol := _HMG_SYSDATA [ 192 ] 

		//Local c2 := "Col : " + LTRIM( STR( _HMG_SYSDATA [ 192 ] )) // Mouse Col

		SaveLog("Mouse1447.txt" , ' ln : ' + str(ar1[1]) + ' ' + str(ar1[2]) + '  ' + cObjDrag + ' ' + cForm + QUEBRA )

		nRow := GetProperty(cForm , cObjDrag , "Row" ) 
		ncol := GetProperty(cForm , cObjDrag , "Col" ) 
		//nCol := GetProperty(cForm , cObjDrag , "Col" ) 

		nWidth   := GetProperty(cForm , cObjDrag , "Width" ) 
		nHeight  := GetProperty(cForm , cObjDrag , "Height" ) 

		nH1 := GetControlHandle(  cObjDrag , cForm)
		//GetControlHandle('Image_baixo' , cFormPrin  )

		If ( (ar1[2]+nColIni) > (  (nColIni + nWidth   )  ) )

			//MoveWindow(nH1  , ar1[2] , nRow, nWidth, nHeight, .t.)		  		          
			///RedrawWindow(nH1)

			//SETWAITCURSOR()

			//syswait(.2)


			For i := 1 to Len(aMtrHeader)

				If Alltrim(aMtrHeader[i]) != alltrim(cObjDrag)
					//PostMessage( GetControlHandle( aMtrHeader[i] , cBrowName ) , WM_MOUSELEAVE, 0, 0)    
					//SetProperty(cBrowname , aMtrHeader[i]  , "BACKCOLOR" , {117,124,131} )                        
					//DoMethod( cBrowname , aMtrHeader[i], "Show")         

					RedrawWindow( GetControlHandle(aMtrHeader[i]   , cForm) )

				End If 	 

			Next

			FormHandle := GetFormHandle ( cForm )
			hDC := GetDC( FormHandle )

			//Setbkmode(hDC, TRANSPARENT )



			//BT_DrawFillRectangle (hDC, nRow ,ar1[2] , nRow+nHeight  ,ar1[2]+nWidth ,  {244,244,244} ,  {255,255,255}, 2)

			//DrawWindowBoxRaised(cForm , nRow ,ar1[2] , nRow+nHeight  ,ar1[2]+nWidth)

			//Bt_clienteInvalidateAll(cForm)

			//sysWait(.1)

			//OBTN_Pos( cBrowName , 7527, nRow, ar1[2]  , nWidth, nHeight)

			//SetProperty( cForm , cObjDrag , "BACKCOLOR" , BLUE )

			SetProperty( cForm , cObjDrag , "FONTBOLD" , .t. )
			//nColini += 

			nCol1 := GetProperty( cForm , cObjDrag , "COL" )
			nColIni += (ar1[2] - nColIni)

			SetProperty( cForm , cObjDrag , "COL" ,  nCol1 )
			RedrawWindow(nH1)

			syswait(.2)



		End If


	Else

	End If 	  



	IF (!lTracking25) .And. (!lDragMode)


		_SetToolTip(cControl,cForm,hb_AnsiToOem("Botão Direito Mouse - Redimensiona Coluna | Esquerdo - Move Coluna ") )

		//   SetProperty(cForm, cControl, "BACKCOLOR", CORSEL)        
		SetProperty(cForm, cControl, "FONTBOLD", .T.)  

		lTracking25 := TrackMouseEvent(nHWnd) //TME_LEAVE is default flag        



	ENDIF

	EXIT


	CASE WM_MOUSELEAVE   


	//SetProperty(cForm, cControl, "BACKCOLOR", BACK1)      

	If Left(cControl ,9) = 'BtnHeader'
		//   	  SetProperty(cForm , cControl  , "BACKCOLOR" , {117,124,131} )                 
		SetProperty(cForm, cControl   , "FONTBOLD", .F.)         
	Else  	  
		SetProperty(cForm, cControl   , "FONTBOLD", .F.)         
	End If 		


	lTracking25 := .F.

	EXIT


	ENDSWITCH 



REturn


function DrawWindowBoxRaised(window,row,col,rowr,colr)
	Local i := GetFormIndex ( Window )
	Local FormHandle := GetFormHandle ( Window )
	Local hDC := GetDC( FormHandle )

	WndBoxIn( hDC, row, col, rowr, colr )
	aadd ( _HMG_SYSDATA [ 102 ] [i] , { || WndBoxRaised( hDC := GetDC( FormHandle ), row, col, rowr, colr ), ReleaseDC( FormHandle, hDC ) } )
	ReleaseDC( FormHandle, hDC )

return nil


function CriejanDrag()


REturn



FUNCTION LabelEventH4(aLabel)

	//STATIC lTracking6 := .F.
	LOCAL  nHWnd   := EventHWND()
	LOCAL  nMsg    := EventMSG()
	LOCAL  nWParam := EventWPARAM()
	LOCAL  cControl
	LOCAL  cForm
	Local cOpcao
	Local nLinha
	Local nLine1
	Local nPulo := 130
	Local cTp1

	GetControlNameByHandle(nHWnd, @cControl, @cForm)

	If nMsg == WM_MOUSEMOVE

		IF ! lTracking6

			//SetProperty(cForm, cControl, "BACKCOLOR", CORSEL)        
			SetProperty(cForm, cControl, "BACKCOLOR", {4,66,81})  
			SetProperty(cForm, cControl, "FONTBOLD", .T.)          

			lTracking6 := TrackMouseEvent(nHWnd) 
			
			//msginfo( GetProperty(cForm, cControl, "VALUE" ))
			

		End If    

	End If


	If nMsg == WM_MOUSELEAVE     


		If !Empty(cLblSelected )


			If (alltrim(cControl) != alltrim(cLblSelected))         
				SetProperty(cForm, cControl, "BACKCOLOR", {7,101,125}  )        
				SetProperty(cForm, cControl, "FONTBOLD", .f.)    
				//lTracking6 := .f.	
			Else
				lTracking6 := .t.			
			End If

		Else
			SetProperty(cForm, cControl, "BACKCOLOR", {7,101,125}  )        
			SetProperty(cForm, cControl, "FONTBOLD", .f.)        
			//lTracking6 := .f.			
		End If		

		lTracking6 := .f.		  

		//msginfo('leave')

	End If

	If nMsg == WM_LBUTTONDOWN  	  

		//msginfo('lp')

		cOpcao  := alltrim(GetProperty(	 cForm, cControl, "Value" ))        
		cName  := alltrim(GetProperty(	 cForm, cControl, "Name" ))   

		//  msginfo('lp2222222222')

		If (cOpcao == alltrim(cOpSel))                
			cOpsel := '' 
			RedrawMenu( aOpz1  )
			Refreshall( cFormPrin )
			DoMethod(cMenuName , "Hide") 
			SetProperty(cFormPrin  , 'Image_baixo' , 'Visible', .f. )
			SetProperty(cFormPrin  , 'Image_cima' , 'Visible', .f. )
			ShowButConsu(.f.)

			Return     
		End If
		//    msginfo('lp2222222222')

		nLinha  := GetProperty(cForm, cControl, "Row" )
		nCnt:=0

		nix1 := ascan(aMrow , { |a| alltrim(a[1]) == alltrim(cOpcao) } )

		If nix1 > 0
			nLinha := aMRow[nix1][2]        
		Else
			msginfo('nf')   
		End If

		aSubOp := {}         
		aSubRot := {}
		ShowButConsu(.f.)

		If (cOpcao <> 'Consultas')

			nInd := Ascan( aOpz1 , cOpcao )                 

			aeval(aOpz2 , { |a| Iif(Left(a[1] ,1) == alltrim(Str(nind)), aadd(aSubOp, a[1]  ) , ) } )
			aeval(aOpz2 , { |a| Iif(Left(a[1] ,1) == alltrim(Str(nind)), aadd(aSubRot, a[2]  ) , ) } )              


		Else
			nInd := 1  


			EnchMtrConsul(cTabela)

			aeval( aConsultas , { |a| aadd(aSubOp , a) } )  
			ShowButConsu( .t. )         
			setProperty( cFormPrin , "LblQtConsu","Value", alltrim(Str( Len(aConsultas) )) )

			// msginfo( aSubOp[  Len(aSubOp) - 1 ] + ' ' + Str(    Len(aSubOp)   )  )

		End If

		cOpsel := cOpcao

		nHeight := 289

		nLine1 := nLinha+80
		//nPulo  := nHeight+22 

		If Len(aSubOp) < nItMax 
			nHeight := (Len(aSubOp) * 16)+1

			nPulo  := nHeight+22 

			SetProperty(cFormPrin  , 'Image_baixo' , 'Visible', .f. )
			SetProperty(cFormPrin  , 'Image_cima' , 'Visible', .f. )

		Else

			If Len(aSubOp) > nItMax       

				nPulo  := nHeight+62
				nLinRow := 0
				nItx1   := nItMax
				nQtElem := Len(aSubOp)
				SetProperty(cFormPrin  , 'Image_baixo' , 'Visible', .t. )
				SetProperty(cFormPrin  , 'Image_cima' , 'Visible', .t. )

				SetProperty(cFormPrin  , 'Image_baixo' , 'Picture' , 'img\setab2.png' )  		    	


			Else
				SetProperty(cFormPrin  , 'Image_baixo' , 'Visible', .f. )
				SetProperty(cFormPrin  , 'Image_cima' , 'Visible', .f. )		

			End If

		End If     


		LimpaLabels(.t.)
		LimpaLabels(.f.)  

		//   msginfo('1')

		_ShowWindow( cMenuName )     

		CrieSubMenu(aSubOp)  
		SetProperty(cMenuName , "Height" , nHeight)    


		SetProperty(cMenuName , "row" , nLine1)
		SetProperty(cMenuName , "col" , 5)

		//     msginfo('2')

		If GetProperty(cFormPrin ,"Image_baixo","Visible")
			SetProperty(cFormPrin  , 'Image_baixo' , 'Row', nLinha +  GetProperty(cMenuName , "Height" )+25   )
			SetProperty(cFormPrin  , 'Image_cima' , 'Row', nLinha +  GetProperty(cMenuName , "Height" )+43   )



			SendMessage( GetControlHandle('Image_baixo' , cFormPrin  ), WM_PAINT,0,0)
			SendMessage( GetControlHandle('Image_cima' , cFormPrin ), WM_PAINT ,0,0)	 		

			Refreshall(cFormPrin)		


			SysWait(.2)

		End If	 

		If nInd < Len(aOpz1)             
			nQtElem := Len(aSubOp)
			CrieMenuLabel(aOpz1 , nind , nPulo   )     		     		
		Else
			CrieMenuLabel(aOpz1)     		
		End If		


	End If  


Return   


Function UpScrool( nDir , nTamanho )
	Local nIncre := 16

	If nDir == 1

		//msginfo( Str(nitx1) + ' ' + str(nTamanho) ) 
		If nItx1 = nTamanho         
			Return
		End If  

		nLinRow := nLinRow + nIncre
		nItx1++

		SetProperty( cFormPrin , 'Image_cima' , 'picture' , 'img\Setac2.Png' )	 

		//msginfo( Str(nitx1) + ' ' + str(nTamanho) ) 	  	 

		If nItx1 = nTamanho         
			SetProperty(cFormPrin , 'Image_baixo' , 'picture' , 'img\setab2d.Png' )	        
			//msginfo('Topo')
		End If

	Else  

		If nItx1 > nItMax

			SetProperty(cFormPrin, 'Image_baixo' , 'picture' , 'img\Setab2.Png' )	

			nLinRow := nLinRow - nIncre
			nItx1--

			If nItx1 = nItMax
				SetProperty( cFormPrin, 'Image_cima' , 'picture' , 'img\setac2d.Png' )	 	
			End If     		

		Else
			//msginfo('Topo atingido!')      
			SetProperty(cFormPrin, 'Image_cima' , 'picture' , 'img\setac2d.Png' )	 		
		End If

	End If	  

	_HMG_PRINTER_SETVSCROLLVALUE( GetFormHandle(  cMenuName  )  , nLinRow)



Return


FUNCTION DefTitle( cTxt1 )



RETURN


Static Function Fx1( cTexto )

		//msginfo(cTexto)
		
	If (cTexto = 'novo')
	   xCadCli()	
	End If

RETURN

FUNCTION IntCli()

	// setProperty("fClientes","Label_1","BackColor", {23,23,33} )
	// SysRefresh()

	LOCAL lBold      := .F.
	LOCAL lItalic    := .F.
	LOCAL lUnderline := .F.
	LOCAL lStrikeOut := .F.

	LOCAL nB1 := IDC_BTN_1
	LOCAL nCol := 05

	SetProperty( cForm , "Width", nDeskTopWidth - 11)

	SetProperty( cMenuName , "Height", 354 )

	
	
	cFontName := 'Arial'

	FOR nx1 := 1 TO Len( aButtons )

		//OBTN_Create( cForm, nB1, aButtons[ nx1 ][ 1 ],  01, nCol,  54,  32,  .T., .T., .T.,  8, aBtnColor, aBtnFont )

		//aBtnG1
		If !(Alltrim(aButtons[ nx1 ][ 1 ]) $ cButVerde)
			//cFontName := '
			OBTN_Create( cForm, nB1, aButtons[ nx1 ][ 1 ],  19 , nCol,  80,  24,  .T., .T., .T.,  8 , aBtnColor, aBtnFont )      	 
		Else
			OBTN_Create( cForm, nB1, aButtons[ nx1 ][ 1 ],  19, nCol,  80,  24,  .T., .T., .T.,  8 ,  aBtnG1  , aBtnFont )      	 
		End If 	 

		//lBold := .t.
		nFontSize := 8
		OBTN_Font( cForm, nB1,  { cFontName, nFontSize, .t. , lItalic, lUnderline, lStrikeOut } )     



		aButtons[ nx1 ][ 5 ] := nB1
		EventProcessAllHookMessage( EventCreate( {|| EventButton() },    OBTN_Handle( cForm, nB1 )   ), .T. )

		nCol += 88
		nB1++

	NEXT

	nLinBut := nDeskTopHeight - 220
	
	If (lOpcaoAberta)

      //msginfo('lp')
      SetProperty( cFormPrin , "LblQtConsu","Visible", .t. )
			SetProperty( cFormPrin , "Label1","Visible", .t.  )
			    
      
			SetProperty( cFormPrin , "LblQtConsu","Row", nLinBut+30 )
			SetProperty( cFormPrin , "Label1","Row", nLinBut+30 )
		
			OBTN_Create( cFormPrin , 5457, "Incluir" ,  nLinBut ,4,  56,  24 ,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
			OBTN_Font( cFormPrin , 5457,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )     
		
			OBTN_Create( cFormPrin , 5458, "Editar" ,  nLinBut,62,  56,  24 ,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
			OBTN_Font( cFormPrin , 5458,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )   
		
			OBTN_Create( cFormPrin , 5459, "Excluir" ,  nLinBut, 120 ,  56,  24 ,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
			OBTN_Font( cFormPrin , 5459,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )   
		
			EventProcessAllHookMessage( EventCreate( {|| EventButton() },    OBTN_Handle( cFormPrin , 5457 )   ), .T. )
			EventProcessAllHookMessage( EventCreate( {|| EventButton() },    OBTN_Handle( cFormPrin , 5458 )   ), .T. )
			EventProcessAllHookMessage( EventCreate( {|| EventButton() },    OBTN_Handle( cFormPrin , 5459 )   ), .T. )
		
			//msginfo('pl1')
		
			OBTN_Visible( cFormPrin , 5457 , .t.)
			
			OBTN_Visible( cFormPrin , 5458 , .t.)
			OBTN_Visible( cFormPrin , 5459 , .t.)
			
			OBTN_Enable( cFormPrin , 5458 , .f.)
			OBTN_Enable( cFormPrin , 5459 , .f.)
	Else
	
	    IF OBTN_Handle(cFormPrin , 5457) > 0
	    
			    ReleaseButton(cFormPrin , 5457)
			    ReleaseButton(cFormPrin , 5458)
			    ReleaseButton(cFormPrin , 5459)
			    
			   	SetProperty( cFormPrin , "LblQtConsu","Visible", .f. )
					SetProperty( cFormPrin , "Label1","Visible", .f.  )
			    
	    End If

			
	End If


	ShowScrollBar( GetFormHandle(cMenuName ), 0, .F. )		         
	ShowScrollBar( GetFormHandle( cMenuName), 1, .F. )   

	InitBar()


RETURN

Function EnableButConsu(  lEnabled  )  
	OBTN_Enable( cFormPrin , 5458 , lEnabled )
	OBTN_Enable( cFormPrin , 5459 , lEnabled )    
REturn

Function ShowButConsu(lVisible)

	OBTN_Visible( cFormPrin , 5457 , lVisible)
	OBTN_Visible( cFormPrin , 5458 , lVisible)
	OBTN_Visible( cFormPrin , 5459 , lVisible)


	SetProperty( cFormPrin , "LblQtConsu","Visible", lVisible )
	SetProperty( cFormPrin , "Label1","Visible", lVisible )


	If lVisible
		OBTN_Enable( cFormPrin , 5458 , .f. )
		OBTN_Enable( cFormPrin , 5459 , .f.)    
	End If

Return 


Function InitBar()

	DoMethod( cMenuName , "Hide" )
	SetProperty(cFormPrin , "Image_cima"  , "Visible" , .f.)
	SetProperty(cFormPrin , "Image_baixo" , "Visible" , .f.)

	ShowScrollBar( GetFormHandle(cMenuName ), 0, .F. )		         
	ShowScrollBar( GetFormHandle( cMenuName), 1, .F. )

	// msginfo('kk')

Return

Function ButtonCon(lVisible)

	OBTN_Visible( cFormPrin , 5457 , lVisible)
	OBTN_Visible( cFormPrin , 5458 , lVisible)
	OBTN_Visible( cFormPrin , 5459 , lVisible)  

REturn

FUNCTION EventButton()

	STATIC lTracking30 := .F.

	LOCAL  nHWnd   := EventHWND()
	LOCAL  nMsg    := EventMSG()
	LOCAL  nWParam := EventWPARAM()
	LOCAL  nLParam := EventLPARAM()

	LOCAL lBold      := .F.
	LOCAL lItalic    := .F.
	LOCAL lUnderline := .F.
	LOCAL lStrikeOut := .F.


	LOCAL nind1
	LOCAL nIdBut := 0

	LOCAL n1   
	Local cFormx := cForm

	// GetDlgCtrlID

	// LOCAL ButHnd := OBTN_Handle( cForm , IDC_BTN_1 )

	LOCAL ButHnd

	//msginfo(cControl)

	nInd1 := AScan( aButtons, {| a| a[ 5 ] == nWParam } )
	// msginfo(Str(nWParam))


	FOR n1 := 1 TO Len( aButtons )

		IF ( OBTN_Handle( cForm, aButtons[ n1 ][ 5 ] ) == nHWnd )
			nIdBut := aButtons[ n1 ][ 5 ]
		END IF

		IF ( OBTN_Handle( cFormPrin, 5457 ) == nHWnd ) 
			nIdBut := 5457
			cFormx := cFormPrin			
		End If

		IF ( OBTN_Handle( cFormPrin, 5458 ) == nHWnd ) 
			nIdBut := 5458
			cFormx := cFormPrin			
		End If

		IF ( OBTN_Handle( cFormPrin, 5459 ) == nHWnd ) 
			nIdBut := 5459
			cFormx := cFormPrin			
		End If

	NEXT



	IF ( nIdBut > 0 )

		IF ( nMsg == WM_MOUSEMOVE ) .and. (!lTracking30)

			lTracking30 := TrackMouseEvent( nHWnd ) // TME_LEAVE is default flag

			If (Alltrim(OBTN_Caption(cFormx, nIdBut )) $ cButVerde )
				OBTN_Color( cFormx, nIdBut, aBtnG2 , .T. )         				
			Else
				OBTN_Color( cFormx, nIdBut, aBtnSel, .T. )         
			End If

			OBTN_Enable( cFormx, nIdBut, .T. )
			OBTN_Visible( cFormx, nIdBut, .T. )

			nindx := Ascan( aButtons , { |a| a[1] == OBTN_Caption(cFormx , nIDBut) } )

			If (nindx > 0) .And. (nIdBut != 5457) .And. (nIdBut != 5458) .And. (nIdBut != 5459)
					If !Empty(Alltrim(aButtons[nindx][4]))                    
						SetToolTip ( nHWnd  , aButtons[nindx][4] ,  GetFormToolTipHandle (cFormx)  )                                          	  
					End If
			Else
			
			   If (nIdBut = 5457)
			      SetToolTip ( nHWnd  ,  "Permitir Cadastrar uma nova Consulta." ,  GetFormToolTipHandle (cFormx)  )                                          	  
			   End If
			   
			   If (nIdBut = 5458)
			      SetToolTip ( nHWnd  ,  "Modifica a Consulta Selecionada." ,  GetFormToolTipHandle (cFormx)  )                                          	  
			   End If
			   
			   If (nIdBut = 5459)
			      SetToolTip ( nHWnd  ,  "Excluir a Consulta Selecionada." ,  GetFormToolTipHandle (cFormx)  )                                          	  
			   End If
			    		
			End If


		END IF

		IF ( nMsg == WM_MOUSELEAVE )

			If (Alltrim(OBTN_Caption(cFormx , nIdBut )) $ cButVerde)
				OBTN_Color( cFormx,  nIdBut, aBtnG1 , .T. )
				//OBTN_Font( cForm, nIdBut ,  { cFontName, nFontSize, .f. , lItalic, lUnderline, lStrikeOut } )     
			Else
				OBTN_Color( cFormx,  nIdBut, aBtnColor, .T. )
			End If            

			OBTN_Enable( cFormx, nIdBut, .T. )
			OBTN_Visible( cFormx, nIdBut, .T. )

			lTracking30 := .F.

		END IF
	ELSE

	END IF

RETURN


FUNCTION EventHndBut( nHWnd, nMsg, nWParam, nLParam )

	LOCAL nID
	LOCAL ButHnd

	LOCAL nRow, nCol
	
	Local cForm2
	Local cControl2

	Local nHnx1

	LOCAL nind1
	
	//Local cControl
	//Local cForm


	IF !_IsWindowDefined ( cForm )
		RETURN
	END IF

	IF !_IsWindowDefined ( cMenuName )
		RETURN
	END IF

	IF !_IsWindowDefined ( cFormPrin )
		RETURN
	END IF


	/*
	If !Empty(cFormPrin)

	If (cactivejan != cFormPrin)
	Return     
	End If

	IF !_IsWindowDefined ( cForm )
	RETURN
	END IF

	IF !_IsWindowDefined ( cFormPrin )
	RETURN
	END IF



	Else
	Return
	End If   

	*/

	//msginfo('ok3')        

	If _isWindowdefined(cBrowName)   
		IF nHWnd == GetProperty(  cBrowName   , "HANDLE" )

			If nMsg == WM_DRAWITEM  

				//msginfo('ok2')        

				IF (nWParam = 7527)
					//msginfo('ok')
					OBTN_Draw( nHWnd,  nWParam , nLParam )
				END IF
			End If


		End If
	End If

	IF nHWnd == GetProperty(  cFormPrin   , "HANDLE" )

		// msginfo('ok')
		// Return

		IF nMsg == WM_DRAWITEM         
			IF (nWParam >=  5457) .and. ( nWParam <=  5459  )
				OBTN_Draw( nHWnd,  nWParam , nLParam )
			END IF

		END IF

		IF nMsg == 273

			nID := LoWord( nWParam )

			IF nID == IDOK
				nID := GetDlgCtrlID( GetFocus() )
			ENDIF

			If (nId == 5458)
				PushButton( cFormPrin  , nid )  
				// msginfo('ok edit')            

        GetControlNameByHandle(nHWnd, @cControl2, @cForm2)
        
				nHxn1 := GetControlHandle(cLblConsu,cFormPrin)  
				
				cTab := GetProperty( cFormPrin  , cLblconsu , "Value" )

				If EditConsulta( cTabela , nIdConsulta)
				
				
				  //MsgInfo(cTabela+'  ' + cTab + '  Consulta : ' + cTituloCon )
				  
					PostMessage( nHxn1 ,WM_LBUTTONDOWN ,0,0)

					PostMessage( nHxn1 ,WM_LBUTTONDOWN ,0,0)
					
					SaveLog('dexl3.txt', cSqlConsulta )

					//SysWait(.2)
					
					BrowConsulta( cSqlConsulta , GetCamposInf( cTituloCon , 'CABEC'  ) , ;
				  GetCamposInf( cTituloCon , 'TAM'  ), ;
				  GetCamposInf( cTituloCon , 'CAMPOS'  )  , cFormPrin  , GetCamposInf( cTituloCon , 'TIPO'  ) )
				  
				  yAviso("Consulta Modificada com sucesso!" , .t.)


				End If

				Return         
			End If

			IF nId == 5457      

				PushButton( cFormPrin  , nid )            
				zTabela(cTabela) 

			END IF

			*//Exclusão
			IF nId == 5459

				//PushButton( cFormPrin  , nid )     
				PushButton( cFormPrin  , nId )       

				If Confirmaviso("Confirma Exclusão dessa Consulta ? " ,cFormPrin )              


					ExcluiConsulta(nIdConsulta)
					SysWait(0.5)


					nHxn1 := GetControlHandle(cLblConsu,cFormPrin)  
					//msginfo(str(nHxn1))


					If (nHxn1 > 0)   

						PostMessage( nHxn1 ,WM_LBUTTONDOWN ,0,0)

						PostMessage( nHxn1 ,WM_LBUTTONDOWN ,0,0)

						// SysWait(.2)
						yaviso("Consulta Excluida com sucesso!" , .t.)

						//Refreshall(cMenuName)
						//Refreshall(cFormPrin)		             
						
						xSetOpcao() 
						
						

					End If     

					//  msginfo('lp2')  

					//EnableButConsu(  .f.  ) 


				End If

				//msginfo('ok')
				//zTabela(cTabela) 

			END IF


		END IF

	END IF

	IF nHWnd == GetProperty(  cForm, "HANDLE" )

		IF nMsg == WM_DRAWITEM

			nInd1 := AScan( aButtons, {| a| a[ 5 ] == nWParam } )
			IF nInd1 > 0         
				OBTN_Draw( nHWnd,  aButtons[ nind1 ][ 5 ], nLParam )
			ENDIF

		ELSEIF ( nMsg == WM_MOUSEMOVE )



		ELSEIF nMsg == 273 // WM_COMMAND

			nID := LoWord( nWParam )

			IF nID == IDOK
				nID := GetDlgCtrlID( GetFocus() )
			ENDIF

			nIdBt1 := AScan( aButtons, {| a| a[ 5 ] == nId } )

			IF ( nIdBt1 > 0 )
				PushButton( cForm  , nId )
				aBlock := aButtons[ nIdBt1 ][ 2 ]
				Eval( aBlock )
			END IF

		ELSEIF nMsg == 16 // WM_CLOSE
			// MessageBoxQuit()
			RETURN 1
		ENDIF

	ELSEIF IsWindowDefined( cForm ) .AND. ( nHWnd == GetProperty( cForm, "HANDLE" ) )
		IF nMsg == 43 // WM_DRAWITEM
			// IF ( nWParam == IDC_BTN_YES ) .OR. ( nWParam == IDC_BTN_NO )
			// OBTN_Draw( nHWnd, nWParam, nLParam )
			// ENDIF

		ELSEIF nMsg == 273 // WM_COMMAND
			nID := LoWord( nWParam )

			IF nID == IDOK
				nID := GetDlgCtrlID( GetFocus() )
			ENDIF


		ENDIF
	ENDIF

RETURN NIL

Function zTabela(cTabela1)
	Local nHnx1 := GetControlHandle(cLblConsu,cFormPrin)

	If NovaConsulta(cTabela1)
		PostMessage( nHnx1 ,WM_LBUTTONDOWN ,0,0)
		SysWait(.2)
		PostMessage( nHnx1 ,WM_LBUTTONDOWN ,0,0)
		SysWait(.2)         

	End If

Return


FUNCTION ShowButton( cForm, nID, lShow )

	//msginfo('show button')
	IF OBTN_Handle( cForm, nID ) == 0
		MsgBox( "Button does not exist!" )
	ELSE
		OBTN_Visible( cForm, nID, lShow )
	ENDIF

	RETURN NIL


	PROC RDDSYS();  RETURN



Function LimpaSub()

	Local nx1 := 1

	For nx1 := 1 TO 200
		If _IsControlDefined('MenuCons' + StrZero(nx1,3) , cMenuName )
			DoMethod( cMenuName , 'MenuCons' + StrZero(nx1,3)  , "Release" )
		End If
	Next      

Return

Function LimpaLabels( lDest )

	Local nx1 := 1
	Local cLabelx1

	Default lDest := .f.

	For nx1 := 1 TO 200

		If !lDEst
			If _IsControlDefined('MenuCons' + StrZero(nx1,3) , cMenuName )
				// msginfo(' des ' + 'MenuCons' + StrZero(nx1,3) )
				DoMethod( cMenuName , 'MenuCons' + StrZero(nx1,3)  , "Release" )
			End If
		End If

		cLabelx1 := Right(cFormPrin,3) + StrZero(nx1,3)

		If lDest       
			If _IsControlDefined(  cLabelx1, cFormPrin)
				// msginfo( ' d ' +  cLabelx1 )
				DoMethod( cFormPrin , cLabelx1  , "Release" )
			End If       
		End If

	Next


Return


Function AtuLabels()

	Local nx1 := 1
	Local nHan := 0


	For nx1 := 1 TO 200
		If _IsControlDefined('MenuCons' + StrZero(nx1,3) , cMenuName )
			DoMethod( cMenuName , 'MenuCons' + StrZero(nx1,3)  , "Refresh" )

			nHan := GetControlHandle('MenuCons' + StrZero(nx1,3) , cMenuName)
			//msginfo( 'MenuCons' + StrZero(nx1,3) )
			PostMessage( nHan , WM_MOUSELEAVE, 0, 0)     

			Do Events

		End If
	Next      



Return

Function CrieSubMenu(aSub1)

	Local n1
	Local nRow := 0
	Local nCont1 := 0
	Local cLabelx
	Local nHandle1

	Local cControl := ''
	Local cForm := ''

	// msginfo('ok')

	For n1 := 1 To Len(aSub1)

		nCont1++
		cLabelx := 'MenuCons' + StrZero(nCont1,3)     

		IF !_IsControlDefined( cLabelx, cMenuName )

			nQtElem++
			DEFINE LABEL &(cLabelx )
			PARENT    &cMenuName
			//PARENT    Main 
			ROW       nRow
			COL       5
			WIDTH     169
			HEIGHT    17
			VALUE     alltrim(  Right(Hb_AnsiToOem( aSub1[n1] ) , Len( Hb_AnsiToOem( aSub1[n1] )) - 2  ) )
			ALIGNMENT LEFT
			FONTCOLOR FONTCOR
			BACKCOLOR BACK1
			TRANSPARENT .f.
		END LABEL

		nHandle1 := GetControlHandle( cLabelx, cMenuName )    
		//SetHandCursor( nHandle1  , "Finger.cur" )                       


		//msginfo('criado ')     
		EventProcessAllHookMessage(EventCreate({ || LabelEventH2() }, nHandle1  ), .T.)         

		nRow += 16        

	End If 

	Next


	ShowScrollBar( GetFormHandle(cMenuName ), 0, .F. )		         
	ShowScrollBar( GetFormHandle( cMenuName), 1, .F. )

	RefreshAll(cMenuName)     
	RefreshAll(cFormPrin) 


Return


FUNCTION CrieOpConsultas( cTabx )

	LOCAL cSql := "select * from consultas where (tabela = '"  + cTabx +  "') And ((idfilial = 0) or (idfilial = "  + AllTrim( Str( nIdEmp ) )  + ")) And (Status = 'Ativo') order by descricao"
	LOCAL oSErver
	LOCAL oQuery
	Local nRow := 0
	Local nCont1 := 0
	Local cLabelx
	Local nHandle1

	Local cControl := ''
	Local cForm := ''

	IntCli()

	oServer := GetConexao()
	oQuery  := oServer:Query( cSql )

	aLbly1 := {}

	nQtElem := 0

	FOR n1 := 1 TO oQuery:LastRec()

		oRow := oQuery:GetRow(n1)

		nCont1++
		cLabelx := 'MenuCons' + StrZero(nCont1,3)     

		IF !_IsControlDefined( cLabelx, cMenuName )

			msginfo('novo ' + Hb_AnsiToOem( Upper(GetCampo(oRow , 'descricao')) ) )

			nQtElem++
			DEFINE LABEL &(cLabelx )
			PARENT    &cMenuName
			//PARENT    Main 
			ROW       nRow
			COL       5
			WIDTH     169
			HEIGHT    17
			VALUE     Hb_AnsiToOem( Upper(GetCampo(oRow , 'descricao')) )
			ALIGNMENT LEFT
			FONTCOLOR FONTCOR
			BACKCOLOR BACK1
			TRANSPARENT .f.
		END LABEL

		nRow += 16        


		nHandle1 := GetControlHandle( cLabelx, cMenuName )    
		//SetHandCursor( nHandle1  , "Finger.cur" )                      


		EventProcessAllHookMessage(EventCreate({ || LabelEventH2() }, nHandle1  ), .T.) 
		GetControlNameByHandle(nHandle1 , @cControl, @cForm)      


		Aadd(aLbly1 , nHandle1 )        


	ELSE
		nRow += 16        
	END IF

	NEXT  

	//msginfo( str(oQuery:LastRec()  ) )

	If nQtElem > nItMax
		SetProperty(cFormPrin  , 'Image_baixo' , 'Visible', .t. )
		SetProperty(cFormPrin  , 'Image_cima' , 'Visible', .t. )
		DoMethod(cFormPrin     , "Image_baixo" ,   "show" )
		SetProperty(cFormPrin  , 'Image_baixo' , 'Picture' , 'img\setab2.png' )    
	End If



	oQuery:Destroy()
	oQuery := Nil

	oServer:Destroy()
	oServer := Nil   

	RefreshAll(cMenuName)   
	SysWait(150)   


Return

Function RefreshCli()

	EventProcessAllHookMessage(EventCreate({ || LabelEventH3() }, GetControlHandle( "Image_cima" , cFormPrin )) , .T.)    
	EventProcessAllHookMessage(EventCreate({ || LabelEventH3() }, GetControlHandle( "Image_baixo" , cFormPrin ))  , .T.)    

Return

Function SaidaLabels()

	Local n1

	For n1 := 1 To Len(aLbly1)          
		PostMessage(aLbly1[n1] , WM_MOUSELEAVE , 0, 0) 
	Next

	Do Events

	//Msginfo( 'said')

Return

Function ProcLabels()

	Local n1
	Local cControl
	Local cForm

	//Default lAtivaTimer := .t.

	For n1 := 1 To Len(aLbly1)  

		HMG_ChangeWindowStyle(aLbly1[n1]  , 0x00010200 , NIL, .F., .F.)
		HMG_ChangeWindowStyle(aLbly1[n1], WS_EX_STATICEDGE, NIL, .T., .T.)       

		EventProcessAllHookMessage(EventCreate({ || LabelEventH2() }, aLbly1[n1] ), .T.)              
		GetControlNameByHandle(aLbly1[n1], @cControl, @cForm)

		SetProperty(cForm, cControl, "BACKCOLOR", BACK1)      
		SetProperty(cForm, cControl, "FONTBOLD", .F.)             
		SetProperty(cForm, cControl, "FONTCOLOR", FONTCOR)             
		//msginfo('ok')

	Next  



	//msginfo('Proc')

	hb_idleSleep( 1 )


Return 


FUNCTION LabelEventH3(aLabel)

	STATIC lTracking5 := .F.
	LOCAL  nHWnd   := EventHWND()
	LOCAL  nMsg    := EventMSG()
	LOCAL  nWParam := EventWPARAM()
	LOCAL  cControl
	LOCAL  cForm
	Local cOpcao

	GetControlNameByHandle(nHWnd, @cControl, @cForm)


	If nMsg == WM_KEYDOWN  
		//msginfo('lp2')
	End If




	If nMsg == WM_MOUSEMOVE

		if !lTracking5  
			If (cControl == 'Image_cima') .or. (cControl == 'Image_baixo')

				If alltrim(Upper(GetProperty(cForm , cControl , 'picture' ))) = Upper("img\setab2.png")   		                  
					SetProperty(cForm , cControl , 'picture' , 'img\Setab22.Png' )				       
					lTracking5 := TrackMouseEvent(nHWnd)
				End If       

				If alltrim(Upper(GetProperty(cForm , cControl , 'picture' ))) = Upper("img\setac2.png")   		                  
					SetProperty(cForm , cControl , 'picture' , 'img\Setac22.Png' )				       
					lTracking5 := TrackMouseEvent(nHWnd)
				End If       

			End If  		 


		End If	 

	End If	        

	If nMsg == WM_MOUSELEAVE

		If (cControl == 'Image_cima') .or. (cControl == 'Image_baixo')                    
			If alltrim(Upper(GetProperty(cForm , cControl , 'picture' ))) = Upper("img\setab22.png")               
				SetProperty(cForm , cControl , 'picture' , 'img\Setab2.Png' )		          
			End If    

			If alltrim(Upper(GetProperty(cForm , cControl , 'picture' ))) = Upper("img\setac22.png")               
				SetProperty(cForm , cControl , 'picture' , 'img\Setac2.Png' )		          
			End If    

			lTracking5 := .f.		         
		End If 

	End If	      

	If nMsg == WM_LBUTTONDOWN  	

		//msginfo('ok')

		If (cControl == 'Image_baixo')
			UpScrool( 1 , nQtElem ) 
		End If		

		If (cControl == 'Image_cima')
			UpScrool( 2 , nQtElem ) 
		End If		

	End If	


Return  


FUNCTION LabelEventH2(aLabel)

	// STATIC lTracking12 := .F.
	LOCAL  nHWnd   := EventHWND()
	LOCAL  nMsg    := EventMSG()
	LOCAL  nWParam := EventWPARAM()
	LOCAL  cControl
	LOCAL  cForm
	Local cOpcao
	Local cTp1

	GetControlNameByHandle(nHWnd, @cControl, @cForm)

	//savelog('ldfd.txt' , time()  + '  ' + cControl + ' ' + cForm + QUEBRA)


	SWITCH nMsg
	//CASE WM_KEYDOWN

	// M//SGINFO('lp')


	CASE WM_LBUTTONDOWN



	SetFocus(nHWnd)
	LabelSetBorder(aLabel, nHWnd)      
	cOpcao := GetProperty(cForm, cControl, "VALUE")   
	// msginfo(copcao)


	nIndf := ascan(aOpz2 , {|a|  Right(a[1],Len(a[1]) - 2)   == alltrim(cOpcao) } )


	If alltrim(cOpSel) == 'Consultas'  

		EnableButConsu(  .f.  )      

		nIdConsulta := GetId(  'consultas' , Alltrim(cOpcao) )

		cTituloCon := Alltrim(cOpcao)
		//msginfo(cTituloCon )		

		If (nIdConsulta > 0)            
			If xInitMov(  nIdConsulta, , cTabela, .f. ,  cFormPrin )                   
			   
			   	EventProcessAllHookMessage(nEven1 := (EventCreate({ || LabelEventBrow() }, GetControlHandle( 'br_grid' , cFormPrin )  ) )  , .T.)  
			
			Else

			
				If _IsControlDefined("G4343", cFormPrin )
					DoMethod( cFormPrin , "G4343", "Release" )	
				End If	  
				Refreshall(cMenuName)
				Refreshall(cFormPrin)		                 

			End If             
			EnableButConsu(  .t.  )  


		End If   

	Else
		If nIndf > 0      
			Eval(  aOpz2[nindf][2] )		         
		End If         
	End If 


	Refreshall( cMenuName )     


	If _isControlDefined('G4343' , cFormPrin)
		DoMethod( cFormPrin , 'G4343', 'Refresh')
	End If   


	CASE (WM_MOUSEMOVE) 

	//msginfo('here') 

	//savelog('ldfd.txt' , time()  + '  ' + cControl + ' ' + cForm + ' [move ]' + QUEBRA)

	IF ! lTracking12    

		SetProperty(cForm, cControl, "BACKCOLOR", CORSEL)        
		SetProperty(cForm, cControl, "FONTBOLD", .T.)  

		lTracking12 := TrackMouseEvent(nHWnd) //TME_LEAVE is default flag        
		
		cTp1 := RetSql( "select observacao from consultas where descricao = " + QuotedStr( GetProperty(cForm, cControl, "VALUE" )  )  +  " and tabela = " + QuotedStr(cTabela) )			
      
    If !Empty(cTp1)
        //msginfo(cTp1)
        
        _SetToolTip(cControl,cForm,hb_AnsiToOem(cTp1 ) )
        //SysWait(.1)
        
        
    End If

//		msginfo(cControl)

	ENDIF

	EXIT

	CASE WM_MOUSELEAVE   


	//savelog('ldfd.txt' , time()  + '  ' + cControl + ' ' + cForm + ' [ leave ]' + QUEBRA)

	SetProperty(cForm, cControl, "BACKCOLOR", BACK1)      
	SetProperty(cForm, cControl, "FONTBOLD", .F.)         


	lTracking12 := .F.

	EXIT
	ENDSWITCH

Return  




FUNCTION Mouse_Position()
	/***********************/
	Local c1 := "Row : " + LTRIM( STR( _HMG_SYSDATA [ 191 ] )) // Mouse Row
	Local c2 := "Col : " + LTRIM( STR( _HMG_SYSDATA [ 192 ] )) // Mouse Col

	SaveLog("Mouse1.txt" , c1 + ' ' + c2 + QUEBRA )

RETURN



PROCEDURE HMG_MoveControlWithCursor()
	LOCAL hWnd, nCol, nRow
	LOCAL cFormName, cControlName
	GetCursorPos (@nCol, @nRow)
	hWnd := WindowFromPoint (nCol, nRow)
	IF GetControlIndexByHandle (hWnd) > 0
		GetControlNameByHandle (hWnd, @cControlName, @cFormName)
		DoMethod(cFormName, cControlName, "SetFocus")
		HMG_InterActiveMove  (hWnd)
		nCol := GetWindowCol (hWnd)
		nRow := GetWindowRow (hWnd)
		ScreenToClient (GetFormHandle(cFormName), @nCol, @nRow)
		SetProperty (cFormName, cControlName, "Col", nCol)
		SetProperty (cFormName, cControlName, "Row", nRow)
	ENDIF

RETURN


PROCEDURE HMG_ResizeControlWithCursor
	LOCAL hWnd, nCol, nRow
	LOCAL nWidth, nHeight
	LOCAL cFormName, cControlName
	GetCursorPos (@nCol, @nRow)
	hWnd := WindowFromPoint (nCol, nRow)
	IF GetControlIndexByHandle (hWnd) > 0
		GetControlNameByHandle (hWnd, @cControlName, @cFormName)
		DoMethod(cFormName, cControlName, "SetFocus")
		HMG_InterActiveSize (hWnd)
		nWidth   := GetWindowWidth  (hWnd)
		nHeight  := GetWindowHeight (hWnd)
		SetProperty (cFormName, cControlName, "Width",  nWidth)
		SetProperty (cFormName, cControlName, "Height", nHeight)
	ENDIF
	RETURN

	#pragma BEGINDUMP

	#include "SET_COMPILE_HMG_UNICODE.ch"
	#include "HMG_UNICODE.h"
	#include <windows.h>
	#include "hbapi.h"


	//#include "hbapi.h"
	#include "hbapiitm.h"

	static HBRUSH CreateGradientB();


	HB_FUNC ( HMG_INTERACTIVEMOVE )
	{
	HWND hWnd = (HWND) hb_parnl (1);
	if (! IsWindow(hWnd) )
	hWnd = GetFocus();
	keybd_event  (VK_RIGHT, 0, 0, 0);
	keybd_event  (VK_LEFT,  0, 0, 0);
	SendMessage  (hWnd, WM_SYSCOMMAND, SC_MOVE, 0);
	RedrawWindow (hWnd, NULL, NULL, RDW_ERASE | RDW_FRAME | RDW_INVALIDATE | RDW_ALLCHILDREN | RDW_ERASENOW | RDW_UPDATENOW);
	}


	HB_FUNC ( HMG_INTERACTIVESIZE )
	{
	HWND hWnd = (HWND) hb_parnl (1);
	if (! IsWindow(hWnd) )
	hWnd = GetFocus();
	keybd_event  (VK_DOWN,  0, 0, 0);
	keybd_event  (VK_RIGHT, 0, 0, 0);
	SendMessage  (hWnd, WM_SYSCOMMAND, SC_SIZE, 0);
	RedrawWindow (hWnd, NULL, NULL, RDW_ERASE | RDW_FRAME | RDW_INVALIDATE | RDW_ALLCHILDREN | RDW_ERASENOW | RDW_UPDATENOW);
	}



	HB_FUNC( WNDBOXRAISED )
	{
	RECT rct;

	rct.top    = hb_parni( 2 );
	rct.left   = hb_parni( 3 );
	rct.bottom = hb_parni( 4 );
	rct.right  = hb_parni( 5 );

	WindowRd( ( HDC ) hb_parnl( 1 ), &rct );
	}

	/*
	void WindowBoxIn( HDC hDC, RECT * pRect )
	{
	HPEN hWhite = CreatePen( PS_SOLID, 1, GetSysColor( COLOR_BTNHIGHLIGHT ) );
	HPEN hGray = CreatePen( PS_SOLID , 1, GetSysColor( COLOR_BTNSHADOW ) );

	WndDrawBox( hDC, pRect, hGray, hWhite );

	DeleteObject( hGray );
	DeleteObject( hWhite );
	}
	*/


	void WindowRd( HDC hDC, RECT * pRect )
	{
	//HPEN hGray  = CreatePen( PS_SOLID, 1, GetSysColor( COLOR_GRADIENTACTIVECAPTION ) );
	//HPEN hWhite = CreatePen( PS_SOLID, 1, GetSysColor( COLOR_GRADIENTACTIVECAPTION) );

	COLORREF BackColor1 = 0xFFFFFFFF;
	COLORREF BackColor2 = 0xFFFFFFFF;

	HPEN hWhite = CreatePen( PS_SOLID, 1, GetSysColor( COLOR_BTNHIGHLIGHT ) );
	HPEN hGray = CreatePen( PS_SOLID, 1, GetSysColor( COLOR_BTNSHADOW ) );


	//RECT rt1 = pRect;

	//HBRUSH hBrush;

	//hBrush = CreateGradientB(hDC, pRect->right  - pRect->left, pRect->bottom - pRect->top  , 0 , 0 , BackColor1 , BackColor2);

	//SetBkMode( hDC , TRANSPARENT );
	WndDrawBox( hDC, pRect, hWhite, hGray );



	DeleteObject( hGray );
	DeleteObject( hWhite );
	}






	#pragma ENDDUMP







