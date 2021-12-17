#include <hmg.ch>


Function xCadCli()

   cDiaName := 'fCadCli'

   Private aUf      := {}
   Private aCidades := {}
   Private aBairros := {}

   Private lNovo := .t.

   Load Window fCadCli

   HMG_ChangeWindowStyle( fCadCli.Handle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )



   Center Window fCadCli

   Activate Window fCadCli

   cDiaName := 'fDialogo'

REturn



Function xInitCad()

   Local cJanx := 'fCadCli'

   aRotHnd := {}

   // SetWaitCursor( fCadCli.Handle )

   // SetWaitCursor( GetControlHandle( 'br_grid' , cFormPrin )  )


   // SetWaitCursor(GetControlHandle( 'imgLupa' , cJanx ) )



// HMG_ChangeWindowStyle( fCadCli.Handle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )

   Aadd( aRotHnd, { 53, {|| GrvClien( lNovo ) }, 'fCadCli' } )
   Aadd( aRotHnd, { 54, {|| fCadCli.Release }, 'fCadCli' } )


   EncheCmb( 'fCadcli', 'CmbCidade', "select municipio from ibge where uf = 'AL' order by 1" )
   EncheCmb( 'fCadcli', 'CmbCidEnt', "select municipio from ibge where uf = 'AL' order by 1" )


   EncheCmb( 'fCadcli', 'CmbClasse', "select descricao from classes where status = 'Normal' order by 1" )
   EncheCmb( 'fCadcli', 'CmbCategoria', "select descricao from categorias where status = 'Normal' order by 1" )

   EncheCmb( 'fCadcli', 'CmbUf', "select distinct uf from ibge order by 1" )

   SetProperty( 'fCadcli', 'CmbUf', 'Value', 2 )


   SetProperty( "fCadCli", "Label_3", "Value", Hb_AnsiToOem( "Endereço" ) )
   SetProperty( "fCadCli", "Label_15", "Value", Hb_AnsiToOem( "Endereço" ) )
   SetProperty( "fCadCli", "Label_2", "Value", Hb_AnsiToOem( "Nome\Razão Social" ) )


   SetProperty( "fCadCli", "Label_28", "Value", Hb_AnsiToOem( "Ult.Atualização Cliente" ) )

   SetProperty( "fCadCli", "Frame_6", "Caption", Hb_AnsiToOem( "Observação" ) )
   SetProperty( "fCadCli", "Frame_5", "Caption", Hb_AnsiToOem( "Informações Cliente" ) )

   OBTN_Create( cJanx, 53, "Ok", 420, 670,  62,  24,  .T., .T., .T.,  8, RetColor1( 1 ), aBtnFont )
   OBTN_Create( cJanx, 54, "Cancelar", 420, 735,  62,  24,  .T., .T., .T.,  8, RetColor1( 1 ), aBtnFont )

   OBTN_Font( cJanx, 53,  { cFontName, nFontSize, .F., .F., .F., .F. } )
   OBTN_Font( cJanx, 54,  { cFontName, nFontSize, .F., .F., .F., .F. } )

   OBTN_Enable( cJanx, 53, .f. )


   EventProcessAllHookMessage( EventCreate( {|| InputEv2(cJanx ) },    OBTN_Handle( cJanx, 53 )   ), .T. )
   EventProcessAllHookMessage( EventCreate( {|| InputEv2(cJanx ) },    OBTN_Handle( cJanx, 54 )   ), .T. )

   EventProcessAllHookMessage( EventCreate( {|| InpCadCli() },    GetControlHandle( 'imgLupa', cJanx )   ), .T. )
   EventProcessAllHookMessage( EventCreate( {|| InpCadCli() },    GetControlHandle( 'imgEnd', cJanx )   ), .T. )


   Do Events

// SetArrowCursor( fCadCli.Handle )



   ON KEY ESCAPE OF fCadCli Action ( SysWait( .1 ), fCadCli.Release, fCadCli := Nil )

Return

