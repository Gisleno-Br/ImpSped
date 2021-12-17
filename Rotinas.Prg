#include <hmg.ch>


Function AltTamCampo(cTabx,cCampo , cForm)

  Local cSql := "select * from dicionario where tabela = '" + cTabx + "' and camposistema = '" + Alltrim(hb_oemtoAnsi(cCampo)) + "'"
  
  Local oServer := GetConexao()
  Local oQuery  := oServer:Query( cSql )
  Local oRow
  
  LOCAL lBold      := .F.
  LOCAL lItalic    := .F.
  LOCAL lUnderline := .F.
  LOCAL lStrikeOut := .F.
  
  

  Private lOkz := .f.
  Private aButx1
  
  Private pCampo   := cCampo
  Private pTabelax := cTabx
  
  
  //saveLog('Sqlg.txt' , cSql )
  
  //msginfo(  cCampo + '  ' + cSql )
  
  If  (oQuery:LastRec() > 0)
      oRow := oQuery:GetRow(1)
      
      Load Window fEditTam
      
      SET NAVIGATION EXTENDED
      
      fEditTam.lblcampo.value := Alltrim(GetCampo(oRow , 'campo') )
      
      fEditTam.tamanho.value   := GetCampo(oRow , 'tamdisp')      
      fEditTam.cabecalho.value := Hb_AnsiToOem(GetCampo(oRow , 'camposistema'))
      
      fEditTam.mascara.value := GetCampo(oRow , 'mascara')
      
      fEditTam.chkBrowse.Value := GetCampo(oRow , 'browse') == 'S'      
      
      ON KEY ESCAPE Of fEditTam Action _ReleaseWindow('fEditTam')
      
      HMG_ChangeWindowStyle( fEditTam.Handle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )
      HMG_ChangeWindowStyle( fEditTam.Handle, WS_EX_STATICEDGE, NIL, .T., .T. )
      
      
      OBTN_Create( 'fEditTam' ,  6798, "Ok" , 135, 180  ,  65 ,  24 ,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
			OBTN_Font( 'fEditTam'   , 6798,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )
			   
 		  OBTN_Create( 'fEditTam' , 6799, "Cancelar" , 135 , 245  ,  65 ,  24 ,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
			OBTN_Font( 'fEditTam'   , 6799,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )			   
			   
			aButx1 := {}
			Aadd(aButx1 , {  6798 ,  OBTN_Handle( 'fEditTam'  , 6798 )    } )
			Aadd(aButx1 , {  6799 ,  OBTN_Handle( 'fEditTam'  , 6799 )    } )
			
			SetProperty( 'fEditTam' , "Label_5" ,"Value" ,  hb_AnsitoOem('Propriedades Visualização Campo') )
			   			
			EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1 , 'fEditTam'  ) },   OBTN_Handle( 'fEditTam' , 6798 )   ), .T. )
			EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1 , 'fEditTam') },     OBTN_Handle( 'fEditTam' , 6799 )   ), .T. )			  
			
			Obtn_Enable(  'fEditTam' ,  6798, .f. )			
			   
      
      Activate Window fEditTam            
                 
  
  Else
      yAviso('Campo/Tabela não localizado no Dicionario de Dados.')
      SetProperty(cForm  , 'Image_baixo' , 'Visible', .f. )
		  SetProperty(cForm  , 'Image_cima' , 'Visible', .f. )
     // msginfo(cForm)
      Refreshall(cForm)
  End If   
 
  //yaviso('ok')
  
  
  oQuery:Destroy()
  oQuery := Nil

  oServer:Destroy()
  oServer := Nil   
  
Return lOkz


Function SvTamCampo( cCampo1 , cTab1 , nTam1  )

		   Local oSErver
		   Local oQuery
 			 Local cSqlUp := "Update dicionario "
       cSqlUp += " Set tamdisp = " + Alltrim(Str(  nTam1 )) 
       cSqlUp += " where tabela = '" + cTab1 + "' and Camposistema = '" + Alltrim(hb_oemtoAnsi(cCampo1)) + "'"         
       
       oServer := GetConexao()
 			 oQuery := oServer:Query( cSqlUp)

		   IF oQuery:NetErr()
		      //CursorArrow()
		      MsgStop( 'Erro ao Executar Atualização -> ' + Chr( 13 ) + Chr( 10 ) + oQuery:Error() )
		      RETURN .f.
		   END IF
		
		   oServer:Destroy()
		   oServer := Nil
		
		   oQuery:Destroy()
		   oQuery := Nil

Return .t.


Function SaveCampo( cCampo1 , cTab1  )

		   Local oSErver
		   Local oQuery
 			 Local cSqlUp := "Update dicionario "
       cSqlUp += " Set tamdisp = " + Alltrim(Str(  fEditTam.tamanho.value  )) + ","
       cSqlUp += "camposistema = '" + Alltrim(Hb_AnsiToOem(fEditTam.cabecalho.value)) + "',"
       cSqlUp += "mascara = '" + Alltrim(fEditTam.mascara.value) + "',"
       cSqlUp += "browse = '" + Iif(fEditTam.chkBrowse.Value,"S","N") + "' "
       cSqlUp += " where tabela = '" + cTab1 + "' and Camposistema = '" + Alltrim(hb_oemtoAnsi(cCampo1)) + "'"         
       
       oServer := GetConexao()
 			 oQuery := oServer:Query( cSqlUp)

		   IF oQuery:NetErr()
		      //CursorArrow()
		      MsgStop( 'Erro ao Executar Atualização -> ' + Chr( 13 ) + Chr( 10 ) + oQuery:Error() )
		      RETURN .f.
		   END IF
		
		   oServer:Destroy()
		   oServer := Nil
		
		   oQuery:Destroy()
		   oQuery := Nil

Return .t.