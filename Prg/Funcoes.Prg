#include "hmg.ch" 

#define QUEBRA chr(13)+chr(10)

#define WM_SETFOCUS 7

Declare window fSplit6
Declare window Main


Function GetCampoOrdem( cTabela , cCampo)

   LOCAL oServ   := GetConexao()
   LOCAL aCampos := {}
   Local nOrdem := 0

   LOCAL i := 1

   LOCAL oQuery
   Local oRow

   LOCAL cSql  := "Select ordem from dicionario where tabela = '" + AllTrim( cTabela ) + "' and camposistema = '" + cCampo + "'"
   
   oQuery := oServ:Query( cSql )
   
   If oQuery:LastRec() > 0
      oRow := oQuery:GetRow( 1 )
      nOrdem := oRow:FieldGet(1)
   End If
   
   oQuery:Destroy()
   oQuery := Nil

   oServ:Destroy( 0 )
   oServ := Nil

Return nOrdem

Function SetCampoOrdem(cTabela , cCampo , nOrdem1 )

   LOCAL oServ   := GetConexao()
   LOCAL aCampos := {}
   Local nOrdem := 0
   
   Local lOk := .t.

   LOCAL i := 1

   LOCAL oQuery
   Local oRow

   LOCAL cSql  := "update dicionario set ordem = "  + Alltrim(Str(nOrdem1))   
   cSQl += " where tabela = '" + AllTrim( cTabela ) + "' and camposistema = '" + cCampo + "'"
   
   SETWAITCURSOR()
   
      
    oServer := GetConexao()
 	  oQuery := oServer:Query( cSql)			  
 			  

		IF oQuery:NetErr()		
		    SETARROWCURSOR()
		    MsgStop( 'Erro ao Executar Atualização -> ' + Chr( 13 ) + Chr( 10 ) + oQuery:Error() )
		    RETURN .f.
		 END IF
		    
		lOk := .t.
		
	  oServer:Destroy()
	 	oServer := Nil
	 	
	 	SETARROWCURSOR()

Return lOk

Function SetCampoTam(cTabela , cCampo , nOrdem1 , nHandle )

   LOCAL oServ   := GetConexao()
   LOCAL aCampos := {}
   Local nOrdem := 0
   
   Local lOk := .t.

   LOCAL i := 1

   LOCAL oQuery
   Local oRow

   LOCAL cSql  := "update dicionario set tamdisp = "  + Alltrim(Str(nOrdem1))   
   cSQl += " where tabela = '" + AllTrim( cTabela ) + "' and camposistema = '" + cCampo + "'"
   
   
      
    oServer := GetConexao()
 	  oQuery := oServer:Query( cSql)			  

		IF oQuery:NetErr()		
		    //SetArrwCursor(nHandle)
		    MsgStop( 'Erro ao Executar Atualização -> ' + Chr( 13 ) + Chr( 10 ) + oQuery:Error() )
		    RETURN .f.
		 END IF
		    
		lOk := .t.
		
	  oServer:Destroy()
	 	oServer := Nil
	 	
	 

Return lOk




FUNCTION GetCamposDic( cTabela, cBrowse, lCmpTab , lOem )

   LOCAL oServ   := GetConexao()
   LOCAL aCampos := {}

   LOCAL i := 1

   LOCAL oQuery

   LOCAL cSql  := "Select * from dicionario where tabela = '" + AllTrim( cTabela ) + "' order by ordem"
   
   Default lOem := .t.

   oQuery := oServ:Query( cSql )

   FOR i := 1 TO oQuery:LastRec()

      oRow := oQuery:GetRow( i )

      IF cBrowse == 'S'

         IF oRow:FieldGet( 6 ) == 'S'
            IF !Empty( oRow:FieldGet( 5 ) )

               IF lCmpTab
               	  If (oRow:FieldGet( 4 ) == 'C') .And. (lOem)
                      AAdd( aCampos,   'hb_AnsiToOem(' + AllTrim(oRow:FieldGet(3 )) + ')'    )
                  Else
                      AAdd( aCampos,   AllTrim(oRow:FieldGet(3 ))     )
                  End If                  
               ELSE
                  AAdd( aCampos,   Hb_ansiToOem(oRow:FieldGet( 5 ))  )
               END IF

            END IF
         END IF

      ELSE
         IF !Empty( oRow:FieldGet( 5 ) )
            AAdd( aCampos,  oRow:FieldGet( 5 )  )
         END IF
      END IF

      // msginfo(oRow:FieldGet(2) )

      oQuery:Skip( 1 )

   NEXT

   oQuery:Destroy()
   oQuery := Nil

   oServ:Destroy( 0 )
   oServ := Nil

   IF Len( aCampos ) == 0
      Aviso( 'Dicionario de dados não Localizado para Tabela ' +  cTabela + QUEBRA + 'Contacte Suporte.' )
   END IF

RETURN aCampos

Function GetCampoTipo(  cCampo , cTabela )

  Local cSql := "select * from dicionarios"

REturn

