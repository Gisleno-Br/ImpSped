#include <hmg.ch>

REQUEST HB_LANG_PT
REQUEST HB_CODEPAGE_PT850

#DEFINE QUEBRA Chr(13)+Chr(10)


Function LoadFitros(cTabela1)


   LOCAL lBold      := .F.
   LOCAL lItalic    := .F.
   LOCAL lUnderline := .F.
   LOCAL lStrikeOut := .F.
   Local oSErver
   Local oQuery
   Local oRow
   local cCab1 := hb_ansiTooem('Express�o')
   
   Private aHed1 := { 'Id' , 'Filtro',cCab1}
   
   
   Private cTabx := cTabela1
   Private aCampos1 := {}
   
   Private cFiltrox1 := ''
   
   
   SET LANGUAGE TO PORTUGUESE
   SET CODEPAGE TO PORTUGUESE

   HB_SetCodePage( "PT850" )
   hb_langSelect( "PT" )

   Load Window fFiltrosCad
   
   Center Window fFiltrosCad  
     
   
   PRIVATE cJanx := 'fFiltrosCad'
   Private aButx1 := {}
   
   fFiltrosCad.LblTabela.Value := cTabx
   
     

   OBTN_Create( cJanx,  1598, "Ok", 300 , 428 ,  65,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
   OBTN_Font( cJanx, 1598,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )

   OBTN_Create( cJanx, 1599, "Cancelar", 300, 495,  65,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
   OBTN_Font( cJanx, 1599,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )

   OBTN_Create( cJanx, 1597, "Novo Filtro", 290, 4,  85,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
   OBTN_Font( cJanx, 1597,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )

   OBTN_Create( cJanx, 1596, "Modificar", 290 , 89,  62,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
   OBTN_Font( cJanx, 1596,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )

   OBTN_Create( cJanx, 1595, "Excluir", 290, 152,  62,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
   OBTN_Font( cJanx, 1595,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )

   AAdd( aButx1, {  1599,  OBTN_Handle( cJanx, 1599 ),   {||   _FechaJan(cJanx )   } ,  cJanx   } )

   AAdd( aButx1, {  1597,  OBTN_Handle( cJanx, 1597 ),   {||  PushButton( cJanx, 1597 ) , SysWait(.6) , Iif(xNovoFilt( ) , xLoadFiltros(cTabx ) , )  },  cJanx   } )

   AAdd( aButx1, {  1595,  OBTN_Handle( cJanx, 1595 ),   {|| PushButton( cJanx, 1595 ) ,SysWait(.6) ,  xExclFiltro()   },  cJanx   } )
   
   
   AAdd( aButx1, {  1596 ,  OBTN_Handle( cJanx, 1596 ),   {|| PushButton( cJanx, 1596 ) ,SysWait(.6) ,  xEditFiltro()   },  cJanx   } )
   
   
   AAdd( aButx1, {  1598,  OBTN_Handle( cJanx, 1598),    {|| cFiltrox1 := SetFiltOk() },  cJanx   } )

   EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJanx ) },    OBTN_Handle( cJanx, 1598 )   ), .T. )
   
   
   EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJanx ) },    OBTN_Handle( cJanx, 1599 )   ), .T. )
   EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJanx ) },    OBTN_Handle( cJanx, 1597 )   ), .T. )

   EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJanx ) },    OBTN_Handle( cJanx, 1596 )   ), .T. )
   EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJanx ) },    OBTN_Handle( cJanx, 1595 )   ), .T. )
   

   OBTN_Enable( cjanx , 1598, .F. )
   OBTN_Enable( cJanx , 1595, .F. )
   OBTN_Enable( cJanx , 1596, .F. )
 //  OBTN_Enable( 'fCriaConsulta', 6595, .F. )
 
   HMG_ChangeWindowStyle( fFiltrosCad.Handle, WS_EX_STATICEDGE, NIL, .T., .T. )

   HMG_ChangeWindowStyle( fFiltrosCad.Handle    , WS_BORDER, NIL, .F., .T.)
   HMG_ChangeWindowStyle( fFiltrosCad.Handle    , NIL, WS_EX_STATICEDGE, .T., .T.)
   
   ON KEY ESCAPE of fFiltrosCad action fFiltrosCad.Release()
   
   activate Window fFiltrosCad 

