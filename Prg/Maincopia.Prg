#include <hmg.ch>
#include <minigui.ch>

#define QUEBRA Chr(13)+Chr(10)


#define SB_HORZ 0
#define SB_VERT 1
#define SB_LEFT 6
#define SB_TOP 6
#define SB_LINEUP 0
#define SB_ENDSCROLL 8
#define WM_VSCROLL  0x0115
#define WM_HSCROLL 276

// #DEFINE SB_VERT 1
#define SB_BOTH 3





//#define NONE      0
#define BOX       2
#define PANEL     3

#define LABEL_NAME 1
#define LABEL_HWND 2

#define ARROWCURSOR          1  // The standard arrow cursor.
#define BUSYCURSOR           2  // An hourglass or watch cursor, usually shown during operations that allow the user to interact with the application while they are performed in the background.
#define POINTINGHANDCURSOR   3  // A pointing hand cursor that is typically used for clickable elements such as hyperlinks.
#define WAITCURSOR           4  // An hourglass or watch cursor, usually shown during operations that prevent the user from interacting with the application.

MEMVAR _HMG_SYSDATA


#define FONTCOR {0,106,133}

#define BACK1 {229,237,242}

#define BACK5 {202,218,230}

#define CORSEL {215,228,236}
//{180,205,220}
//{216,228,236}

#define FONT1 {102,102,102}


DECLARE WINDOW fSplit6

REQUEST HB_LANG_PT
REQUEST HB_CODEPAGE_PT850