FUNCTION GetSql( cTabela, lWhere )

   LOCAL aCampos := GetCamposDic( cTabela, 'S',   .t. , .f. )
   Local aTipos  := GetCamposInf( cTabela, 'TIPO' )
   //Local aTam    := GetCamposInf( cTabela, 'TAM' )
   LOCAL ni
   LOCAL nQReg := GetReg( cTabela )
//   LOCAL cSql := 'select @row_number:=@row_number+1 AS row_number,'

   LOCAL cSql1 := 'select '
   
   

   For ni := 1 TO Len( aCampos )       
      
      If (alltrim(aTipos[ni]) <> 'C')
                    
           If (alltrim(aTipos[ni]) = 'D')
              cSql1 += "lPad(Date_Format(" + AllTrim( aCampos[ ni ] ) + ", '%d/%m/%Y'),10,' ')  As " +  alltrim(aCampos[ ni ]) + " ,"
           Else  
           		cSql1 += "ifNull(" + AllTrim( aCampos[ ni ] ) + " ,0 ) As " +  alltrim(aCampos[ ni ]) + " ,"
           End If		
           
      Else
      	  cSql1 += AllTrim( aCampos[ ni ] ) + ","
      End If	 
      
      
   Next

   cSql1 := Left( cSql1, Len( cSql1 ) -1 )

   IF ( lWhere )

      IF nQreg > qTotReg
         cSql1 += " from " + cTabela + " a where id >= " + AllTrim( Str( nQreg - qTotReg ) )
      ELSE
         cSql1 += " from " + cTabela + " a "
      END IF

      cSql1 += " Order by 2"

   ELSE
      cSql1 += " from " + cTabela
   END IF
   
   SaveLog('sqlfunc.txt',cSql1)

   //msginfo( cSql)

RETURN cSql1


FUNCTION GetIndexes( cTabela )

   LOCAL oServer
   LOCAL oQuery

   LOCAL n1 := 0
   LOCAL aM1 := {}
   LOCAL cSql := ''

   cSql += "SELECT INDEX_NAME , camposistema "
   cSql += "FROM INFORMATION_SCHEMA.STATISTICS s "
   cSql += "LEFT OUTER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS t  "
   cSql += "    ON t.TABLE_SCHEMA = s.TABLE_SCHEMA "
   cSql += "       AND t.TABLE_NAME = s.TABLE_NAME "
   cSql += "       AND s.INDEX_NAME = t.CONSTRAINT_NAME "
   cSql += "LEFT OUTER JOIN dicionario b ON b.tabela = s.TABLE_NAME AND b.camporeal = s.COLUMN_NAME "
   cSql += "WHERE 0 = 0 "
   cSql += "      AND t.CONSTRAINT_NAME IS NULL "
   cSql += "AND s.TABLE_SCHEMA = '"  + AllTrim( cBanco ) + "' and s.TABLE_NAME = '" + cTabela + "'"

   // hb_MemoWrit("Con1.txt", cSql )

   oServer := GetConexao()
   oQuery  := oServer:Query( cSql )

   FOR n1 := 1 TO oQuery:LastRec()

      oGet := oQuery:GetRow( n1 )

      AAdd( aM1, oGet:FieldGet( 2 ) )

      oQuery:Skip( 1 )

   NEXT

   oServer:Destroy()
   oServer := Nil

   oQuery:Destroy()
   oQuery := Nil

RETURN aM1


FUNCTION QtReg( nX1 )

   // fClientes.lblQreg.Value := Alltrim(Transform( Reccount() , '999,999,999'))

   //tProperty( cFName, "LblQReg", "Value",  AllTrim( Transform( nX1, '999,999,999' ) ) )
   //DoMethod( cFname, "LblQReg", "refresh" )

   //DrawTit()

RETURN



FUNCTION GetReg( cTabela , cCampoId )

   LOCAL oServ := GetConexao()
   LOCAL oQuery := oServ:Query( 'select count(*) as t1 from ' + cTabela )
   LOCAL nQreg  := 0
   
   Default cCampoid := ''
   
   If !Empty(cCampoid)
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

FUNCTION GetConexao()

   LOCAL oServer := Nil
   LOCAL lRet
   LOCAL oQuery

   oServer := TMySQLServer():New( cServer, cUserDb, cPassDb )

   IF oServer:NetErr()
      MsGInfo( "Error ao Conectar SQL Server: " + QUEBRA + oServer:Error() )
      RELEASE Window ALL
      QUIT
      oServer := Nil 
      Return Nil
   ENDIF

   oServer:SelectDB( cBanco )

   IF oServer:NetErr()
      MsGInfo( "Error ao Conectar Banco " + cBanco + " : " + QUEBRA + oServer:Error() )
      RELEASE Window ALL
      QUIT
   ENDIF

RETURN ( oServer )