Return cFiltrox1

Function SetFiltOk()
 Local nI1 := fFiltrosCad.GridFiltro.value
 Local am1 := fFiltrosCad.GridFiltro.item(ni1)
 
 //msginfo( am1[3] )
 
 If !Empty(am1[3])
    Domethod('fFiltrosCad','Release')
 End If   
 

Return am1[3]

Function xExclFiltro() 

  Local a1   := fFiltrosCad.GridFiltro.Value
  Local aMtr := fFiltrosCad.GridFiltro.item(a1)
  Local cSqlx1
  Local oServer
  Local oQuery

 If Confirmaviso("Confirma  Exclus�o desse Filtro ? " , , , , .f. )    
 
     cSqlx1 := "delete from filtros where tabela = '" + cTabx + "' and idfiltros = " +  alltrim(aMtr[1])
    //msginfo(cSqlx1)
     oServer := GetConexao()  
     oQuery  := oServer:Query( cSqlx1 )  
     
     
     oServer:Destroy()
     oQuery:Destroy() 
     
   //  DoMethod('fFiltro','Release')
     //DoMethod('fFiltrosCad','Release') 
     
 
 Else
     
 End If  
 
 DoMethod('fFiltrosCad','Release') 
 ProcFiltro( cTabx )    

Return

Function xEditFiltro()

  Local a1 := fFiltrosCad.GridFiltro.Value
  Local aMtr := fFiltrosCad.GridFiltro.item(a1)
  
 // msginfo('k')
  
  If Len(aMtr) = 0
     REturn
  End If
  
  //msginfo('id ' + aMtr[1])    
  
  If xNovoFilt( .f. , val(aMtr[1]) )
     
    
  End If

REturn

Function xChgIt()

  If fFiltrosCad.GridFiltro.Value > 0 
  	 OBTN_Enable( cJanx , 1595, .t. )
  	 OBTN_Enable( cJanx , 1596, .t. )
  	 
  	 OBTN_Enable( cJanx , 1598, .t. )
  	 
  	// msginfo('ok')
  End If	

Return

Function xLoadFiltros(cTabela1 )
  Local cSqlx1 := "select * from filtros where tabela = '" + cTabela1 + "' and ativo = 'S'"
  Local oServer := GetConexao()
  Local oRow
  Local oQuery  := oServer:Query( cSqlx1 )
  
  fFiltrosCad.Gridfiltro.Deleteallitems()
  
  For n1 := 1 To oQuery:LastRec()
      oRow := oQuery:GetRow(n1)
      
      Domethod('fFiltroscad','GridFiltro','addItem' ,{ alltrim(Str(GetCampo(oRow,'IdFiltros'))) ,   GetCampo(oRow,'descricao') , GetCampo(oRow,'filtro') } )
  Next    
  
  fFiltrosCad.LblQtFiltro.Value := alltrim(Str( oQuery:LastRec()    ))
  
  If (oQuery:LastRec() > 0)
   	  //OBTN_Enable( cJanx , 1595, .t. )
      //OBTN_Enable( cJanx , 1596, .t. )
      Domethod('fFiltroscad','GridFiltro','SetFocus')
  End If 
  
  oServer:Destroy()
  oQuery:Destroy()
  
  //SysWait(.8)
  //Refreshall('fFiltrosCad')
  
Return