FUNCTION Main()

	 Public cForm := ''

   PUBLIC aBackColor := { 57, 108, 164 }
   
   Public nVirtualMenu := Nil
   
   Public lAtivaBlack := .f.
   
   Public cJanx

   PUBLIC cBackColor := { 166, 210, 210 }

   //PUBLIC bColor := {|| iif( ( LastRec() > 0 ) .AND. ( RecNo() / 2 == Int(RecNo() / 2 ) ), { 159,207,255 }, { 255,255,255 } ) }
   
   PUBLIC bColor := {|| iif( ( LastRec() > 0 ) .AND. ( RecNo() / 2 == Int(RecNo() / 2 ) ), { 238,238,238 }, { 255,255,255 } ) }

   PUBLIC fColor := {|| iif( ( LastRec() > 0 ) .AND. ( AllTrim(Status ) == 'Ativo' ), { 78,78,78 },  { 255, 0, 0 } )  }

   PUBLIC bColorGrid := {|| iif( ( LastRec() > 0 ) .AND. ( RecNo() / 2 == Int(RecNo() / 2 ) ), { 222,222,222 }, { 255,255,255 } ) }

   PRIVATE nDEsk1 := 975
   
   Private aMtrPos := {}

   PUBLIC cRazaoEmp     := ''
   PUBLIC cFantadisEmp  := ''
   PUBLIC cEnderecoEmp  := ''
   
   Public lDrawMain := .f.
   
   PUBLIC  cServer := ''
   PUBLIC  cBanco  := ''
   PUBLIC cUserDb  := ''
   PUBLIC cPassDb  := ''   
   
   Public cUserName := 'Admin'


   PUBLIC cBairroEmp    := ''
   PUBLIC cCidadeEmp    := ''

   PUBLIC qTotReg       := 50

   PUBLIC nVirtual1     := 540
   
   Public nItemHeight := 16

   PUBLIC nIdEmp        := 1

   PUBLIC cSqlLog       := "c:\temp\Logs\Sqlx1_Log_" + DToS( Date() ) + ".Log"


	 SET LANGUAGE TO PORTUGUESE
	 
	 SET CODEPAGE TO PORTUGUESE
	 
   PUBLIC cUfEmp        := ''
   PUBLIC cResponEmp    := ''
   PUBLIC cCnpjEmp      := ''

   PUBLIC cTelEmp        := ''
   PUBLIC cDtExp         := ''
   PUBLIC cCepEmp        := ''
   
   Public Flag_AlphaBlend_Effect := .f.

   PUBLIC aEmpresa       := {}

   PUBLIC dDataBase      := Date()   
   
   Public nLevelMenu     := 1
   
   Public cActiveJan  := ''
   Public aJanelas    := {}
   
   Private cOpAberto := ""
   
   Private TxColorE  := Rgb( 255, 255, 255 )
   Private FrColorE  := Rgb( 9, 111, 137 )
   
   
   
    //{ 9, 111, 137 }

   Private BkColorE1 := Rgb( 9, 111, 137 )
   Private BkColorE2 := Rgb( 9, 111, 137 )
   
   Private lApaga := .f.
   
   Private hBitmapDes := 0
   
   Private hBit2      := 0
   
   Private hBit10      := 0
   Private hBit11      := 0

   Private GradDirE  := 0
   Private TxColorD  := 0x808080
   
   Private FrColorD  := Rgb( 232,232,232 )
   //{ 9, 111, 137 }
   
   Private BkColorD1 := 0XE0E0E0
   Private BkColorD2 := 0XE0E0E0
   Private GradDirD  := 0
   Private TxColorF  := Rgb( 45, 55, 56 )
   Private FrColorF  := FrColorE
   
   Private hBitmap := 0
   Private hBitmap2 := 0
   Private hBitmap3 := 0
   Private hBitmap4 := 0
   Private hBitmap5 := 0
      
   Private hBitmap25 := 0
   
   Private hBitmap6 := 0

   Private BkColorF1 :=  0xFFFFFF
   Private BkColorF2 :=  Rgb( 192, 192, 192 )

   Private GradDirF  := 0
   Private cFontName  := 'Arial'
   Private FontSize  := 8   
   
   Private lScrool := .t.

   Private aBtnFont  := { "Arial", 8, .F., .F., .F., .F. }
   
   Public aBtnCorSl := ;
      { { TxColorE, FrColorE, BkColorE1, BkColorE2, GradDirE }, { TxColorD, FrColorD, BkColorD1, BkColorD2, GradDirD }, { TxColorF, FrColorF, BkColorF1, BkColorF2,GradDirF } }

   Public aBtnSl := ;
      { { TxColorF, FrColorF, BkColorF1, BkColorF2, GradDirF }, { TxColorD, FrColorD, BkColorD1, BkColorD2, GradDirD }, { TxColorF, FrColorF, BkColorF1, BkColorF2,	GradDirF } }
      
   Public nDesktopHeight := GetDesktopHeight()
   
   Public nDesktopWidth := GetDesktopWidth()
   
   Public lMainJan := .t.
   
   
   
   
   SET DATE BRIT
   
   SET(_SET_DATEFORMAT,"DD/MM/YYYY")
   
   SET NAVIGATION EXTENDED   
   
   HB_LANGSELECT( 'PT' )
   
   HB_SetCodePage("PT850")
   
   Public cAviso1 :=  "Deseja Confirmar essa Operação?"
   //msginfo(hb_AnsiToOem(cv1))
   
   //MsgAviso(cv1)
   
   
   Set AutoScroll On

   Load Window Main

   Main.Center
   
   Main.Maximize()
   
   Load Window fSplitSubMenu
   
   
   Private aOpcoes := {{"Cadastros", Nil , 1 , 0  }, ;                   
                   {"Movimentos", Nil , 2  , 0  },;
                   {"Relatorios", Nil , 3 , 0    },;
                   {"Parametros", Nil , 4 , 0    } }                   
                   
   Private nOpSel := 1                
   
   Private aItens := { {"1-Clientes",Nil} , { "1-Fornecedores",Nil} , { "1-Vendedores", Nil } , {"1-Colaboradores",Nil} ,   {"1-Grupo Produtos",Nil} , ;
    {"1-Locais Estoque",Nil} , {"1-Funções",Nil} , ;
      {"1-Categoria Produto",Nil} , {"1-Unidades",Nil} , {"1-Tipo Produtos",Nil} , {"2-Pedidos",Nil} , {"2-Orçamento",Nil} }
      
   
                   
        
                   
   Private nRowIni := 10                   
    
        
    n := 1
    
                  
    While n <= Len(aOpcoes)    
    
        //msginfo( aOpcoes[n][LABEL_NAME] )
    
	      DEFINE LABEL &(aOpcoes[n][LABEL_NAME] )
	        PARENT    fSplit6
	        ROW       nRowIni
	        COL       19
	        WIDTH     fSplit6.Width       
	        FONTNAME  'Arial'
			    FONTSIZE  10
	        HEIGHT    16
	        VALUE     '  ' + Padr(Alltrim(aOpcoes[n][LABEL_NAME]) ,45)
	        ALIGNMENT Left
	        FONTCOLOR FONTCOR 
	        BACKCOLOR BACK1
	      END LABEL    	      
	      
	      //msginfo( aOpcoes[n][LABEL_NAME] )
	      aadd(aMtrPos  , nRowIni)
	      aOpcoes[n][4] := nRowIni
	      
	      nRowIni += 15
	      
	
	      aOpcoes[n][LABEL_HWND] := GetProperty("fSplit6", aOpcoes[n][LABEL_NAME] , "HANDLE")
	      
	      SetHandCursor( GetControlHandle(aOpcoes[n][LABEL_NAME] , "fSplit6"), "Finger.cur" )      
	
	      
	      EventProcessAllHookMessage(EventCreate({ || LabelEventHandler(aOpcoes) }, aOpcoes[n][LABEL_HWND]), .T.)	      
	      n++
      
    Enddo
    
    
    HMG_ChangeWindowStyle(fSplit6.Handle    , 0x00010200 , NIL, .F., .F.)
    HMG_ChangeWindowStyle( fSplit6.Handle  ,WS_EX_TOOLWINDOW  , NIL, .t., .t.)    
    
    
    HMG_ChangeWindowStyle( fSplit6.Handle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )
    HMG_ChangeWindowStyle( fSplit2.Handle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )
    HMG_ChangeWindowStyle( fSplit3.Handle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )
    HMG_ChangeWindowStyle( fSplit4.Handle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )    
    
    
        
            
    DEFINE LABEL fLabel1Dt
        PARENT    fSplit3
        ROW       18
        COL       51
        WIDTH     140        
        HEIGHT    16
        VALUE     Alltrim(Dtoc(dDataBase))
        ALIGNMENT LEft
        FONTCOLOR FONTCOR
        BACKCOLOR BACK1      
        FONTBOLD .f.
      END LABEL      
             
      DEFINE LABEL fLabelUser
        PARENT    fSplit4
        ROW       03
        COL       10
        WIDTH     140        
        HEIGHT    16
        VALUE     Alltrim(cUserName)
        ALIGNMENT Left
        FONTCOLOR FONTCOR
        BACKCOLOR BACK1      
        //TRANSPARENT .T.
        ACTION msginfo('ok')     
        FONTBOLD .f.
      END LABEL
      
      DEFINE LABEL fUserDb
        PARENT    fSplit4
        ROW       32
        COL       10
        WIDTH     140        
        HEIGHT    16
        VALUE     Alltrim(cUserDb)
        ALIGNMENT Left
        FONTCOLOR FONTCOR
        BACKCOLOR BACK1      
        ACTION msginfo('ok')     
        //TRANSPARENT .T.
        //FONTBOLD .t.
      END LABEL
      
      DEFINE LABEL fServerDb
        PARENT    fSplit4
        ROW       51
        COL       10
        WIDTH     140        
        HEIGHT    16
        VALUE     ""
        ALIGNMENT Left
        FONTCOLOR FONTCOR
        BACKCOLOR BACK1      
        TRANSPARENT .T.
        ACTION msginfo('ok')     
        //FONTBOLD .t.
      END LABEL
      
                    	
   Private aButTop := {} 
   aAdd( aButTop ,  { 31342 ,  "Menu Principal"	 , { || msginfo('ok') } } )  
   
   ButtonsTop()
   
   Main.Activate 