FUNCTION xInit()

   LOCAL aRet
   LOCAL cIniFile := "DataBase.ini"
   LOCAL aSec   
   //GetStartupFolder() 
   
   Local cIp     := ""
   Local cBanc1  := ""
   Local cUser1  := "" 
   Local cSen1   := ""
   
   Local nLop := 4
   
   
   //msginfo(  GetCurrentFolder() )
   
   IF !File( Alltrim(cInifile) )
      MsgInfo( 'Arquivo DataBase.ini não Localizado , Impossivel Continuar.' )
      //fPrincipal.Release()
   END IF

   //aSec := _GetSectionNames( cIniFile )
   
   Begin ini file cInifile    
   
	      Get cIp Section "db" ENTRY "Ip"   
	      Get cBanc1 Section "Db" ENTRY "Banco"	      
	      
	      Get cUser1 Section "Db" ENTRY "User"  
	      Get cSen1 Section "Db" ENTRY "Senha"  
	      
	 End ini

   IF Empty(cIp)
      MsgInfo( 'Arquivo DataBase.ini Comrropido  , Impossivel Continuar.' )
      RELEASE Window ALL
      QUIT
   END IF

   cServer := cIp
   cBanco  := cBanc1
   cUserDb := cUser1
   cPassDb := cSen1

   
   DO EVENTS
   
   SetProperty("fSplit4","fUserDb","Value",cBanco)
   SetProperty("fSplit4","fServerDb","Value",cServer)
   
   np1 := (nDesktopHeight - 81) - GetProperty("fSplit4","Height" )
   np2 := np1 - GetProperty("fSplit3","Height" )  
   
   SetProperty("fSplit3","Row", np2 )   
   SetProperty("fSplit4","Row", np1 )   
   
   SetProperty("fSplit5","Row",nDesktopHeight - 80 )   
   
   SetProperty("fSplit6","Row",61 )      
   
   //np2 := np1 - GetProperty("fSplit3","Height" )     
   SetProperty("fSplit6","Height", (np2 - 22) - GetProperty( "fSplit6","Row" ) )   
   
   SetProperty("fSplit5","Width",nDesktopWidth - nLop)   
   
   SetProperty("fSplit2","Width",nDesktopWidth - 50 )   
   
   SetProperty("fSplit10","Height", GetProperty("fSplit2","Height" ) )
   
   SetProperty("fSplit10","Width", nDesktopWidth - 1232 )   
    
   SetProperty("fSplit10","Col",  nDesktopWidth - 50)   
   
   SetProperty('fSplit10', 'Image_1','Transparent', .t. )
   
   
   SetProperty("fSplit10","Row", GetProperty("fSplit2","Row" )+23)  
   
   ShowScrollBar( GetFormHandle( 'fSplit2' ), 0, .F. )		         
	 ShowScrollBar( GetFormHandle( 'fSplit2' ), 1, .F. )	 
	 
	// SysWait(10)
   
   //DoMethod('fSplit10','Show')
  


RETURN

PROCEDURE Proc_ON_P1(wJanela)

   LOCAL Width  := BT_ClientAreaWidth  ( ThisWindow.name )
   LOCAL Height := BT_ClientAreaHeight ( ThisWindow.name )
   LOCAL hDC, BTstruct
   
   If hBitMap != 0
   
   
   		If wJanela = 'fSplit3'
      		DrawTransp(wJanela , hBitMap4)      		
      		//Domethod("Main" , "Release" )      		
      End If
      
      If wJanela = 'fSplit4'
      		DrawTransp(wJanela , hBitMap5)            	
      End If   
      
      Return   
   
   End If
   
   hDC = BT_CreateDC ( ThisWindow.name, BT_HDC_INVALIDCLIENTAREA, @BTstruct )
   
   //BT_DrawGradientFillVertical ( hDC, 0,       0, Width, Height - 100 , { 224, 229, 234 }, {238,240,243}  )
   
   BT_DrawGradientFillVertical ( hDC, 0,       0, Width, 15  , { 235, 235, 235 }, {235,235,235}  )
   
   BT_DeleteDC ( BTstruct )

REturn

Procedure ProcPaintx(wJan)

  LOCAL Width  := BT_ClientAreaWidth  ( wJan )
  LOCAL Height := BT_ClientAreaHeight ( wJan )
  LOCAL BTstruct
  
  Local hDC := BT_CreateDC ( wJan , BT_HDC_INVALIDCLIENTAREA, @BTstruct )
  
  BT_DrawGradientFillVertical ( hDC,   0,       0,  Width,  Height, { 9, 111, 137 }, { 7, 101, 125 })
  
  BT_DeleteDC ( BTstruct )

Return

