/*
 * MINIGUI - Harbour Win32 GUI library
 *
 * InputWindowEx function
 * Copyright 2008 Jozef Rudnicki <j_rudnicki@wp.pl>
*/

//#include "minigui.ch"
#include "HMG.ch"
//*********************************************************************************
#define F_LWIDTH  1 // label width
#define F_CTYPE   2 // control type
#define F_CWIDTH  3 // control width
#define F_CHEIGHT 4 // control height
#define F_VALUE   5 // control value ( combobox, textbox numeric, editbox )


#define MAX_F     5

Function InputWindowEx( cTitle , aLabels , aValues , aFormats ,;
                        nRow , nCol, lCenterWindow, aButOKCancelCaptions, bCode , aRelx , bValid , aOperadores   , aTams1 )
*********************************************************************************
  local i, imax, nControlRow, cLabel, cControl, xFormat
  local nWidth, nHeight, nWinWidth, nWinHeight, nRowHeight:=28  //30
  
  LOCAL lBold      := .F.
  LOCAL lItalic    := .F.
  LOCAL lUnderline := .F.
  LOCAL lStrikeOut := .F.
  Local nColz := 0
  Local nY := 0

  //LOCAL nB1 := IDC_BTN_1
  //LOCAL nCol := 05

  memvar aResult
  private aResult:={}
  
  Private bBlockVld := bValid
  
  
  lCenterWindow := if( nRow = NIL .and. nCol = NIL, .t., .f. )
  default nRow := 0
  default nCol := 0
  default aButOKCancelCaptions := {}

  if Len( aButOKCancelCaptions ) = 0
    if Set ( _SET_LANGUAGE ) == 'ES'
      AAdd( aButOKCancelCaptions, 'Aceptar' )
      AAdd( aButOKCancelCaptions, 'Cancelar' )
    else
      AAdd( aButOKCancelCaptions, '&Ok' )
      AAdd( aButOKCancelCaptions, '&Cancel' )
    endif
  endif

  nWinWidth := 280
  nWinHeight := 0
  imax := Len ( aLabels )
  ASize(aResult,imax)
  FOR i:=1 TO imax
    IF valType ( aFormats[i] ) == 'A' .and. valType(aFormats[i,1])<>'C'
    //msginfo('lp2')
      // InputWindowEx new syntax defaults
      ASize(aFormats[i],MAX_F)
      default aFormats[i,F_LWIDTH]  :=  90  // default nLabelWidth
      default aFormats[i,F_CWIDTH]  := 140  // default nControlWidth
      if aFormats[i,F_CHEIGHT]==nil         // default nControlHeight
        aFormats[i,F_CHEIGHT]:=nRowHeight
        if empty(aFormats[i,F_CTYPE])       // label -> empty string or nil
        elseif aFormats[i,F_CTYPE]='EB'
          aFormats[i,F_CHEIGHT]:=3*nRowHeight
        endif
      endif
    ELSE
      // InputWindow syntax convertion
      xFormat:=aFormats[i]
      //msginfo('lp')
      do case
      case aValues[i] == nil                        // Label only
        aFormats[i]:={90,'',140,nRowHeight}
      case valType ( aValues[i] ) == 'L'
        aFormats[i]:={90,'CH',140,nRowHeight}       // CheckBox
      case valType ( aValues[i] ) == 'D'
        aFormats[i]:={90,'DP',140,nRowHeight}       // DatePicker
      case valType ( aValues[i] ) == 'N'
        if valType ( xFormat ) == 'C'
          aFormats[i]:={90,'TN',140,nRowHeight}     // TextBox Numeric
        elseif valType ( xFormat ) == 'A'
          aFormats[i]:={90,'CB',140,nRowHeight}     // ComboBox
        endif
      case valType ( aValues[i] ) == 'C'
        aFormats[i]:={30,'TX',110,nRowHeight}       // TextBox aqui
        if valType ( xFormat ) == 'N'
          if xFormat > 32
            aFormats[i]:={90,'EB',140,3*nRowHeight} // EditBox
          endif
        endif
      case valType ( aValues[i] ) == 'M'
        aFormats[i]:={90,'EB',140,3*nRowHeight}     // EditBox
      endcase
      ASize(aFormats[i],MAX_F)
      aFormats[i,F_VALUE]:=xFormat
    ENDIF
    //nWinWidth:=max( aFormats[i,F_LWIDTH]+aFormats[i,F_CWIDTH], nWinWidth )
    nWinHeight+=aFormats[i,F_CHEIGHT]
  NEXT i

  nWinHeight += 3*nRowHeight  // place for ok/cancel buttons
  nWinWidth  += 30
  if nRow + nWinHeight > GetDeskTopHeight()
    nRow := GetDeskTopHeight() - nWinHeight
  endif
  
  nY := 0
  
  //Nome Fantasia  
  //Data Modificação Cadastro  
  For nx1 := 1 To imax
      
      If Len(  Alltrim(aLabels[nx1])   ) >= nY
         ny := Len(  Alltrim(aLabels[nx1])   )        
       End If  
         
  Next
  
 // msginfo(Str(ny))
 nWinWidth := 480
  
  If nY >= 26
     nY := 205
     nWinWidth := 545
    
    // msginfo('qui')
 Else  
      If nY >= 14
         nY := 165
         //nWinWidth := 270
      Else
          ny := 74   
      End If
 End If   
 
 aLinhas := {}

  DEFINE WINDOW _InputWindow ;
      AT nRow, nCol ;
      WIDTH nWinWidth+15 ;
      HEIGHT nWinHeight ;
      TITLE cTitle ;           
      NOMINIMIZE NOMAXIMIZE NOSIZE NOSYSMENU NOCAPTION ;       
      ON INIT InitIinput() ;
      ON PAINT Proc_Paint("Parametros Consulta")            

      nControlRow := 35
      
      FOR i:=1 TO imax
        cLabel   := 'Label_' + alltrim(str(i,2,0))
        cControl := 'Control_' + alltrim(str(i,2,0))
        
        cLblOper := 'Lbl__' + alltrim(str(i,2,0))
        
        If (Len(aOperadores) > 0) .and. (i > 1)
        
           //msginfo(alltrim(aOperadores[i - 1]))
           
           If !Empty(aOperadores[i - 1])
              @ nControlRow + 3 , 01 LABEL &cLblOper OF _InputWindow Value alltrim(aOperadores[i - 1]) WIDTH 16 HEIGHT 15 Font  'Arial' Size 9 BOLD FontColor {78,78,78}                        
           End If
           
        End If

        @ nControlRow + 2, 24 LABEL &cLabel OF _InputWindow ;
                          VALUE Hb_ansiToOem(Alltrim(aLabels[i])) HEIGHT 15 WIDTH aFormats[i,F_LWIDTH] Font 'Arial' Size 9 FontColor {78,78,78}
            
        If (Len(aOperadores) > 0)
            aadd( aLinhas , nControlRow + 25 )            
        End If                  
        
        If (nColz == 0)                  
            nColz := nY+25                 
        End If    
                          
        DO CASE
        CASE aValues[i] == nil
          IF valType(aFormats[i,F_VALUE])='C'
            if 'BOLD'$aFormats[i,F_VALUE]
              SetProperty('_InputWindow',cLabel,'FONTBOLD',.t.)
            endif
            if 'ITALIC'$aFormats[i,F_VALUE]
              SetProperty('_InputWindow',cLabel,'FONTITALIC',.t.)
            endif
            if 'UNDERLINE'$aFormats[i,F_VALUE]
              SetProperty('_InputWindow',cLabel,'FONTUNDERLINE',.t.)
            endif
            if 'STRIKEOUT'$aFormats[i,F_VALUE]
              SetProperty('_InputWindow',cLabel,'FONTSTRIKEOUT',.t.)
            endif
          ENDIF
          SetProperty('_InputWindow',cLabel,'WIDTH',aFormats[i,F_LWIDTH]+aFormats[i,F_CWIDTH])
        CASE aFormats[i,F_CTYPE] = 'CH'
          @ nControlRow, nColz CHECKBOX &cControl OF _InputWindow ;
                             CAPTION '' VALUE aValues[i]
        CASE aFormats[i,F_CTYPE] = 'DP'
          @ nControlRow, nColz DATEPICKER &cControl OF _InputWindow ;
                             VALUE aValues[i] WIDTH aFormats[i,F_CWIDTH] - 10
        CASE aFormats[i,F_CTYPE] = 'CB'
          @ nControlRow, nColz COMBOBOX &cControl OF _InputWindow ;
                             ITEMS aFormats[i,F_VALUE] ;
                             VALUE aValues[i] WIDTH aFormats[i,F_CWIDTH] ;
                             FONT 'Arial' SIZE 10
        CASE aFormats[i,F_CTYPE] = 'TN'
        
        //  msginfo('info')
          
          if at( '.' , aFormats[i,F_VALUE] ) > 0
            @ nControlRow,nColz TEXTBOX &cControl OF _InputWindow ;
                               VALUE aValues[i] WIDTH aFormats[i,F_CWIDTH] ;
                               FONT 'Arial' SIZE 10 ;
                               NUMERIC INPUTMASK aFormats[i,F_VALUE]
          else
          
            @ nControlRow, nColz TEXTBOX &cControl OF _InputWindow ;
                               VALUE aValues[i] WIDTH aFormats[i,F_CWIDTH] ;
                               FONT 'Arial' SIZE 10 ;
                               MAXLENGTH Len(aFormats[i,F_VALUE]) NUMERIC
                               
            If !Empty(aRelx[i])                   	
            
          		  cc1 := 'ButPesq' + StrZero(i,3)          		            		  
          		  
          		    @nControlRow+i,10+aFormats[i,F_LWIDTH] BUTTON &cc1 ;
                        CAPTION Upper(Left(aRelx[i],1)) + Right(aRelx[i], Len(aRelx[i]) - 1  ) ;
                        PICTURE "img\brw_lupa.bmp" LEFT ;
                        ACTION SetProperty("_InputWindow",cControl,"Value",  PesqSql(This.Caption) )  ;
                        WIDTH 110 ;
                        HEIGHT 22 ;
                        FONT "ms sans serif" ;
                        SIZE 8 ;
                        TOOLTIP "Realiza uma consulta ao cadastro de " + aRelx[i]  
                        
            End If               
                               
          endif
        CASE aFormats[i,F_CTYPE] = 'TX'
       
                @ nControlRow, nColz TEXTBOX &cControl OF _InputWindow ;
                            VALUE aValues[i] WIDTH aTams1[i] ;
                             FONT 'Arial' SIZE 10 Height 20;
                             MAXLENGTH aFormats[i,F_VALUE] 
                                                        
                             
                             
        CASE aFormats[i,F_CTYPE] = 'EB'
          if aFormats[i,F_CHEIGHT]>nRowHeight
            SetProperty('_InputWindow',cLabel,'HEIGHT',aFormats[i,F_CHEIGHT])
            @ nControlRow, 10+aFormats[i,F_LWIDTH] EDITBOX &cControl OF _InputWindow ;
                               WIDTH aFormats[i,F_CWIDTH] ;
                               HEIGHT aFormats[i,F_CHEIGHT] ;
                               VALUE aValues[i] ;
                               FONT 'Arial' SIZE 10
          else
            @ nControlRow, 10+aFormats[i,F_LWIDTH] EDITBOX &cControl OF _InputWindow ;
                               WIDTH aFormats[i,F_CWIDTH] ;
                               HEIGHT 20;                               
                               VALUE aValues[i] ;
                               FONT 'Arial' SIZE 10 ;
                               MAXLENGTH aFormats[i,F_VALUE]
                               
                               //HEIGHT aFormats[i,F_CHEIGHT] ;
          endif
        ENDCASE
        nControlRow := nControlRow + aFormats[i,F_CHEIGHT]
      NEXT i
      
      
      If imax == 1
      
      //  msginfo('ok')
        cControl := 'lblddf'
        @ nControlRow+20000,nColz TEXTBOX &cControl OF _InputWindow ;
                               VALUE 0 WIDTH 200 ;
                               FONT 'Arial' SIZE 10 ;
                              NUMERIC INPUTMASK '9999'
      
      End If
      
      i:=(nWinHeight-nControlRow-2*nRowHeight)/2
      
          
			   OBTN_Create( '_InputWindow' ,  6598, "Ok" , nControlRow+i+7 , nWinWidth - 175  ,  65 ,  24 ,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
			   OBTN_Font( '_InputWindow'   , 6598,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )
			   
 			   OBTN_Create( '_InputWindow' , 6599, "Cancelar" , nControlRow+i+7 , nWinWidth - 110  ,  65 ,  24 ,  .T., .T., .T.,  8, aBtnColor, aBtnFont )
			   OBTN_Font( '_InputWindow'   , 6599,  { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )			   
			   
			   aButx1 := {}
			   Aadd(aButx1 , {  6598 ,  OBTN_Handle( '_InputWindow'  , 6598 )    } )
			   Aadd(aButx1 , {  6599 ,  OBTN_Handle( '_InputWindow'  , 6599 )    } )
			   
			
			   EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1 , '_InputWindow'  ) },    OBTN_Handle( '_InputWindow'  , 6598 )   ), .T. )
			   EventProcessAllHookMessage( EventCreate( {|| InputEvButton( aButx1 , '_InputWindow' ) },    OBTN_Handle( '_InputWindow' , 6599 )   ), .T. )			   
			   
			   //InstallEventHandler( "EventInput" )
   
      if valType(bCode)='B'
        Eval(bCode)
      endif
      
  END WINDOW
  
  ON KEY ESCAPE OF _InputWindow ACTION _InputWindow.Release

  if lCenterWindow
    CENTER WINDOW _InputWindow
  endif
  
  
  ACTIVATE WINDOW _InputWindow 
  