Static Function xNovoFilt( lNew1 , nIdFiltro )

  Local lOk := .f.
  Local cJan := 'fFiltro'
  LOCAL lBold      := .F.
  LOCAL lItalic    := .F.
  LOCAL lUnderline := .F.
  LOCAL lStrikeOut := .F.
  Local oSErver
  Local oQuery
  Local oRow
  Local n1 := 1
  LOCAL aCabec  := GetCamposDic( cTabela, ' ', .F. )
  Local cSqlx1
  
  Local nIdFlt := nIdFiltro
 //  Local oServer
 // Local oQuery
  
  Default lNew1 := .t.
  
  Private lNovoFilt := lNew1
  
  Load Window fFiltro
  
  Center Window fFiltro
  
 // fFiltro.chkOrdem.visible := .f.
  
  fFiltro.Lbltabela.value := cTabela
  
  cJanx := cJan
  
  ON KEY ESCAPE OF fFiltro action (_FechaJan(cJanx ) , cJanx := 'fFiltrosCad' ,  refreshall('fFiltrosCad') , Domethod('fFiltrosCad','SetFocus') )
  
  Private aBtx := {}
  
  WHILE n1 <= Len( aCabec )

			      If !Empty( AllTrim( aCabec[ n1 ] ) )
			         fFiltro .cmbCampo. Additem( hb_ANSIToOEM( aCabec[ n1 ] ) )
			         fFiltro .cmbOrdem. Additem( hb_ANSIToOEM( aCabec[ n1 ] ) )
			         aadd(aCampos1 , hb_ANSIToOEM( aCabec[ n1 ] ) )
			      End If   
			      n1++
			      
  Enddo 
  
  If !lNew1
  
      cSqlx1 := "select * from filtros where tabela = '" + cTabela + "' and idFiltros = " + alltrim(Str( nIdFiltro ))  
      oServer := GetConexao()
         // oRow
      oQuery  := oServer:Query( cSqlx1 )
      
      If !oQuery:Eof()
      
          oRow := oQuery:GetRow(1) 
          
          fFiltro.titulo.value    := GetCampo(oRow,'descricao')
          fFiltro.EdtFiltro.value := GetCampo(oRow,'filtro')              
          
          If !Empty(GetCampo(oRow , 'ordem'))
          
             fFiltro.cmbOrdem.value := ascan( aCampos1 ,  alltrim(GetCampo(oRow , 'ordem')) )
          End If
      
      End If
     
     oQuery:Destroy()
     oSErver:Destroy()
  
  End If
  
  OBTN_Create( cJan  ,  9598 , "Gravar Filtro", 345 , 255 ,  70,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
  OBTN_Font( cJan    , 9598  ,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )
  
  OBTN_Create( cJan  ,  9599 , "Cancelar", 345 , 325  ,  65,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
  OBTN_Font( cJan    , 9599  ,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )
  
  
  OBTN_Create( cJan  ,  959 , "Adicionar", 300 , 13 ,  70,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
  OBTN_Font( cJan    , 959  ,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )
  
  OBTN_Create( cJan  ,  958 , "Limpar", 300 , 85 ,  65,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
  OBTN_Font( cJan    , 958  ,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )  
  
  
  OBTN_Create( cJan  ,  9291 , "(", 300 , 180 ,  45,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
  OBTN_Font( cJan    , 9291  ,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )
  
  OBTN_Create( cJan  ,  9281 , ")", 300 , 232 ,  45,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
  OBTN_Font( cJan    , 9281  ,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )
  
  OBTN_Create( cJan  ,  9541 , "And", 300 , 280 ,  45,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
  OBTN_Font( cJan    , 9541  ,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )
  
  OBTN_Create( cJan  ,  9481 , "Or", 300 , 325 ,  45,  24,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
  OBTN_Font( cJan    , 9481  ,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )
  
   
  
  
  
  AAdd( aButx1, { 9598,  OBTN_Handle( cJan , 9598 ),   {||  ( PushButton( cJan  , 9598 ) , Iif( lOk := (SaveFiltro( lNew1  , nIdFlt )) , (DoMethod('fFiltro','Release'),DoMethod('fFiltrosCad','Release') ,ProcFiltro( cTabela )   ) ,    ) )  } ,  cJan   } )
  AAdd( aButx1, {  9599, OBTN_Handle( cJan , 9599 ),   {||  (_FechaJan(cJanx ) , cJanx := 'fFiltrosCad' ,  refreshall('fFiltrosCad') , Domethod('fFiltrosCad','SetFocus') )  } ,  cJan   } )  
  
  AAdd( aButx1, {  959,  OBTN_Handle( cJan , 959 ),   {|| ( PushButton( cJan  , 959 ) , FiltroAdx()   )  } ,  cJan   } )
  AAdd( aButx1, {  958,  OBTN_Handle( cJan , 958 ),   {||  (PushButton( cJan  , 958 ) ,  LimpaFilx())  } ,  cJan   } )
  
  AAdd( aButx1, {  9291,  OBTN_Handle( cJan , 9291 ),   {||  PushButton( cJan  , 9291 ) ,  UpdFiltrox('(')   } ,  cJan   } )
  AAdd( aButx1, {  9281,  OBTN_Handle( cJan , 9281 ),   {||  PushButton( cJan  , 9281 ) ,  UpdFiltrox(')')   } ,  cJan   } )
  
  
  AAdd( aButx1, {  9541 ,  OBTN_Handle( cJan , 9541 ),   {||  PushButton( cJan  , 9541 ) , sysWait(.5) , UpdFiltrox('And')   } ,  cJan   } )
  AAdd( aButx1, {  9481 ,  OBTN_Handle( cJan , 9481 ),   {||  PushButton( cJan  , 9481 ) , sysWait(.5) , UpdFiltrox('Or')   } ,  cJan   } )
  
  
  EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJan ) },    OBTN_Handle( cJan, 9598 )   ), .T. )
  EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJan ) },    OBTN_Handle( cJan, 9599 )   ), .T. )
  
  EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJan ) },    OBTN_Handle( cJan, 959 )   ), .T. )
  EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJan ) },    OBTN_Handle( cJan, 958 )   ), .T. )  
  
  EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJan ) },    OBTN_Handle( cJan, 9291 )   ), .T. )
  EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJan ) },    OBTN_Handle( cJan, 9281 )   ), .T. )
  
  EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJan ) },    OBTN_Handle( cJan, 9541 )   ), .T. )
  EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJan ) },    OBTN_Handle( cJan, 9481 )   ), .T. )
 
   OBTN_Enable( cjan , 9598, .F. )
   OBTN_Enable( cjan , 959 , .F. )
   
  //EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1, cJanx ) },    OBTN_Handle( cJanx, 1599 )   ), .T. )
  
   HMG_ChangeWindowStyle( fFiltro.Handle    , WS_BORDER, NIL, .F., .T.)
   HMG_ChangeWindowStyle( fFiltro.Handle    , NIL, WS_EX_STATICEDGE, .T., .T.)
   
   

  
  
  activate Window fFiltro