PROCEDURE Proc_ON_PAINT(wJanela)

   //LOCAL Width  := BT_ClientAreaWidth  ( ThisWindow.name )
   //LOCAL Height := BT_ClientAreaHeight ( ThisWindow.name )
   
    LOCAL Width  := BT_ClientAreaWidth  ( wJanela )
    LOCAL Height := BT_ClientAreaHeight ( wJanela )
    Local nCol
    
    Local nTypeText    := BT_TEXT_TRANSPARENT + BT_TEXT_BOLD
	  Local nAlingText   := BT_TEXT_LEFT + BT_TEXT_TOP
	  Local nOrientation := BT_TEXT_NORMAL_ORIENTATION							

   
   
   LOCAL hDC, BTstruct
   LOCAL Cont := 5
      
      
   If hBitMap != 0
   
      If wJanela = 'fSplit2'          //hbitmap3      	
         DrawTransp(wJanela , hBitMap3)      
      End If
      
      If wJanela = 'fSplit5'          //hbitmap3      	
          DrawTransp(wJanela , hBitMap6)      
      End If      
      
      Return
      
   End If

   hDC = BT_CreateDC ( wJanela , BT_HDC_INVALIDCLIENTAREA, @BTstruct )

   // IF cont > 6
   // cont = 2
   // ENDIF

   IF ThisWindow.name = 'fCli'
      cont = 1
   END IF
   
   IF ThisWindow.name = 'fSplit5'
      cont = 12
   END IF
      
  IF Left(wJanela,5) = 'WinUp'
     cont = 13
  END IF
  
  
   DO CASE
   CASE cont = 1
      BT_DrawGradientFillHorizontal ( hDC, 0,       0, Width / 2, Height, { 213, 226, 234 }, WHITE  )
      BT_DrawGradientFillHorizontal ( hDC, 0, Width / 2, Width / 2, Height, WHITE, { 213, 226, 234 }  )

    

   CASE cont = 2
      // { 213, 226, 234 }
      BT_DrawGradientFillVertical ( hDC, 0,       0, Width, Height, { 213, 226, 234 }, WHITE  )


   CASE cont = 3
      BT_DrawGradientFillVertical ( hDC,        0,   0, Width, Height / 2, RED,   GREEN )
      BT_DrawGradientFillVertical ( hDC, Height / 2,   0, Width, Height / 2, GREEN, BLUE )

   CASE cont = 4
      BT_DrawGradientFillHorizontal ( hDC, 0,       0, Width / 2, Height, GREEN, BLUE )
      BT_DrawGradientFillHorizontal ( hDC, 0, Width / 2, Width / 2, Height, BLUE,  RED )

   CASE cont = 5
   
       BT_DrawGradientFillVertical   ( hDC,   0,       0,  Width,  Height, { 9, 111, 137 },  { 7, 101, 125 } )
      
   CASE cont = 6
      BT_DrawGradientFillHorizontal ( hDC,   0,       0,  Width,  Height, { 100, 0, 123 }, BLACK )
      
   CASE cont = 12
   
      // fSplit5
      BT_DrawGradientFillVertical ( hDC,   0,       0,  Width,  Height, {7,101,125} , {4,57,70} )
      BT_DrawText ( hDC, 05 , 10   ,  "Empresa XYZ....." , "Arial", 9, WHITE,  BLACK, BT_TEXT_TRANSPARENT , nAlingText, nOrientation )
      
      //{3,39,48} )
      
   CASE cont = 13
   
       savelog('lo23.txt' , alltrim(wJanela) + '   ' +  alltrim(cLblSelected )  + '  ' + str(Height) + ' ' + str(Width) + QUEBRA)
   

   	  If (alltrim(wJanela) != alltrim(cLblSelected))
   	  		BT_DrawGradientFillVertical ( hDC,   0,       0,  Width,  Height, { 9, 111, 137 }, {9,111,137} )
   	  Else
   	     BT_DrawGradientFillVertical ( hDC,   0,       0,  Width,  Height, { 9, 111, 137 }, { 7, 101, 125 })
   	     
   	  End If  
   	  


   END CASE


   BT_DeleteDC ( BTstruct )


RETURN

FUNCTION GetCamposInf( cTabela, cInf  ,cCampo )

   LOCAL oServ   := GetConexao()
   LOCAL aTam    := {}

   LOCAL i := 1

   LOCAL oQuery

   LOCAL cSql  := "Select * from dicionario where tabela = '" + AllTrim( cTabela ) + "' order by Ordem"
   
   Default cCampo := ''
   
   
   If !Empty(cCampo)
       cSql  := "Select * from dicionario where tabela = '" + AllTrim( cTabela ) + "' and camposistema = '" + alltrim(cCampo) + "' order by Ordem"      
   End If

   oQuery      := oServ:Query( cSql )

   FOR i := 1 TO oQuery:LastRec()

      oRow := oQuery:GetRow( i )
      
      If Empty(Alltrim(cCampo))

		      IF oRow:FieldGet( 6 ) == 'S'
		         
		        
		         IF cInf = 'CABEC'
		            AAdd( aTam,  hb_AnsiToOem( AllTrim( oRow:FieldGet(5 ) )  )   )
		         END IF
		         
		          IF cInf = 'CAMPOS'
		            AAdd( aTam,  hb_AnsiToOem( AllTrim( oRow:FieldGet(3) )  )   )
		         END IF
		
		         IF cInf = 'TAM'            
		            AAdd( aTam,  oRow:FieldGet( 7 )  )          
		         END IF
		         
		         IF cInf = 'TIPO'
		            AAdd( aTam,  oRow:FieldGet( 4 )  )
		         END IF
		
		      END IF
      
      Else
      
            IF cInf = 'CABEC'
		            AAdd( aTam,  hb_AnsiToOem( AllTrim( oRow:FieldGet(5 ) )  )   )
		        END IF
		        
		        
            IF cInf = 'SISTEMA'
		            AAdd( aTam,  hb_AnsiToOem( AllTrim( oRow:FieldGet(3 ) )  )   )
		        END IF
		
		        IF cInf = 'TAM'            
		           AAdd( aTam,  oRow:FieldGet( 7 )  )          
		        END IF
		         
		        IF cInf = 'TIPO'
		            AAdd( aTam,  oRow:FieldGet( 4 )  )
		        END IF
		        
 		        IF cInf = 'MASCARA'
		            AAdd( aTam,  oRow:FieldGet( 8 )  )
		        END IF
		        
		        IF cInf = 'RELACAO'
		            AAdd( aTam,  oRow:FieldGet( 11 )  )
		        END IF
      
      End If

   NEXT

   oQuery:Destroy()
   oQuery := Nil

   oServ:Destroy( 0 )
   oServ := Nil

   IF Len( aTam ) == 0
      yAviso( 'Dicionario de Dados não Localizado para Tabela ' +  cTabela  + '(' + cInf + ')'   + QUEBRA + 'Contacte Suporte.' )
   END IF