RETURN ( aResult )

Function InputHndBut()



Return


FUNCTION EventInput( nHWnd, nMsg, nWParam, nLParam )

   LOCAL nID
   LOCAL ButHnd

   LOCAL nRow, nCol

   LOCAL nind1
   Local cWindow

   //IF !_IsWindowDefined ( cForm )
     // RETURN
   //END IF

   IF (!_IsWindowDefined ( '_InputWindow' )) .AND. ;
   (!_IsWindowDefined ( 'fEditTam' ) )  
      RETURN
   END IF
   
   If (_IsWindowDefined ( '_InputWindow' ))
      cWindow := '_InputWindow'
   End If
   
   If (_IsWindowDefined ( 'fEditTam' ))
      cWindow := 'fEditTam'
   End If
   //   
   //msginfo('ok22')

   IF (nHWnd == GetProperty( cWindow  , "HANDLE" )) 
      //.or. (nHWnd == GetProperty(  'fEditTam'   , "HANDLE" ))             
      
     // If nMsg == VK_TAB
      //   msginfo('tab')
     // End If     
      
       IF nMsg == WM_DRAWITEM
        
         IF (nWParam ==  6598) .or. (nWParam ==  6599) .or. ; 
            (nWParam ==  6798) .or. (nWParam ==  6799)
            OBTN_Draw( nHWnd,  nWParam , nLParam )
         END IF

      END IF

      IF nMsg == 273

         nID := LoWord( nWParam )

         IF nID == IDOK
            nID := GetDlgCtrlID( GetFocus() )
         ENDIF

         IF nId == 6598          
            //msginfo('ok2')
            xInputWindowOk()
         END IF
         
         IF nId == 6599          
            //msginfo('ok2')
            xInputWindowCancel()
         END IF
         
         IF nId == 6798         
             
             SaveCampo(  pCampo , pTabelax )
             lOkz := .t.
             //msginfo( pcampo + ' ' + pTabelax)             
            _ReleaseWindow('fEditTam')
            
         END IF
         
          IF nId == 6799          
            //msginfo('ok2')
            _ReleaseWindow('fEditTam')
         END IF

      END IF

   END IF
   
   