RETURN

Function CaptTelas()

    hBit10 := BT_BitmapCaptureWindow ('fSplit5' , 0 , 0 , fSplit5.Width , fSplit5.Height)       
    hBit11 := BT_BitmapCaptureWindow ('fSplit2' , 0 , 0 , fSplit2.Width , fSplit2.Height)   
    
    BT_BitmapSaveFile (hBit10  , "hBit10.bmp")  
    BT_BitmapSaveFile (hBit11  , "hBit11.bmp")  

Return

Function ButtonsTop()

  Local cMenuName := 'fSplit2'
  Local nCol := 15
  
  
  For n1 := 1 To Len(aButTop)
     OBTN_Create( cMenuName, aButTop[n1][1], aButTop[n1][2] ,  005, nCol ,  95 ,  20 ,  .T., .T., .T.,  0 , aBtnSl , aBtnFont )
     OBTN_Font( cMenuName, aButTop[n1][1],  { 'Arial',  9 ,  .t. , .f. ,  .f., .f. } )
     
     //{ cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut }

     EventProcessAllHookMessage( EventCreate( {|| EventTopButton() },    OBTN_Handle( cMenuName, aButTop[n1][1] )   ), .T. )   
     
     nCol += 60     
  Next  
  
  InstallEventHandler( "EventHndTop" )
   
Return   


Function LeaveBut(aAr1 , cJan)
  
  Local nHan
  Local n1

  For n1 := 1 To Len(aAr1)
      nHan :=  OBTN_Handle( cJan, aAr1[n1][1] )
      PostMessage( nHan , WM_MOUSELEAVE, 0, 0)     
  Next    

Return

FUNCTION EventHndTop( nHWnd, nMsg, nWParam, nLParam )

   LOCAL nID
   LOCAL ButHnd

   LOCAL nRow, nCol

   LOCAL nind1
   Local cMenuName := 'fSplit2'

   IF !_IsWindowDefined ( 'fSplit2' )
      RETURN
   END IF
   
   //

   IF nHWnd == GetProperty(  cMenuName, "HANDLE" )

      IF nMsg == WM_DRAWITEM
         
         ni1 := Ascan(aButTop , { |a|a[1] == nWParam } )
         
         If nI1 > 0
            OBTN_Draw( nHWnd, aButTop[ni1][1] , nLParam )
         END IF

      END IF

      IF nMsg == 273

         nID := LoWord( nWParam )

         IF nID == IDOK
            nID := GetDlgCtrlID( GetFocus() )
         ENDIF
         
         ni1 := Ascan(aButTop , { |a|a[1] == nId } )
         
         If nI1 > 0
            Eval(aButTop[ni1][3])         
         End If
         

      END IF

   END IF

   
RETURN NIL

Function  EventTopButton()

   STATIC lTracking := .F.

   LOCAL  nHWnd   := EventHWND()
   LOCAL  nMsg    := EventMSG()
   LOCAL  nWParam := EventWPARAM()
   LOCAL  nLParam := EventLPARAM()

   LOCAL nind1
   LOCAL nIdBut := 0

   LOCAL n1   
   Local cFormx := 'fSplit2'   
   LOCAL ButHnd
   

   FOR n1 := 1 TO Len( aButTop )

      IF ( OBTN_Handle( cFormx, aButTop[ n1 ][ 1 ] ) == nHWnd )
         nIdBut := aButTop[n1 ][ 1 ]
      END IF
      
   NEXT
   
   IF ( nIdBut > 0 )

      IF ( nMsg == WM_MOUSEMOVE )

         lTracking := TrackMouseEvent( nHWnd ) // TME_LEAVE is default flag

         OBTN_Color( cFormx, nIdBut,  aBtnSl , .T. )
         OBTN_Enable( cFormx, nIdBut, .T. )
         OBTN_Visible( cFormx, nIdBut, .T. )

      END IF

      IF ( nMsg == WM_MOUSELEAVE )

         OBTN_Color( cFormx,  nIdBut, aBtnCorSl , .T. )
         OBTN_Enable( cFormx, nIdBut, .T. )
         OBTN_Visible( cFormx, nIdBut, .T. )

         lTracking := .F.

      END IF
   ELSE

   END IF