REturn lOk

Function UpdFiltrox(cCar1)

  Local c1 := alltrim(GetProperty("fFiltro","EdtFiltro","Value"))
  
  //msginfo( cCar1 )
  
  RefreshAll("fFiltro")
  
  c1 := alltrim(GetProperty("fFiltro","EdtFiltro","Value"))
  //msginfo( c1 )
  
  fFiltro.EdtFiltro.value := c1+' ' + cCar1 + ' ' 
  //DoMethod("fFiltro","EdtFiltro","Refresh")
  
  //SysWait(.2)
  
  //msginfo( fFiltro.EdtFiltro.value  )
  

REturn

Function ChgxFltr( cName )

    If (Len( Alltrim(fFiltro.titulo.value)) > 0) .And. ;
      (  !Empty(AllTrim( fFiltro.CmbCampo.Item(fFiltro.CmbCampo.Value) ))    )
      OBTN_Enable( 'fFiltro', 959, .t. )      
   End If


   IF lNovoFilt
      IF  ( Len( AllTrim(fFiltro .Valor. Value ) ) > 0 ) .OR. ( fFiltro .Getdata1. Visible  ) .or. ;
          (fFiltro .DoubleEdit. Value > 0) .or. ( fFiltro.EdtNum.Value > 0)         
            //  msginfo('p ' + cName )  
              
         IF (fFiltro .CmbCampo. value > 0 )  
         //    OBTN_Enable( cjanx , 959, .t. )
         END IF

      ELSE
          //OBTN_Enable( cjanx , 959 , .f. )
      END IF
   ELSE    
       OBTN_Enable( cjanx , 9598, .t. )
   END IF

RETURN