RETURN aTam


FUNCTION QuotedStr( cVar )
Return Chr( 39 ) + cVar + Chr( 39 )


FUNCTION ExecSql( oSrv1, cSql )

   LOCAL oQry := oSrv1:Query( cSql )
   LOCAL cText := hb_MemoRead( cSqlLog )

   IF  oSrv1:NetErr()
    //  SetCursorOnControls( IDC_ARROW )
      MsgStop( 'Erro ao Executar Consulta -> ' + Chr( 13 ) + Chr( 10 ) + oQry:Error() )
      hb_MemoWrit( cSqlLog, cText + Chr( 13 ) + Chr( 10 ) + cUserName +  ' ' + DToC( Date() ) + ' ' + Time() + '  ' + oQry:Error() )
      oQry := Nil
   END IF

RETURN oQry


FUNCTION SetCursorOnControls( xCursor )

   SetWindowCursor ( ThisWindow.Handle, xCursor )
   SetWindowCursor ( This.Handle, xCursor )    // All Controls associated with the class

RETURN NIL


FUNCTION ConvDt( dDt1 )

   LOCAL d1 := Right( DToC( dDt1 ), 4 ) + '-' + SubStr( DToC( dDt1 ), 4, 2 ) + "-" + Left( DToC( dDt1 ), 2 )
   
   If Empty( Right( DToC( dDt1 ), 4 )   )
      d1 := '0000-00-00'
   End If

RETURN d1

FUNCTION RetSql( cSql )

   LOCAL oServ   := GetConexao()
   LOCAL oRow
   LOCAL oQuery
   LOCAL cDesc := ''

   oQuery := oServ:Query( cSql )

   IF oQuery:LastRec() > 0
      oRow := oQuery:GetRow( 1 )
      cDesc := oRow:FieldGet( 1 )
   END IF

   oQuery:Destroy()
   oQuery := Nil

   oServ:Destroy( 0 )
   oServ := Nil

RETURN cDesc

FUNCTION GetCampo( oRow1, cCampo )
RETURN ( oRow1:FieldGet(  oRow1:FieldPos(cCampo ) ) )

FUNCTION GetJoinTab( cTabela )

   LOCAL cJoin := ''

   IF cTabela = 'produtos'
      cJoin += " a inner join unidade b on b.id = a.id_unidade "
      cJoin += " inner join grupo c on c.id = a.id_grupo "
      cJoin += " inner join fornecedores d on d.id = a.id_fornecedor "
   END IF

   IF cTabela = 'movacertos'
      cJoin += " a left join produtos b on b.id = a.idprod "
      cJoin += "left join local c on c.id = a.idlocal "
      cJoin += "left join eventos d on d.id = a.idevento"
   END IF

   IF cTabela = 'colaborador'
      cJoin := " b inner join funcao a on a.id = id_funcao "
   END IF

   IF cTabela = 'Pedidos'
      cJoin := " left join clientes a on a.id = idcliente "
      cJoin += "left join vendedores b on b.id = idvendedor "
      cJoin += "left join condpgto d on d.id = idcondpg "
      cJoin += "left join local e on e.id = idlocal "
   END IF

RETURN cJoin

FUNCTION PesqSql( cTabela, aHeaders  )