RETURN



Return

FUNCTION SaidaFocus(aLb)

  LOCAL n
  
  FOR n := 1 TO Len(aLb)
     PostMessage(aLb[n][LABEL_HWND], WM_MOUSELEAVE, 0, 0)     
  NEXT     

RETURN NIL

Function HideMenuPrin( lVisible1 )

  Local n1 
  
  For n1 := 1 To Len(aOpcoes)
  		If _IsControlDefined( aOpcoes[n1][1]   ,"fSplit6")     
		        SetProperty("fSplit6", aOpcoes[n1][1]  ,"Visible", lVisible1  )                  
		  End If     		     
  Next


Return


Function HideAll(cForm1 , lVisible)

     Local n := 1
     Local cLabel := ""
     
     Default lVisible := .f.
     
     If nLevelMenu   == 1		     
		     HideMenuPrin(lVisible)		     
     End If
     
     
     fSplit4.fUserDb.Visible := lVisible
     fSplit4.fLabelUser.Visible := lVisible
     fSplit4.fServerDb.Visible := lVisible     
     
     fSplit3.fLabel1Dt.Visible := lVisible     
     
     fSplit3.Label_1.Visible := lVisible
     
     //fSplit4.fUserDb.Visible := .f.
     
     
     For n := 1 to 4         
         For z := 1 to 99
             cLabel := "MenuX" + StrZero(n,2)+StrZero(z,2)             
             If _IsControlDefined(cLabel,cForm1)
                 SetProperty(cForm1,cLabel,"Visible", lVisible)             
             End If         
         Next
     Next
     
Return


Function SetTitMenu(cMenu)

  //SetProperty("fSplit2","LblTitMenu","Value",cMenu)
  //DoMethod("fSplit2","LblTitMenu","REfresh")

REturn

Function OpMenu(aOpcoes , cJan , nLinha , cTitx )

  Local n1
  Local cLbl:=''
  Local nRow := 0
  Local lBlTitx1 := 'Lbl'+Left(cTitx,3)+StrZero(nLinha,4)
  
  
  //SetProperty(cJan,"BACKCOLOR",BACK5)
  DoMethod(cJan,"Refresh")
  
    
  For n1 := 1 to Len(aOpcoes)
  
       cLbl := "Mnx" + StrZero(n1,4) + Left(Alltrim( aOpcoes[n1]) , 2)+Right(Alltrim( aOpcoes[n1]) , 2)
       
       
       If !_IsControlDefined(cLbl , cJan)
		                 
		                      //msginfo(cLabelx) 		                                 
	         DEFINE LABEL &(cLbl)
		        			PARENT    &(cJan)
	    		        ROW       nRow
					        COL       3
					        WIDTH     fsplit6.Width
			            HEIGHT    nItemHeight
			            FONTNAME  'Arial'
			            FONTSIZE  10
					        VALUE     '         '  + Padr(Alltrim(hb_ansiToOem(aOpcoes[n1])),70) + '                  '
					        ALIGNMENT Left
					        TRANSPARENT .f.
					        FONTCOLOR FONTCOR
	        				BACKCOLOR BACK5
					        
		       END LABEL
		       
		       //msginfo('f1')
		       
		       nRow+=nItemHeight
		       
		       nHnd1 := GetProperty(cJan , cLbl  , "HANDLE")
		       
		       EventProcessAllHookMessage(EventCreate({ || LabelEventHandler(aOpcoes) }, nHnd1  ), .T.)		  
		       
		       //aOpcoes[n][LABEL_HWND] := GetProperty("fSplit6", aOpcoes[n][LABEL_NAME] , "HANDLE")
	      
	         SetHandCursor( nHnd1, "Finger.cur" )      
	
	         //HMG_ChangeWindowStyle(nHnd1, 0x00010200 , NIL, .F., .F.)
	         //HMG_ChangeWindowStyle(nHnd1, WS_EX_STATICEDGE, NIL, .T., .T.)
	         
	         DoMethod(cJan , cLbl  ,"Refresh" )
		       
		   Else		   
		         SetProperty( cJan ,cLbl  ,"Visible",.t.)                                  		                     
		         DoMethod(cJan , cLbl ,"Show" )       		         
		       		   
		   End If   						   
  
  Next


Return nRow