FUNCTION FiltroAdx()

   LOCAL cVal   := AllTrim( fFiltro .EdtFiltro. Value )

   LOCAL cTabela := AllTrim( fFiltro .lblTabela. Caption )

   LOCAL cC1    := AllTrim( fFiltro.CmbCampo.Item(fFiltro.CmbCampo.Value) )

   LOCAL cFiltro := ''
   Local cMask := "999,999,999.99"

   // Local cCampo := Left( cc1 , Len(cc1) - 2 )

   LOCAL cCampo := Lower( GetInfoDic( cC1, cTabela, 'CAMPO' ) )

   LOCAL cTipo  := GetInfoDic( cC1, cTabela, 'TIPO' )

   LOCAL cOperador := Left( AllTrim( fFiltro .CmbOperador. DisplayValue ), 2 )
   
 

   LOCAL cValor := AllTrim( fFiltro .Valor. Value )
   
   

   IF ( ( cTipo == 'I' ) .OR. ( cTipo == 'B' ) )

      IF IsAlpha( cValor )
         Aviso( 'Formato Invalido para Tipo Numerico.' )
         fFiltro .Valor. Value := ''
         RETURN
      END IF
      
      If ( cTipo == 'I' )
      	   cValor := AllTrim( Str(fFiltro .EdtNum.Value ))
      Else
      	  cValor := AllTrim( Transform(fFiltro .DoubleEdit . Value , cMask ))
      End If 	   

   END IF

   IF AllTrim( fFiltro .CmbOperador. DisplayValue ) = 'CONTEM'
      IF ( cTipo != 'C' )
         MsgExclamation( "Operador 'CONTEM' funciona apenas com campos Tipo Caracter." )
         RETURN
      END IF
   END IF

   IF ( cTipo == 'C' )
      IF AllTrim( fFiltro .CmbOperador. DisplayValue ) != 'CONTEM'
         cFiltro := AllTrim( cCampo ) + ' ' + coperador + ' ' + Chr( 39 ) + AllTrim( cValor ) + Chr( 39 )
         //msginfo(cFiltro)
      ELSE
         cFiltro := AllTrim( cCampo ) + ' LIKE ' + Chr( 39 ) + AllTrim( cValor ) + '%' + Chr( 39 )
         //msginfo(cFiltro)
      END IF
   END IF

   IF ( cTipo == 'I' ) .OR. ( cTipo == 'B' ) .OR. ( cTipo == 'N' )
      cFiltro := AllTrim( cCampo ) + ' ' +  cOperador + ' ' + cValor
   END IF

   IF ( cTipo == 'D' )

      // '2018-01-15

      cValor   := DToC( fFiltro .GetData1. Value )
      cValDate := Right( cValor, 4 ) + '-' + SubStr( cValor, 4, 2 ) + '-' + Left( cValor, 2 )
      cFiltro := AllTrim( cCampo ) + ' ' + coperador + ' '  + Chr( 39 ) + cValDate + Chr( 39 )

   END IF
   
   SetProperty('fFiltro','DoubleEdit','Value',0)
   SetProperty('fFiltro','EdtNum','Value',0)
   SetProperty('fFiltro','Valor','Value','')
   
   fFiltro.CmbCampo.Value := 1
   fFiltro.CmbOrdem.Value := 1
   
   //msginfo(cFiltro)
   
   fFiltro .EdtFiltro. Value := cVal +  ' ' + cFiltro 
   
//   OBTN_Enable( 'fFiltro', 9598, .t. )

	 OBTN_Enable( 'fFiltro', 9598, .t. )
	 OBTN_Enable( 'fFiltro', 959 , .f. )
	 
	 DoMethod('fFiltro' , 'cmbCampo' ,'SetFocus' )	 

Return

Static FUNCTION LimpaFilx()

   fFiltro .EdtFiltro. Value := '' 

   OBTN_Enable( 'fFiltro', 9598, .F. )
   OBTN_Enable( 'fFiltro', 959, .F. )
   
   SetProperty('fFiltro','DoubleEdit','Value',0)
   SetProperty('fFiltro','EdtNum','Value',0)
   SetProperty('fFiltro','Valor','Value','')
   
   fFiltro.CmbCampo.Value := 1
   fFiltro.CmbOrdem.Value := 1   

Return