//   LOCAL cCampo := ''
//   LOCAL nTam   := 0
//   LOCAL aVal1  := {}
//
//   DEFAULT aHeaders := GetCamposDic( cTabela, 'S', '', .F. )
//
//   PRIVATE aCamposX := aHeaders
//
//   PRIVATE cSqlConsul := "select "
//
//   PRIVATE aCamposDb := {}
//   PRIVATE aHeaderDb   := aHeaders
//   PRIVATE aTamDb := {}
//
//   PRIVATE cTabx := cTabela
//
//   PRIVATE bColorGrid := {|| iif( This.CellRowIndex / 2 <> Int( This.CellRowIndex / 2 ), { 222,222,222 }, { 255,255,255 } ) }
//
//   PRIVATE aValores := {}
//
//   PRIVATE nIdRet := 0
//
//   PRIVATE aBcolor1 := {}
//
//   FOR nX := 1 TO Len( aHeaderDb )
//      // msginfo( aHeaderDb[nx]  )
//      AAdd( aBcolor1, bColorGrid )
//   NEXT
//
//   FOR i := 1 TO Len( aHeaders )
//
//      cCampo := GetInfoDic( aHeaders[ i ], cTabela, 'CAMPO' )
//      nTam   := GetInfoDic( aHeaders[ i ], cTabela, 'TAM' )
//
//      IF Len( cCAmpo ) > 0
//         cSqlConsul += ( AllTrim( Lower(cCampo ) ) + ',' )
//
//         AAdd( aCamposDb, cCampo )
//         AAdd( aTamDb, nTam )
//
//         AAdd( aVal1, "" )
//      END IF
//
//   NEXT
//
//   cSqlConsul := Left( cSqlConsul, Len( cSqlConsul ) -1 )
//
//   cSqlConsul += ( " from " + ctabela )
//
//   cSqlConsul += GetJoinTab( cTabela )
//
//   AAdd( aValores, aVal1 )
//
//   Load Window fPesqSql
//   ON KEY ESCAPE of fPesqSql Action ( fPesqSql.Release(),  fPesqSql := Nil )
//   ON KEY RETURN of fPesqSql Action iif( GetProperty( "fPesqSql", "FocusedControl" ) != "EdtPesq", SetOk(), Consulty() )
//
//   //DrawResults( 0 )
//
//   Center Window fPesqSql
//
//   fPesqSql .Lbltit1. value := 'Pesquisa ' + AllTrim( cTabela )
//   // fPesqSql.EdtPesq.SetFocus()
//
//   fPesqSql .CmbCampos. Value := 2
//
//   Activate Window fPesqSql

   // msginfo( nIdREt)

RETURN nIdRet

FUNCTION rTrans( cPar1 )

   LOCAL cRet := ''

   FOR nz := 1 TO Len( cPar1 )

      cLt := SubStr( cPar1, nz, 1 )

      IF ( cLt $ "0123456789." )
         cRet += cLt
      END IF

   NEXT

   // msginfo(' RTRans   ' + cRet )

RETURN Val( cRet )

FUNCTION GetTableId( cTabela, cValor )

   LOCAL cSql    := "select codigo from " + cTabela + " where descricao = '" + AllTrim(Hb_OemToAnsi( cValor) ) + "' and Status = 'Normal'"
   LOCAL oServ   := GetConexao()
   LOCAL oRow
   LOCAL nId := ''
   
   //hb_memowrit('tab1.txt' , csql )

   oQuery := oServ:Query( cSql )
   

   IF oQuery:LastRec() > 0
      oRow := oQuery:GetRow( 1 )
      nId := oRow:FieldGet( 1 )
   END IF

   oQuery:Destroy()
   oQuery := Nil

   oServ:Destroy( 0 )
   oServ := Nil

RETURN nId

FUNCTION GetId( cTabela, cValor )

   LOCAL cSql    := "select id from " + cTabela + " where descricao = '" + AllTrim(Hb_OemToAnsi( cValor) ) + "' and Status = 'Ativo'"
   LOCAL oServ   := GetConexao()
   LOCAL oRow
   LOCAL nId := ''
   
   //hb_memowrit('tab1.txt' , csql )

   oQuery := oServ:Query( cSql )
   

   IF oQuery:LastRec() > 0
      oRow := oQuery:GetRow( 1 )
      nId := oRow:FieldGet( 1 )
   END IF

   oQuery:Destroy()
   oQuery := Nil

   oServ:Destroy( 0 )
   oServ := Nil

RETURN nId

FUNCTION GetIdValor( cTabela, nId )

   LOCAL cSql    := "select descricao from " + cTabela + " where id = " + AllTrim( Str(  nId ) ) + " and Status = 'Ativo'"
   LOCAL oServ   := GetConexao()
   LOCAL oRow

   // Local nId := 0
   LOCAL cDesc := ''
   LOCAL oQuery

   oQuery := oServ:Query( cSql )

   IF oQuery:LastRec() > 0
      oRow := oQuery:GetRow( 1 )
      cDesc := oRow:FieldGet( 1 )
   END IF

   oQuery:Destroy()
   oQuery := Nil

   oServ:Destroy( 0 )
   oServ := Nil

RETURN cDesc