Function RestMenu(nOp1 , nLinha , nTam , nOpSel )

    Local n1 := 0
    Local nLin := 10
    Local nHandle
    Local cControl
    Local cForm
    Local lPula := .f.
    
    Default nTam := 0
    
    //aOpcoes[n][LABEL_HWND] := GetProperty("fSplit6", aOpcoes[n][LABEL_NAME] , "HANDLE")
    
    For n1 := nOp1 to Len(aOpcoes)
    
        nHandle := aOpcoes[n1][LABEL_HWND]
        
        GetControlNameByHandle(nHandle, @cControl, @cForm)  
        
        SetProperty(cForm, cControl, "BACKCOLOR", BACK1)      
			  SetProperty(cForm, cControl, "FONTBOLD", .F.)      
        
        If !lPula        
        
            If nOpSel > 0
	             If n1 <= nOpsel        			
	             			 Nlin := aMtrPos[n1]
	          		Else        		
	          	 	 		nLin += nItemHeight        		
  	        		End If	      
        		Else
        		
        		    If n1 > 1
        		       nLin += nItemHeight        		
        		    End If
        		
        		End If 		
        		
        Else
            nLin += (nTam+nitemHeight)
            lPula := .f.
        End If		
        
        //msginfo(cForm)
        
        SetProperty(cForm,cControl,'Row' , nLin)        
        DoMethod( cForm , cControl ,'Refresh' )
        
        
        If nOpSel > 0
        		If N1 == nOpSel
        		   SetProperty(cForm,'Image1' , 'Transparentcolor' , BACK1 )        
        			 SetProperty(cForm,'Image1' , 'Transparent' , .t.)        
        			 SetProperty(cForm,'Image1' , 'Visible' , .t.)        
        			 SetProperty(cForm,'Image1' , 'Col' , 4)        
        			 SetProperty(cForm,'Image1' , 'Row' , nLin)        
        			 
        			 SetProperty(cForm, cControl, "BACKCOLOR", CORSEL)
        	 		 SetProperty(cForm, cControl, "FONTBOLD", .T.)        
        			 
        			 //msginfo(cControl)
        			 
           		 lPula := .t.
           		 
        		End If
        End If
        
        //msginfo(cControl)        
        
    Next

Return


/////////////