Static Function SaveFiltro( lNovo  , nIdFiltro1 )

  Local lOk := .f.
  Local cSQl := ''
  Local oSErver
  Local oQuery
 // Local cSql
  
  Default lNovo := .t.

  If Confirmaviso("Confirma Grava��o desse Filtro ? " , , , , .f. )    
  
     If lNovo
        lOk := GrvFiltro( cTabx , alltrim(fFiltro.Titulo.Value) , alltrim(fFiltro.EdtFiltro.Value)   ,  fFiltro.CmbOrdem.DisplayValue  , ;
        fFiltro.ChkOrdem.Value  )
     Else
     
       
        cSQl := "Update filtros set filtro = " + chr(34) + alltrim(fFiltro.EdtFiltro.Value) +  chr(34) +  " , descricao = '" + alltrim(fFiltro.Titulo.Value) + "',"
        cSQl += "ordem = '" + alltrim(ffiltro.CmbOrdem.DisplayValue)  + "',crescente = '" +  iif(fFiltro.Chkordem.value,'S','N') + "' Where idFiltros = " + alltrim(Str(nIdFiltro1))
        
        //msginfo(cSql)
        
        oServer := GetConexao()
 			  oQuery := oServer:Query( cSql)			  
 			  

		    IF oQuery:NetErr()
		      //CursorArrow()
		       MsgStop( 'Erro ao Executar Atualiza��o -> ' + Chr( 13 ) + Chr( 10 ) + oQuery:Error() )
		       RETURN .f.
		    END IF
		    
		    lOk := .t.
		
	  	  oServer:Destroy()
	 	    oServer := Nil
		
		    oQuery:Destroy()
		    oQuery := Nil
     
     End If
    
  End If

Return lOk


Function gField()

   LOCAL cCampo := fFiltro .CmbCampo. DisplayValue
   LOCAL cTabela := AllTrim( fFiltro .lblTabela. Caption )
   
   Local cTipo
   Local cMask
   
   If (Empty(cCampo))
      Return 
   End If

   cTipo := GetInfoDic( cCampo, cTabela, 'TIPO' )
   cMask := GetInfoDic( cCampo, cTabela, 'MASCARA' )

   SetProperty( "fFiltro", "Valor", "InputMask", Nil )

   SetProperty( "fFiltro", "GetData1", "Visible", .F. )
   SetProperty( "fFiltro", "DoubleEdit", "Visible", .F. )
   SetProperty( "fFiltro", "Valor", "Visible", .F. )
   SetProperty( "fFiltro", "EdtNum", "Visible", .F. )

   IF cTipo == 'D'

      SetProperty( "fFiltro", "GetData1", "Visible", .T. )
      SetProperty( "fFiltro", "GetData1", "Col", 150 )
      SetProperty( "fFiltro", "Valor", "Visible", .F. )

      // SetProperty( 'fFiltro', 'BtnOk', 'Enabled', .T. )
      OBTN_Enable( 'fFiltro', 6600, .T. )
      // Aviso('kk')

      DO EVENTS

   END IF

   IF ( cTipo == 'B' )

      SetProperty( "fFiltro", "DoubleEdit", "Visible", .T. )
      SetProperty( "fFiltro", "DoubleEdit", "Col", 150 )
      SetProperty( "fFiltro", "DoubleEdit", "Row", 116 )

      fFiltro .DoubleEdit. Value := AllTrim( Transform( 0, cMask ) )
      SendMessage( GetControlHandle( "DoubleEdit", ThisWindow.Name ), WM_PAINT, 0, 0 )

      // fFiltro .Btnok. Enabled := .T.
      OBTN_Enable( 'fFiltro', 6600, .T. )
      fFiltro .DoubleEdit. SetFocus()
      // fFiltro .Valor. Refresh()
   END IF


   IF ( cTipo == 'N' ) .OR. ( cTipo == 'I' )


      SetProperty( "fFiltro", "EdtNum", "Visible", .T. )
      SetProperty( "fFiltro", "EdtNum", "Col", 150 )
      SetProperty( "fFiltro", "EdtNum", "Row", 116 )

      fFiltro .EdtNum. Value := AllTrim( Transform( 0, cMask ) )
      SendMessage( GetControlHandle( "EdtNum", ThisWindow.Name ), WM_PAINT, 0, 0 )

      fFiltro .EdtNum. SetFocus()
     
   END IF

   IF cTipo == 'C'
      SetProperty( "fFiltro", "Valor", "Visible", .T. )
      fFiltro .Valor. Value := ''
      SendMessage( GetControlHandle( "Valor", ThisWindow.Name ), WM_PAINT, 0, 0 )      
      OBTN_Enable( 'fFiltro', 6600, .T. )
      fFiltro .Valor. SetFocus()
   END IF
   
   If (Len( Alltrim(fFiltro.titulo.value)) > 0)
      OBTN_Enable( 'fFiltro', 959, .t. )      
   End If


   DO EVENTS

RETURN