PROCEDURE Grayness_effect_start(  cJanela  )    
   
   Local n1 := 100
   Local n2 := 50   
   
   
   Local Ywidth := 0
   Local YHeight := 0
   
   
   If _isWindowDefined(cJanela)
       Ywidth := GetProperty(cJanela , "Width")
       YHeight := GetProperty(cJanela , "Height")      
   Else
      Return
   End If
   
   Default cJanela := ''
      
   lApaga := .t.    
   
   YHeight := nDeskTopHeight - 68
   hBitmapDes := 0   
   
 
   If cJanela = 'Main'   
   		hBitMain := BT_BitmapCaptureWindow (cJanela , 25 , 1 , yWidth, nDeskTopHeight)   
   		//msginfo( cJanela )
   Else
     // msginfo( cJanela )
   	  hBit2 := BT_BitmapCaptureWindow (cJanela , 0 , 0 , yWidth, nDeskTopHeight)   
   End If		
      
   lDrawMain := .f.
   
   If Alltrim(cJanela) == 'Main'
 		  DoMethod("fSplit6","Hide")   
   		DoMethod("fSplit2","Hide")
   		DoMethod("fSplit3","Hide")
   		DoMethod("fSplit4","Hide")
   		DoMethod("fSplit5","Hide")      
   		DoMethod("fSplit10","Hide")      
   		BT_BitmapSaveFile (hBitMain  , "hBit2.bmp")   
   		lDrawMain := .t.
   Else
      BT_BitmapSaveFile (hBit2  , "hBit2.bmp")   		
      hBitMain  := hBit2
   End If
   
   If _isWindowDefined( cFormPrin )     
      //msginfo('hide')     		   		
   		DoMethod(cFormPrin , "Hide" )
   		HideMain()      		
   End If		
   
   BT_ClientAreaInvalidateAll ('Main')
   
Return

Function HideMain()

 		DoMethod("fSplit6","Hide")      	
   	DoMethod("fSplit3","Hide")
   	DoMethod("fSplit4","Hide")
   	

Return

Function ShowMain()

 		DoMethod("fSplit6","Show")      	
   	DoMethod("fSplit3","Show")
   	DoMethod("fSplit4","Show")
   	

Return


PROCEDURE Grayness_effect_end(cJanela1)

   //Local hWnd := GetFormHandle( cJanela1 )
   
   Local n1 := 0
      
   //msginfo(cJanela1)
      
   lApaga := .f.      
   
   hBitmap := 0   
   hBitmap2 := 0 
   hBitmap3 := 0 
   hBitmap4 := 0 
   hBitmap5 := 0 
  
   
      
   hBitmap6 := 0 
      
   
   Flag_AlphaBlend_Effect := .f.
   
   BT_ClientAreaInvalidateAll ('Main') 
   
    hBitMain  := 0
      
 
   
   If (Alltrim(cActiveJan) == "Main")
		   DoMethod("fSplit6","Show")
		   DoMethod("fSplit2","Show")
		   DoMethod("fSplit10","Show")
		   DoMethod("fSplit3","Show")
		   DoMethod("fSplit4","Show")
		   DoMethod("fSplit5","Show") 
	 Else
	 
	    
	 
	     DoMethod("fSplit6","Show")
	     DoMethod("fSplit10","Show")
		   DoMethod("fSplit3","Show")
		   DoMethod("fSplit4","Show")
		   DoMethod("fSplit5","Show") 	   
		  
		   
		   If _isWindowDefined( cFormPrin )          		   		
   		     DoMethod(cFormPrin , "Show" )   		
   		 End If	
   
      // BT_ClientAreaInvalidateAll ('Main')
       BT_ClientAreaInvalidateAll ('fSplit2')
       BT_ClientAreaInvalidateAll ('fSplit5')
       BT_ClientAreaInvalidateAll ('fSplit10')   
	     	   
   End If
   	  
  
   
   lAtivaBlack := .f.
   
RETURN

Function GridFocus()

  If _IsControlDefined('G4343',cFormPrin)
    // msginfo('ok')
     
     SetProperty(cFormPrin ,'G4343','Value' , 2)
     
     _showwindow('Main')
     
     _showwindow(cFormPrin)
       Domethod(cFormPrin ,'G4343', 'SetFocus' )
       
      _HMG_PRINTER_SETVSCROLLVALUE( GetControlHandle(  'G4343', cFormPrin  )  , 5) 
     SysWait(.3)
       
      
       
       // msginfo('ok')
     
     //sSysWait(4)
     
  End If


return



function SetWindowControlsVisible(cForm , lVisible )

			Local aControlList := {}
			Local i := 0
			Local cCompo := ''
			
			For i := 1 to len(_HMG_SYSDATA[4])
			   If _HMG_SYSDATA[4,i] == GetFormHandle(cForm)
			      If len(alltrim(_HMG_SYSDATA [  2,i])) > 0
			      
			         
			         Setproperty( cForm , _HMG_SYSDATA [  2,i] , "Visible" , lVisible )			         
			         
			         If lVisible
			         		//DoMethod( cForm , _HMG_SYSDATA [  2,i] , "Show" )
			         End If		
			         
			         cCompo += (cForm + ' ' +  _HMG_SYSDATA [  2,i] )  + QUEBRA
			         
			      End If 
			   End If
			Next i
			
			hb_memowrit('compo1.txt' , cCompo)
			