FUNCTION LabelEventHandler(aLabel)
  STATIC lTracking := .F.
  LOCAL  nHWnd   := EventHWND()
  LOCAL  nMsg    := EventMSG()
  LOCAL  nWParam := EventWPARAM()
  LOCAL  cControl
  LOCAL  cForm
  Local cName

  GetControlNameByHandle(nHWnd, @cControl, @cForm)  
  
   //msginfo(cControl)
   

  SWITCH nMsg
    CASE WM_KEYDOWN
      IF nWParam == VK_TAB
        LabelSetBorder(aLabel, GetNextDlgTabItem(GetProperty(cForm, "HANDLE"), nHWnd, (GetKeyState(VK_SHIFT) < 0)))
        
        If Alltrim(cControl) == 'lblTitMenu'
         msginfo('ok7')
      End If
        
        
      ELSEIF (nWParam == VK_RETURN) .or. (nWParam == VK_SPACE)
        
        
        MsgBox(GetProperty(cForm, cControl, "VALUE"))
        
        If GetProperty(cForm, cControl, "VALUE") = 'Clientes'
        	 CadCli()
        End If 	 
        
      ENDIF
      EXIT

    CASE WM_KEYUP
      IF nWParam == VK_TAB
        LabelSetBorder(aLabel, nHWnd)        
        //MsgBox('ee')        
        
      ENDIF
      EXIT

    CASE WM_LBUTTONDOWN
      //SetFocus(nHWnd)
      //LabelSetBorder(aLabel, nHWnd)      
      
      cOpcao := GetProperty(cForm, cControl, "VALUE")
      
      nRow := 09
      
      If ("Voltar" $ cOpcao)
          //msginfo("ok")
          HideAll("fSplit6" )
          SetTitMenu("Menu Principal")
          ShowMain()
          nLevelMenu     := 1
          MenuPrin(.t.)
          SaidaFocus(aOpcoes)
          
          HideAll("fSplit3" , .t. )
          HideAll("fSplit4"  , .t.)
          
          
          
      End If
      
      If (Alltrim(cOpcao) $ "Cadastros.Movimentos.Relatorios.Parametros")
      
         SetWindowControlsVisible( 'fSplitSubMenu' , .f. )
         
         nTop   := GetProperty(cForm, cControl, "Row")          
         cDesc := GetProperty(cForm, cControl, "Value") 
         
         If (Alltrim(cDesc) == Alltrim(cOpAberto))         
             
             cOpAberto := ''
             SetProperty(cForm,'Image1' , 'Visible' , .f.) 
             RestMenu(1 , 0  , GetProperty('fSplitSubMenu' , 'Height') , 0 )
             DoMethod('fSplitSubMenu' ,'Hide' )         
            // msginfo('Fechar')
         
         Else
         
         		 nIndice := Ascan(aOpcoes , { |a|  Alltrim(a[1]) == Alltrim(cDesc) } )
         		 
         		 If nIndice <= 0
         		    msginfo('Falha em System 0')
         		    Return
         		 End If
         		 
         		 //msginfo(cDEsc)
         		 
         		 nContItens := 0
         		 Aeval(aItens , { | a | Iif( Left(a[1],1) == Alltrim(Str(nindice)) , nContItens++ , Nil ) } )         
         		 
         		 nLinRow := nTop + 15 +  GetProperty('fSplit6' , 'Row') + 28
         		 nLinRow :=  60 + ((nIndice + 1)  * nItemHeight) 
         		 
         		 //msginfo(str(nLinRow) + '   ' + str(nContItens) )
         		 
         
             If (nIndice < Len(aOpcoes))
                 nLinex1 := aOpcoes[nIndice][4] + GetProperty('fSplitSubMenu' , 'Height')
                 //+ (15 * nContItens)
                 //msginfo(  str(aOpcoes[nIndice][4])   )
		             //RestMenu(nIndice+1 , nLinex1 )		         
		             
		             RestMenu(1 , nLinex1  , GetProperty('fSplitSubMenu' , 'Height') , nIndice )
		             
		         End If		         	         
		         
		         
		         Do Events
		         
		         //msginfo('lp')
         
         	   DoMethod('fSplitSubMenu' ,'Hide' )   
		         
		         //DoMethod('fSplitSubMenu' ,'Show' )
		         
		         cOpAberto := Alltrim(cDesc)
		         
		         aOpx1 := {}         
		         
		         Aeval(aItens , { | a | Iif( Left(a[1],1) == Alltrim(Str(nindice)) , Aadd(aOpx1,Right(a[1],Len(a[1]) - 2) ) , Nil ) } )         
		         
		         //SetProperty( 'fSplitSubMenu' , 'Visible',.t.)
		         SetProperty( 'fSplitSubMenu' , 'Row', nLinRow - 2 )
		         
		         SetProperty( 'fSplitSubMenu' , 'Col', 1)
		         
		         SetProperty( 'fSplitSubMenu' , 'Width', fSplit6.Width )
		         
		         
		         DoMethod('fSplitSubMenu' ,'Show' )
		        
		          
		         Do Events
		         
		         //DISABLEVSCROLLBAR(  fSplitSubMenu.Handle   )
		         //ShowScrollBar( GetFormHandle( 'fSplitSubMenu' ), 1, .f. )
		         
		         nLinhax := OpMenu( aOpx1 , 'fSplitSubMenu' , 0  , '' )	         
		         
         
         End If
         
                 
     
         
         RefreshAll('fSplitSubMenu')
         //RefreshAll('fSplit6')
         Do Events
         
         //MSGINFO('OK')
          
      
      
      End If
      
      If (cOpcao $ "Cadastros.Movimentos.Relatorios.Parametros") .And. ( 1 = 2 )
      
      		//msginfo('ok')
      		
      		nLevelMenu     := 2
      
		      nTop   := GetProperty(cForm, cControl, "TOP")
		      
		      SetTitMenu(cOpcao)
		      
		      nIndice := Ascan(aOpcoes , { |a|a[1] == cOpcao } )
		      
		      SaidaFocus(aOpcoes)
		      
		      If nIndice > 0
		      
		         nNumero := aOpcoes[nIndice][3]                  		         
		         
		         MenuPrin(.f.)
		        
		         For Nx := 1 To Len(aItens)
		         
		             aMz1 := aItens[Nx]		         
		             nIy1 := Val(  Left( aItens[nx][1],1)   )
		             
		             If (nIy1 == nNumero)
		             
		             		 cTitulo := Right( aItens[nx][1] , Len(aItens[nx][1]) - 2)
		             		 
		                 cLabelx := 'MenuX' + StrZero(nNumero,2)+StrZero(nX,2)		               
		                 
		                 If !_IsControlDefined(cLabelx , "fSplit6")
		                 
		                      //msginfo(cLabelx) 		                                 
		                      
		                      DEFINE LABEL &(cLabelx)
		        						 			PARENT    fSplit6
											        ROW       nRow
											        COL       2
											        WIDTH     140									        
											        HEIGHT    16
											        VALUE     hb_ansiToOem(cTitulo)
											        ALIGNMENT Center
											        FONTCOLOR FONTCOR
											        BACKCOLOR BACK1
		      						   END LABEL
		      						   
		      						   nRow+=20
		      						   
		      						   aItens[nX][LABEL_HWND] := GetProperty("fSplit6", cLabelx , "HANDLE")
		      
										     SetHandCursor( GetControlHandle(cLabelx , "fSplit6"), "Finger.cur" )      
		
										     HMG_ChangeWindowStyle(aItens[nX][LABEL_HWND] , 0x00010200 /*WS_TABSTOP|SS_CENTERIMAGE*/, NIL, .F., .F.)
										     HMG_ChangeWindowStyle(aItens[nX][LABEL_HWND], WS_EX_STATICEDGE, NIL, .T., .T.)
		      
		      							 EventProcessAllHookMessage(EventCreate({ || LabelEventHandler(aItens) }, aItens[nX][LABEL_HWND]), .T.)		                 
		      							 
		      							 DoMethod("fSplit6", cLabelx ,"Refresh" )
		                 
		                 Else                      
		                     //SetProperty(   cForm,cLabelx,"Visible",.f.)                                  
		                      //HideAll("fSplit6" , .t. )
		                     
		                     //msginfo('2432')
		                     SetProperty(   cForm,cLabelx,"Visible",.t.)                                  		                     
		                     DoMethod(cForm, cLabelx ,"Show" )
		                     
		                     //DoMethod("fSplit6", "Refresh" )
		                     
		                     //Msginfo('ja Definido')
		                     
		                     
		                 End If
		             
		             End If         
		         
		         Next
		      
		      End If
      
      
      Else
      
      
         If cOpcao == 'Clientes'
         
         		IF ( FindWindowEx( ,, ,'Cadastro de Clientes'  ) > 0 )
      				 MsgInfo( 'Este Cadastro ja esta Ativo.' )
      				 Return
   					END IF
   					
   					CadCli(  nHWnd ,  aLabel)    					


         End If      
      
      End If 
      
      

    CASE WM_RBUTTONDOWN
     // SetFocus(nHWnd)
     // LabelSetBorder(aLabel, nHWnd)
     /// msginfo('rrr')
     // EXIT

    CASE WM_MOUSEMOVE
      IF ! lTracking
      	
         
        If Alltrim(Left(cControl,3)) = 'Mnx'
 
           SetProperty(cForm, cControl, "BACKCOLOR", WHITE)           
           SetProperty(cForm, cControl, "FONTBOLD", .f.)            
        
        Else
        
           
        	 SetProperty(cForm, cControl, "BACKCOLOR", CORSEL)
        	 SetProperty(cForm, cControl, "FONTBOLD", .T.)        
        	 
        	 nLin5 := GetProperty(cForm, cControl,"Row")
        	 
        	 SetProperty(cForm,"image2","Visible", .t.)
        	 SetProperty(cForm,"image2","Row", nlin5)
        	 
        	 SetProperty(cForm,"image2","col", 2)
        	 
        	 
        	 
        	 
	         
	      End If 
	      
	      lTracking := TrackMouseEvent(nHWnd) //TME_LEAVE is default flag                
        
				
      ENDIF
      
      EXIT

    CASE WM_MOUSELEAVE
    
      If Alltrim(cControl) = 'LblTitMenu'
      
      	SetProperty(cForm, cControl, "TRANSPARENT", .T.)            
      	SetProperty(cForm, cControl, "FONTBOLD", .t.)            
      
      Else
      
							cOpcao2 := GetProperty(cForm, cControl, "CAPTION" )
							
							If (cForm = 'fSplit6')
								 SetProperty(cForm,"image2","Visible", .f.)
							End If
							
							If !Empty(cOpAberto)
									If Alltrim(cOpcao2) != Alltrim(cOpAberto)
									
									    cName := GetProperty(cForm, cControl , "NAME")
									
									    If Left(cName,3) = 'Mnx'
													SetProperty(cForm, cControl, "BACKCOLOR", BACK5)
											Else
												  SetProperty(cForm, cControl, "BACKCOLOR", BACK1)
											End If		
											
											SetProperty(cForm, cControl, "FONTBOLD", .F.)
											
											
									End If
							Else
										SetProperty(cForm, cControl, "BACKCOLOR", BACK1)
										SetProperty(cForm, cControl, "FONTBOLD", .F.)
										//SetProperty(cForm, cControl, "TRANSPARENT", .T.)            
										
							End If
      
      End If
      
      //msginfo(Alltrim(cControl))
      
      
      
      //PostMessage( fSplit2.LblTitmenu.Handle , WM_MOUSELEAVE, 0, 0)     
      //Msginfo('x0101')
      
      lTracking := .F.
      EXIT
  ENDSWITCH