Static Function ShowButConsul( lVisible )

   Local cForm := 'fCadCli'

   // ShowBut( cForm , 6598 )

   // DoMethod(cForm , 'Show' )
   // syswait(.3)

   // OBTN_Visible( cForm  , 53 , .t.)
   // OBTN_Visible( cForm ,  54,  lVisible)
   // OBTN_Visible( cForm ,  6597 ,  lVisible)
   // OBTN_Visible( cForm ,  6598 ,  lVisible)
   // OBTN_Visible( cForm ,  6599 ,  lVisible)

   // syswait(.3)
   // SysWait(.3)

   // DoMethod(cForm , 'Show' )

return



Function GrvClien( lNovo )

   Local cSqlinsert
   Local cCodClasse := GetTableId( 'Classes', fCadCli .CmbClasse. DisplayValue )
   Local cCodCateg  := GetTableId( 'Categorias', fCadCli .CmbCategoria. DisplayValue )
   Local nId        := GetReg( "Clientes" )
   Local cCodMun    := ''

   If ( lNovo )

      IF !Confirmaviso( 'Confirma Cadastro desse Cliente?', cActiveJan,  , {| a | ShowButConsul( a ) } )

         DoMethod( 'fCadCli', 'SetFocus' )
         SysWait( .2 )

         PostMessage( OBTN_Handle(  'fCadCli', 53 ), WM_MOUSELEAVE, 0, 0 )
         PostMessage( OBTN_Handle(  'fCadCli', 54 ), WM_MOUSELEAVE, 0, 0 )

         Return .f.

      End If


      cSqlInsert := "INSERT INTO clientes(codigo,nome,cpf,endereco,bairro,fantasia,contato,tipo,fone1,fone2,whatzap,email,cidade,uf,rg,datanasc,"
      cSqlInsert += "cep,referencia,status,dtcadastro,observacao,ie,classe,categoria,endent,baient,cident,RefEnt,cepEnt) VALUES ('" + AllTrim( StrZero( nId + 1, 6 ) ) + "'," + ;
         Chr( 39 ) + AllTrim( Upper( fCadCli .nome. value ) ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .CnPj. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .endereco. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .cmbbairros. Displayvalue ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .fantasia. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .contato. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + iif( fCadCli .CmbTipo. value = 1, 'F', 'J' ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .Telefone. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .foneCon. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .WhatsAp. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .email. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .cmbcidade. Displayvalue ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .cmbUf. DisplayValue ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .rg. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( ConvDt( fCadCli .DataNasc. value ) ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fTiraChar( fCadCli .cep. value ) ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .referencia. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + 'Normal' + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( ConvDt( dDataBase ) ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .EdtObs. value ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( fCadCli .InEst. value ) + Chr( 39 )  + "," + ;
         Chr( 39 ) + AllTrim( cCodClasse ) + Chr( 39 ) + "," + ;
         Chr( 39 ) + AllTrim( cCodCateg ) + Chr( 39 ) +  "," + ;
         chr( 39 ) + AllTrim( fCadCli .EndEnt. value ) + Chr( 39 ) + "," + ;
         chr( 39 ) + AllTrim( fCadCli .CmbBaiEnt. Displayvalue ) + Chr( 39 ) + "," + ;
         chr( 39 ) + AllTrim( fCadCli .CmbCidEnt. Displayvalue ) + Chr( 39 ) + "," + ;
         chr( 39 ) + AllTrim( fCadCli .RefEnt. value ) + Chr( 39 ) + "," + ;
         chr( 39 ) + AllTrim( fTiraChar( fCadCli .CepEnt. value ) ) + Chr( 39 ) + ")"

      hb_MemoWrit( 'InsCli.txt', cSqlInsert )

      oServer := GetConexao()
      oQuery := oServer:Query( cSqlInsert )

      IF oQuery:NetErr()

         yAviso( 'Erro ao Executar Atualização -> ' + Chr( 13 ) + Chr( 10 ) + oQuery:Error() )
         RETURN
      END IF

      oServer:Destroy()
      oServer := Nil

      oQuery:Destroy()
      oQuery := Nil

// SysWait(.1)
      _FechaJan(  'fCadCli' )

// sWait(.1)//

      yAviso( 'Cliente Cadastrado com Sucesso!' )

      AtuNewLine( 'clientes', "Codigo = '" + StrZero( nId + 1, 6 ) + "'", cFormPrin )
// DoMethod("fCadCli","Release")


   Else


   End If

Return

FUNCTION AtuNewLine( cTb, Condicao, cJan, cSql1 )

   LOCAL cSqx1
   LOCAL a1    := GetProperty( cJan, "br_grid", "Value" )
   LOCAL nCol
   LOCAL aRec
   LOCAL aIt1  := GetProperty( cJan, "br_Grid", "Item", 1 )
   LOCAL nCount

   LOCAL cTipo
   LOCAL cMask
   LOCAL nZ
   LOCAL n1 := 1

   DoMethod( cJan, "Br_Grid", "Additem", aIt1 )
   nCount  := GetProperty( cJan, "br_Grid", "ItemCount" )

   // msginfo( Str(nCount) )

   cSqx1 := GetSql( ctb, .F. )
   cSqx1 += " Where  " + Condicao
   // idcliente = " +  Alltrim(nIdCli)

   IF cSql1 != Nil
      cSqx1 := cSql1
   END IF


   hb_MemoWrit( 'l1.txt', cSqx1 )

   aRec := RetRecord(  cSqx1, cTb )

   nCol := 1

   FOR nz := 1 TO Len( aRec )

      SetProperty( cJan, "br_Grid", "Cell", nCount, nCol, aRec[ nz ]   )
      nCol++

   NEXT

   SetProperty( cJan, "br_Grid", "Value", nCount    )

   DoMethod( cJan, "Br_Grid", "SetFocus" )
   DoMethod( cJan, "br_GRid", "Refresh" )

RETURN

FUNCTION RetRecord( cSql1, cTabela )

   LOCAL oServer := GetConexao()
   LOCAL oQuery  := oServer:Query( cSql1 )
   LOCAL nQreg1  := 0
   LOCAL aM1     := {}
   LOCAL nlinha  := 0
   LOCAL aM5 := {}
   LOCAL aCabec := GetCamposInf( cTabela, 'CABEC' )
   LOCAL cMask := ''

   cInativ := ''

   IF oQuery:LastRec() > 0

      FOR n1 := 1 TO oQuery:LastRec()

         oRow := oQuery:GetRow( n1 )
         aM1 := {}

         FOR nz := 1 TO Len( aCabec )

            cTipo := GetInfoDic( aCabec[ nz ], cTabela, 'TIPO' )
            cMask := GetInfoDic( aCabec[ nz ], cTabela, 'MASCARA' )

            IF cTipo == 'I'
               AAdd( aM1,  Padl( AllTrim( Str(oRow:FieldGet(nz ) ) ), 25 )    )
            END IF

            IF ( cTipo == 'C' ) .or. ( cTipo == 'D'  )
               AAdd( aM1, AllTrim( oRow:FieldGet(nz ) )  )
            END IF

            If cTipo == 'B'
               AAdd( aM1,   PadL( alltrim(Transform( oRow:FieldGet(nz ), "@E 999,999,999.99" ) ),14 ) )
            End If

         Next

         oQuery:Skip( 1 )
         // ProcessMessages()

      Next

      nQreg1 := oQuery:LastRec()

   ELSE

   END IF

   oQuery:Destroy()
   oQuery := Nil

   oServer:Destroy()
   oServer := Nil

   Do Events

RETURN aM1




FUNCTION InpCadCli()

   STATIC lTracking45 := .F.

   LOCAL  nHWnd   := EventHWND()
   LOCAL  nMsg    := EventMSG()
   LOCAL  nWParam := EventWPARAM()
   LOCAL  nLParam := EventLPARAM()
   Local cControl
   Local cForm

   IF ( nMsg == WM_MOUSEMOVE ) .and. ( !lTracking45 )

      lTracking45 := TrackMouseEvent( nHWnd ) // TME_LEAVE is default flag
      GetControlNameByHandle( nHWnd, @cControl, @cForm )
      // msginfo(cControl)

      If ( cControl = 'ImgLupa' ) .Or. ( cControl = 'ImgEnd' )
         _SetToolTip( cControl, 'fCadCli', hb_AnsiToOem( "Resgata Endereço Baseado no CEP Informado." ) )
         // SetHandCursor(GetControlHandle( cControl , 'fCadCli' )   , "Finger.cur" )
      End If

   END IF

   IF ( nMsg == WM_MOUSELEAVE )


      lTracking45 := .F.

   END IF

   If ( nMsg == WM_LBUTTONDOWN )

      GetControlNameByHandle( nHWnd, @cControl, @cForm )

      If cControl = 'ImgLupa'
         xPesqCep()
      End If

      If cControl = 'ImgEnd'
         xPesqEnt()
      End If

   End If

Return

Function GetCmbItens( cForm1, cCmb  )

   Local nCount := Getproperty( cForm1, cCmb, 'ItemCount' )
   Local aM2    := {}
   Local nZ1

   For nz1 := 1 To ncount
      Aadd( aM2, Alltrim( Getproperty( cForm1, cCmb, 'Item', nZ1 ) ) )
   Next

REturn aM2

Function EncheCmb( cForm1, cCmb, cSqlx1 )

   Local oServer := GetConexao()
   Local oQry

   DoMethod( cForm1, cCmb, 'DeleteAllItems' )

   oQry := oServer:Query( cSqlx1 )

   For n1 := 1 to oQry:LastRec()

      oRow := oQry:GetRow( n1 )

      DoMethod( cForm1, cCmb, 'AddItem', GetCampo(  oRow, oQry:FieldName(1 )  )     )

   Next

   oServer:Destroy()
   oSErver := Nil

   oQry:Destroy()
   oQry := Nil

Return


Function xChgUf()

   Local cUf1 := fCadcli .cmbUf. DisplayValue

   If !Empty( cUf1 )

      sysWait( .1 )


      DoMethod( 'fCadcli', 'CmbBairros', 'DeleteAllItems' )
      DoMethod( 'fCadcli', 'CmbBaiEnt', 'DeleteAllItems' )

      EncheCmb( 'fCadcli', 'CmbCidade', "select municipio from ibge where uf = '" + cUf1  + "' order by 1" )
      EncheCmb( 'fCadcli', 'CmbCidEnt', "select municipio from ibge where uf = '" + cUf1  + "' order by 1" )

   End If

return

Function xPesqCep()

   Local cCep := fTiraChar( GetProperty( 'fCadCli','Cep','Value' ) )

   Local oServer := GetConexao()
   Local oQry

   Local aM1
   Local oRow
   Local nCidade

   Local cJanx := 'fCadCli'

   // SetWaitCursor(GetControlHandle( 'imgLupa' , cJanx ) )

   oQry := oServer:Query( "select * from cep where cep = '" + cCep + "'" )


   If oQry:LastRec() > 0

      oRow := oQry:GetRow( 1 )

      aM1 := GetCmbItens( 'fCadCli', 'CmbUf'  )
      SetProperty( 'fCadCli', 'CmbUf', 'Value', Ascan( aM1, GetCampo(oRow, 'Uf' ) )  )

      xChgUf()

      aM1 := GetCmbItens( 'fCadCli', 'CmbCidade'  )

      nCidade := Ascan( aM1, alltrim( GetCampo(oRow, 'Cidade' ) ) )

      // msginfo(  Str(Len(aM1)) + ' ' +  ' ' + Str(nCidade)  )

      SetProperty( 'fCadCli', 'CmbCidade', 'Value',  nCidade )

      SetProperty( 'fCadCli', 'Endereco', 'Value', Alltrim( GetCampo(oRow, 'Endereco' ) ) )



      SetProperty( 'fCadCli', 'CmbBairros', 'Value', Ascan( GetCmbItens( 'fCadCli', 'CmbBairros'  ), Alltrim(GetCampo(oRow, 'Bairro' ) ) )  )


   Else

      SetProperty( 'fCadCli', 'Endereco', 'Value', '' )
      yAviso( 'Cep não Localizado.', .f. )

   End If



   oServer:Destroy()
   oSErver := Nil

   oQry:Destroy()
   oQry := Nil

Return


Function xChgCidade()

   Local cCid := Alltrim( fCadcli .cmbCidade. DisplayValue )
   Local cUf1 := fCadcli .cmbUf. DisplayValue

   If !Empty( cCid )

// SetHandCursor( fCadCli.Handle )
// DoMethod( 'fCadcli' , 'CmbBairros'  , 'DeleteAllItems' )
      EncheCmb( 'fCadcli', 'CmbBairros', "select  bairro from bairros where uf = '" + cUf1  + "' and cidade = '"  + cCid + "' order by 1" )
      EncheCmb( 'fCadcli', 'CmbBaiEnt', "select  bairro from bairros where uf = '" + cUf1  + "' and cidade = '"  + cCid + "' order by 1" )
// EncheCmb( 'fCadcli' , 'CmbBaEnt' , "select municipio from ibge where uf = 'AL' order by 1" )


   End If

Return



Function xCidEnt()

   Local cUf1 := fCadcli .cmbUf. DisplayValue
   Local cCid := fCadcli .cmbCidEnt. DisplayValue

   EncheCmb( 'fCadcli', 'CmbBaiEnt', "select  bairro from bairros where uf = '" + cUf1  + "' and cidade = '"  + cCid + "' order by 1" )

REturn

Function xGrvCli()

   If !ConfirmAviso( 'Confirma Cadastro desse Cliente?' )
      Return
   End If

Return


Function HabilGrv()

   Local cJanx  := 'fCadCli'
   Local lCpfOk := .f.

   If Len( Alltrim( fCadCli .Cnpj. Value ) ) = 11
      lCpfOk := Validcpf(  Alltrim( fCadCli .Cnpj. Value )  )
   Else
      lCpfOk := ValidCnPj(  Alltrim( fCadCli .Cnpj. Value )  )
   End If

   If ( Len( Alltrim(fCadCli .Nome. Value ) ) > 0 ) .And. (  Len( Alltrim(fCadCli .Cnpj. Value ) ) > 0  ) .And. ;
         ( Len( Alltrim(fCadCli .Endereco. Value ) ) > 0 ) .And. ( lCpfOk )
      OBTN_Enable( cJanx, 53, .t. )
   Else
      OBTN_Enable( cJanx, 53, .f. )
   End If

REturn

FUNCTION Validcpf()

   PARAMETER c_ic
   LOCAL d_1, d_2, x_x, con_ta, digito, res_to

   d_1 := 0
   d_2 := 0
   x_x := 1

   FOR con_ta := 1 TO Len( c_ic ) - 2
      IF At( subs( c_ic,con_ta,1 ), "/-." ) == 0
         d_1 := d_1 + ( 11 - x_x ) * Val( SubStr( c_ic,con_ta,1 ) )
         d_2 := d_2 + ( 12 - x_x ) * Val( SubStr( c_ic,con_ta,1 ) )
         x_x := x_x + 1
      END IF
   NEXT

   res_to  := d_1 - ( Int( d_1 / 11 ) * 11 )
   dig_ito := iif( res_to < 2, 0, 11 - res_to )
   d_2     := d_2 + 2 * dig_ito
   res_to  := d_2 - ( Int( d_2 / 11 ) * 11 )
   dig_ito := Val( Str( dig_ito,1 ) + Str( iif(res_to < 2,0,11 - res_to ),1 ) )

   IF dig_ito <> Val( SubStr( c_ic,Len(c_ic ) - 1,2 ) )
      RETURN .F.
   ELSE
      RETURN .T.
   END IF

RETURN


FUNCTION ValidCnpj()

   PARAMETER c_gc

   LOCAL d_1, d_4, x_x, con_ta, dig_ito, res_to

   d_1  := 0
   d_4  := 0
   x_x  := 1

   FOR con_ta := 1 TO Len( c_gc ) - 2
      IF At( subs( c_gc,con_ta,1 ), "/-." ) = 0
         d_1 := d_1 + Val( SubStr( c_gc,con_ta,1 ) ) * ( iif( x_x < 5,6,14 ) - x_x )
         d_4 := d_4 + Val( SubStr( c_gc,con_ta,1 ) ) * ( iif( x_x < 6,7,15 ) - x_x )
         x_x := x_x + 1
      END IF
   NEXT

   res_to  := d_1 - ( Int( d_1 / 11 ) * 11 )
   dig_ito := iif( res_to < 2, 0, 11 - res_to )
   d_4     := d_4 + 2 * dig_ito
   res_to  := d_4 - ( Int( d_4 / 11 ) * 11 )
   dig_ito := Val( Str( dig_ito,1 ) + Str( iif(res_to < 2, 0, 11 - res_to ),1 ) )

   IF dig_ito <> Val( SubStr( c_gc,Len(c_gc ) - 1,2 ) )
      RETURN .F.
   ELSE
      RETURN .T.
   ENDIF

RETURN




Function xPesqEnt()

   Local cCep := fTiraChar( GetProperty( 'fCadCli','CepEnt','Value' ) )

   Local oServer := GetConexao()
   Local oQry

   Local aM1
   Local oRow
   Local nCidade

   Local cJanx := 'fCadCl'

   oQry := oServer:Query( "select * from cep where cep = '" + cCep + "'" )


   If oQry:LastRec() > 0

      oRow := oQry:GetRow( 1 )

      // aM1 := GetCmbItens( 'fCadCli' , 'CmbUfEnt'  )
      // SetProperty( 'fCadCli','CmbUfEnt','Value' , Ascan(aM1 , GetCampo(oRow , 'Uf') )  )

      // xChgUf()

      aM1 := GetCmbItens( 'fCadCli', 'CmbCidEnt'  )

      nCidade := Ascan( aM1, alltrim( GetCampo(oRow, 'Cidade' ) ) )

      // msginfo(  Str(Len(aM1)) + ' ' +  ' ' + Str(nCidade)  )

      SetProperty( 'fCadCli', 'CmbCidEnt', 'Value',  nCidade )

      SetProperty( 'fCadCli', 'EndEnt', 'Value', Alltrim( GetCampo(oRow, 'Endereco' ) ) )



      SetProperty( 'fCadCli', 'CmbBaiEnt', 'Value', Ascan( GetCmbItens( 'fCadCli', 'CmbBaiEnt'  ), Alltrim(GetCampo(oRow, 'Bairro' ) ) )  )


   Else

      SetProperty( 'fCadCli', 'EndEnt', 'Value', '' )

      yAviso( 'Cep não Localizado.', .f. )

   End If

   oServer:Destroy()
   oSErver := Nil

   oQry:Destroy()
   oQry := Nil

Return





FUNCTION fTiraChar( wCampo )

   // // Remover Caracteres Especiais (/,*)

   LOCAL lRet  := .T.
   LOCAL cStr1 := ''
   LOCAL i     := 1

   FOR i := 1 TO Len( wCampo )
      IF SubStr( wCampo, i, 1 ) == "'" .OR. SubStr( wCampo, i, 1 ) == ")" .OR. SubStr( wCampo, i, 1 ) == "(" .OR. SubStr( wCampo, i, 1 ) == "*" .OR. SubStr( wCampo, i, 1 ) == "/"  .OR. SubStr( wCampo, i, 1 ) == "\"  .OR. SubStr( wCampo, i, 1 ) == '%' .OR. SubStr( wCampo, i, 1 ) == "-"

      ELSE
         cStr1 += SubStr( wCampo, i, 1 )
      ENDIF
   NEXT i

RETURN cStr1