RETURN NIL

FUNCTION InputEvButton(aButs ,cJanela)

   STATIC lTracking := .F.

   LOCAL  nHWnd   := EventHWND()
   LOCAL  nMsg    := EventMSG()
   LOCAL  nWParam := EventWPARAM()
   LOCAL  nLParam := EventLPARAM()
   
   Local cFormx := cJanela

   LOCAL nind1
   LOCAL nIdBut := 0

   LOCAL n1

   LOCAL ButHnd

   nInd1 := AScan( aButs, {| a| a[ 1 ] == nWParam } )

   FOR n1 := 1 TO Len( aButs )

      IF ( OBTN_Handle( cJanela , aButs[ n1 ][ 1 ] ) == nHWnd )
         nIdBut := aButs[ n1 ][ 1 ]         
      END IF
      
   NEXT

   
   IF ( nIdBut > 0 )   
   
     
      If (nMsg == WM_KEYDOWN)
          //msginfo('aqui')
         IF nWParam == VK_TAB
             
           If OBTN_Focus('_InputWindow', 6598 )             
              SetFocus(GetDlgItem(GetFormHandle( '_InputWindow'), 6599))
           End If                           
         
         End If
         
         
      End If 
     
      IF ( nMsg == WM_MOUSEMOVE )

         lTracking := TrackMouseEvent( nHWnd ) // TME_LEAVE is default flag
         
         If nIdBut = 6599
             //msginfo('po')
            lOut := .f.
         End If

         OBTN_Color( cFormx, nIdBut, aBtnSel, .T. )
         OBTN_Enable( cFormx, nIdBut, .T. )
         OBTN_Visible( cFormx, nIdBut, .T. )

      END IF

      IF ( nMsg == WM_MOUSELEAVE )

         lOut := .t.
         OBTN_Color( cFormx,  nIdBut, aBtnColor, .T. )
         OBTN_Enable( cFormx, nIdBut, .T. )
         OBTN_Visible( cFormx, nIdBut, .T. )

         lTracking := .F.

      END IF
   ELSE

   END IF

RETURN
  
Static Function InitIinput()  
   
   HMG_ChangeWindowStyle( _InputWindow.Handle , WS_EX_DLGMODALFRAME, NIL, .T., .T. )   
   SendMessage( _InputWindow.Handle   , WM_PAINT , 0 , 0 )
   
REturn  

static Function xInputWindowOk()
********************************
  Local i , cControlName
  Local lOk := .t.
  //Local 
  memvar aResult
  
  lOk := Eval(bBlockVld)
  

  for i := 1 to len (aResult) 
    cControlName := 'Control_' + Alltrim ( Str ( i , 0 ) )
    if _IsControlDefined(cControlName,'_InputWindow')
      aResult[i] := _GetValue ( cControlName , '_InputWindow' )
    else
      aResult[i] := nil
    endif
  next i
  
  If lOk
  		RELEASE WINDOW _InputWindow
  Else
  
  End If		
  
  RETURN NIL

static Function xInputWindowCancel()
************************************
  Local i
  memvar aResult
  
  //msginfo('cace')

  for i := 1 to len (aResult)
    aResult[i] := nil
  next i
  
  RELEASE WINDOW _InputWindow
  
RETURN NIL