RETURN NIL

Function MenuPrin(lVisible)

   SetProperty("fSplit6","Cadastros","Visible",lVisible)
   SetProperty("fSplit6","Movimentos","Visible",lVisible)
   SetProperty("fSplit6","Relatorios","Visible",lVisible)
   SetProperty("fSplit6","Parametros","Visible",lVisible)
   
   DO EVENTS

Return

FUNCTION LabelSetBorder(aLabel, nHWnd)
  LOCAL nPosDel := aScan(aLabel, { |a1| HMG_IsWindowStyle(a1[LABEL_HWND], WS_BORDER) })
  LOCAL nPosSet := aScan(aLabel, { |a1| nHWnd == a1[LABEL_HWND] })  
  

  IF nPosDel != nPosSet
    IF nPosDel > 0
      HMG_ChangeWindowStyle(aLabel[nPosDel][LABEL_HWND], NIL, WS_BORDER, .F., .T.)
      HMG_ChangeWindowStyle(aLabel[nPosDel][LABEL_HWND], WS_EX_STATICEDGE, NIL, .T., .T.)
    ENDIF

    IF nPosSet > 0
      HMG_ChangeWindowStyle(aLabel[nPosSet][LABEL_HWND], WS_BORDER, NIL, .F., .T.)
      HMG_ChangeWindowStyle(aLabel[nPosSet][LABEL_HWND], NIL, WS_EX_STATICEDGE, .T., .T.)
    ENDIF
  ENDIF
  


RETURN NIL

Function D1Black(cJan,zBitMap)
   
    Local hDc