Return aclone(aControlList)


Function MaxJanela()

	 Local cFormName := ''
	 Local cFname    := ''
   GetFormNameByHandle ( GetActiveWindow(), @cFormName )   
  
    
   If (Alltrim(cactivejan) != "Main") 
   
      If _isWindowDefined(cactivejan)
      
		      cFname := cactivejan
		             
		   		DoMethod(cFname    ,"Show") 
		   		DoMethod( cFname   ,"SetFocus")    		
		   		
		   		SysWait(.2)   
   		
   		End If
   		
   Else
   
   	   xMenuPrin()

   End If
   
   //DoMethod( cFormName ,"Show") 

Return 

Function RefreshAll(cForm)

			Local aControlList := {}
			Local i := 0
			//Local cform := 'fClien'
			Local cTxt1 := ''
			Local nHan := 0
			
			
			If (Empty(cForm)) .or. (cForm == Nil)
			   Return 
			End If
		 
			
			For i := 1 to len(_HMG_SYSDATA[4])
			   If _HMG_SYSDATA[4,i] == GetFormHandle(cForm)
			      If len(alltrim(_HMG_SYSDATA [  2,i])) > 0			           
			           nHan := GetControlHandle(_HMG_SYSDATA [  2,i]   , cForm)
			           if nHan != 0
			          	  cTxt1 += ( Procname(1) + ' ' + cForm +  ' ' +  _HMG_SYSDATA [  2,i]  + Chr(13)+Chr(10) )						          	  
			           		PostMessage( nHan   , WM_MOUSELEAVE , 0, 0)			 
			           		//SysWait(.1)   
			           End If			
			      End If 
			   End If
			Next i
			
			//SysWait(3)   
		
			//SaveLog( 'Janelas2.txt', cTxt1)			
			
			
Return Nil


Function ScrTestx()

   Local hNandle := GetFormHandle( 'fSplitSubMenu' )

  msginfo('p2')
  
   SetScrollPos ( hNandle, SB_VERT, 0, .T. )
   SendMessage  ( hNandle, WM_VSCROLL, SB_LINEUP, 0 )
   
   Do Events
  

Return


**********************************************************************
Function GetControls( cForm )
Local hWnd := GetFormHandle( cForm )
Local aControls := {}		//List of controls {ControlType, ControlName}
AEVAL( _HMG_SYSDATA[ 4 ], { | hCtrWnd, nPos | IF( hCtrWnd == hWnd, AADD( aControls , { _HMG_SYSDATA[ 1, nPos ], _HMG_SYSDATA[ 2, nPos ] }), Nil ) } )

MsgDebug( 'List of controls', aControls)

Return aControls


Function SysWait(nWait)

Local iTime := Seconds()
   Local ntim := 0

	DEFAULT nWait := .1

	Do While Seconds() - iTime < nWait
	  ntim++
		DO EVENTS
		//SaveLog( 'Syswait.txt' ,  " SysWait " + Str(nTim) )
	EndDo

Return


FUNCTION ReleaseButton(cForm, nID)
  
  IF OBTN_Handle(cForm, nID) == 0
    MsgBox("Button does not exist!")
  ELSE
    OBTN_Release(cForm, nID)
  ENDIF

RETURN NIL




PROCEDURE GRID_SetBkImage (cControlName, cParentForm, nAction, cBMPFileName, yOffset, xOffset)
   IF Valtype (cParentForm) == "U"
      cParentForm := ThisWindow.Name
   ENDIF	
   // LISTVIEW_SETBKIMAGE and BMP_LOAD_FILE are Low-level functions in C (see the end of this file)
   LISTVIEW_SETBKIMAGE (GetControlHandle (cControlName, cParentForm), BMP_LOAD_FILE (cBMPFileName), xOffset, yOffset, nAction)    
    
RETURN

#pragma begindump

#include <shlobj.h>   
#include <winuser.h>
#include <windows.h>
#include "hbapi.h"


#define BMP_ERASE        0
#define BMP_COPY_NORMAL  1
#define BMP_COPY_SCALE   2
#define BMP_COPY_STRETCH 3

//*************************************************************************************************
// BMP_LOAD_FILE (cFileBMP)
//*************************************************************************************************
HB_FUNC (BMP_LOAD_FILE)
{   
   HBITMAP hBitmap;    
   char *cFileName;

   cFileName = (char *) hb_parcx (1);
    
   hBitmap = (HBITMAP)LoadImage(NULL, cFileName, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE | LR_CREATEDIBSECTION);
          
   if (hBitmap == NULL)
       hBitmap = (HBITMAP)LoadImage(GetModuleHandle(NULL), cFileName, IMAGE_BITMAP, 0, 0, LR_CREATEDIBSECTION);
                          
   hb_retnl( (LONG) hBitmap );      
}

//*************************************************************************************************
// BMP_RELEASE_HANDLE (hBitmap)
//*************************************************************************************************


#pragma enddump