//    Local cJan 
    
    Local nRow := 0
    Local nCol := 0
    
    LOCAL Width  := BT_ClientAreaWidth  (cJan)
		LOCAL Height := BT_ClientAreaHeight (cJan)	
		
		LOCAL BTstruct 	
    
		If lAtivaBlack
		
		   For n1 := 1 To Len(aButTop)
		       OBTN_Visible('fSplit2'  ,   aButTop[n1][1]   , .f.)		   
		   Next	     		
		   
		   SetWindowControlsVisible('fSplit5' , .f. )
		
		   hDC    = BT_CreateDC ( cJan  , BT_HDC_INVALIDCLIENTAREA, @BTstruct)	
		       
		   BT_DrawGradientFillVertical (hDC,  nRow  ,  nCol  ,  Width,  Height , BLACK , BLACK)    
		       
		   BT_DrawBitmapAlphaBlend (hDC, nRow ,  nCol  , nil, nil, 120 , BT_COPY  , zBitmap)              
		    
		Else
		
		    For n1 := 1 To Len(aButTop)
		        OBTN_Visible('fSplit2'  ,   aButTop[n1][1]   , .t.)		   
		    Next	     						   		  
		   
		    Proc_ON_PAINT(cJan)     
		    
		    SetWindowControlsVisible('fSplit5' , .t. )
		    //RefreshAll('fSplit5')
		    
		    
		End If
		

Return

fUNCTION DrawTransp(cJan , zBitMap)

  Local hDc
  LOCAL Width  := BT_ClientAreaWidth  (cJan)
	LOCAL Height := BT_ClientAreaHeight (cJan)
	
	Local nRow := 35
	Local nCol := 0
	
	LOCAL BTstruct 	
	
  LOCAL cFormName := ''
 
  GetFormNameByHandle ( GetActiveWindow(), @cFormName )
	
	hDC    = BT_CreateDC ( cJan  , BT_HDC_INVALIDCLIENTAREA, @BTstruct)	
	
	If lDrawMain 
	  	hb_memowrit('cli221ok.txt', 'Transp : ' + cJan + ' ' + Str(Width) + ' ' + Str(Height) + ' rrow : ' + Str(nRow) )
	   nRow := 0
	End if
	
  
  If Flag_AlphaBlend_Effect   
      BT_DrawGradientFillVertical (hDC,  nRow  ,  nCol  ,  Width,  Height , BLACK , BLACK)         
    
      
      hb_memowrit('cli1.txt', 'Transp : ' + cJan + ' ' + Str(Width) + ' ' + Str(Height) + ' rrow : ' + Str(nRow) )
      BT_DrawBitmapAlphaBlend (hDC, nRow ,  nCol  , nil, nil, 120 , BT_COPY  , zBitmap)              
      
      If Alltrim(cJan) != "Main"
     
    	  
	      
      End If
      

  Else     	  
  	  	//SaveLog('lmainc1.txt' ,'Atual : ' + cFormName + ' Transp : ' + cJan + ' ' + Str(Width) + ' ' + Str(Height) + ' rrow : ' + Str(nRow) + QUEBRA )
		  
      If Alltrim(cJan) != "Main"
   			  //BT_DrawBitmap (hDC, 0 ,  0, Width,  Height   , BT_COPY, zBitMap )      			  
   			  //SaveLog('lmainc2.txt' ,'Atual : ' + cFormName + ' Transp : ' + cJan + ' ' + Str(Width) + ' ' + Str(Height) + ' rrow : ' + Str(nRow) + QUEBRA )
   	  End If		  
      
  End If
  
  BT_DeleteDC (BTstruct)  

REturn

Function SaveLog(cArqLog,cTexto)

 Local cText := hb_memoRead(cArqLog)
  
  hb_memowrit(cArqLog , cText +' '+ cTexto )
  
Return  
 

Function DoFocus()

   DO EVENTS
   
Return 





#pragma BEGINDUMP

#include "SET_COMPILE_HMG_UNICODE.ch"
#include "HMG_UNICODE.h"

#include <windows.h>
#include "hbapi.h"

      // https://msdn.microsoft.com/en-us/library/windows/desktop/ms646265(v=vs.85).aspx
      // TrackMouseEvent(nHWnd, [nFlags], [nHoverTime]) --> lSuccess
HB_FUNC( TRACKMOUSEEVENT )
{
  TRACKMOUSEEVENT tmi;

  tmi.cbSize      = sizeof(TRACKMOUSEEVENT);
  tmi.dwFlags     = hb_parnidef(2, TME_LEAVE);
  tmi.hwndTrack   = (HWND) HMG_parnl(1);
  tmi.dwHoverTime = hb_parnidef(3, HOVER_DEFAULT);

  hb_retl(TrackMouseEvent(&tmi));
}


HB_FUNC( SETARROWCURSOR )
{
   SetClassLong( ( HWND ) hb_parnl( 1 ), GCL_HCURSOR, ( LONG ) LoadCursor( NULL, IDC_ARROW ) );
}

HB_FUNC( SETHANDCURSOR )
{
   SetClassLong( ( HWND ) hb_parnl( 1 ), GCL_HCURSOR, ( LONG ) LoadCursor( NULL, IDC_HAND ) );
}

HB_FUNC( SETWAITCURSOR )
{
   SetClassLong( ( HWND ) hb_parnl( 1 ), GCL_HCURSOR, ( LONG ) LoadCursor( NULL, IDC_WAIT ) );
}



HB_FUNC ( DISABLEVSCROLLBAR )
{
 EnableScrollBar ( (HWND) hb_parnl (1), SB_VERT, ESB_DISABLE_BOTH );
}

#pragma ENDDUMP




