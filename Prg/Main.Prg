#include <hmg.ch>
#include <minigui.ch>

#define QUEBRA Chr(13)+Chr(10)

#define SB_LINEUP           0    // ok
#define SB_LINEDOWN         1    // ok

#define _STM_SETIMAGE_ 0x0172
#define _IMAGE_BITMAP_ 0

#define SB_HORZ 0
#define SB_VERT 1
#define SB_LEFT 6
#define SB_TOP 6
//#define SB_LINEUP 0RGB(0xcc,0xe3,0xe1)RGB(0xcc,0xe3,0xe1)
#define SB_ENDSCROLL 8
#define WM_VSCROLL  0x0115
#define WM_HSCROLL 276

// #DEFINE SB_VERT 1
#define SB_BOTH 3



#define LABEL_NAME 1
#define LABEL_HWND 2

#define ARROWCURSOR          1  // The standard arrow cursor.
#define BUSYCURSOR           2  // An hourglass or watch cursor, usually shown during operations that allow the user to interact with the application while they are performed in the background.
#define POINTINGHANDCURSOR   3  // A pointing hand cursor that is typically used for clickable elements such as hyperlinks.
#define WAITCURSOR           4  // An hourglass or watch cursor, usually shown during operations that prevent the user from interacting with the application.

MEMVAR _HMG_SYSDATA


#define FONTCOR {0,106,133}

#define BACK1 {229,237,242}

#define BACK5 {255,255,255}

#define CORSEL {215,228,236}
//{180,205,220}
//{216,228,236}

#define FONT1 {102,102,102}


DECLARE WINDOW fSplit6

REQUEST HB_LANG_PT
REQUEST HB_CODEPAGE_PT850

//SET AUTOSCROLL ON


FUNCTION Main

	 Public cForm := ''

   PUBLIC aBackColor := { 57, 108, 164 }
   
   Public nVirtualMenu := Nil
   
   Public aRotHnd := {}
   
   Public lAtivaBlack := .f.
   
   Public nGauge
   
   Public oServer
   
   SET TOOLTIPCUSTOMDRAW ON
   SET TOOLTIPSTYLE BALLOON 
   SET TOOLTIPBACKCOLOR { 250, 250, 210}
   
   SET NAVIGATION EXTENDED

   
   Public cJanx
   
   Private aCords := {}
   
   SET SCROLLSTEP TO 10

   PUBLIC cBackColor := { 166, 210, 210 }
   
   public lTracking6 := .f.

   //PUBLIC bColor := {|| iif( ( LastRec() > 0 ) .AND. ( RecNo() / 2 == Int(RecNo() / 2 ) ), { 159,207,255 }, { 255,255,255 } ) }
   
   PUBLIC bColor := {|| iif( ( LastRec() > 0 ) .AND. ( RecNo() / 2 == Int(RecNo() / 2 ) ), { 238,238,238 }, { 255,255,255 } ) }

   PUBLIC fColor := {|| iif( ( LastRec() > 0 ) .AND. ( AllTrim(Status ) == 'Ativo' ), { 78,78,78 },  { 255, 0, 0 } )  }
   

   //PUBLIC bColorGrid := {|| iif( ( LastRec() > 0 ) .AND. ( RecNo() / 2 == Int(RecNo() / 2 ) ), { 207,254,239 }, {255,255,235} ) }
   
   Public bColorGrid := {|| iif( ( LastRec() > 0 ) .AND. ( RecNo() / 2 == Int(RecNo() / 2 ) ), { 235,243,242 }, {211,231,230} ) }

   PRIVATE nDEsk1 := 975
   
   Public lVScrool := .f.
   
   
  Public Corg1 := {255,255,125} 
	Public Corg2 := {4,57,70}   
	

   
	
	PUBLIC cDiaName := 'fDialogo'

   
   Private nacumz := 0
   Private aMtrPos := {}
   
   Public nTipo := 3
   Public cMensagem := 'Processando..' 
   
   Public cFormPrin := ''
   
   PRIVATE ColorGrid :=  { 233,233,233 }
   
    Private hBitmap2
    
   Private lFlagGeral1 := .f. 
   
   Private lTracking12 := .F.
   
   Private aLinhas := {}

   PRIVATE aFontz1 := ARRAY FONT "Calibri" SIZE 11 
   //BOLD ITALIC
   
   Private nHanSelected := 0
   
   Private nColSel := 0

   PUBLIC cRazaoEmp     := ''
   PUBLIC cFantadisEmp  := ''
   PUBLIC cEnderecoEmp  := ''
   
   Public lDrawMain := .f.
   
   Private nLinSc := 0
   PUBLIC  cServer := ''
   PUBLIC  cBanco  := ''
   PUBLIC cUserDb  := ''
   PUBLIC cPassDb  := ''   
   
   Public cUserName := 'Admin'


   PUBLIC cBairroEmp    := ''
   PUBLIC cCidadeEmp    := ''
   
   
   PUBLIC qTotReg       := 150

   PUBLIC nVirtual1     := 540
   
   Public nItemHeight := 16
   
   Private nItemSel := 0

   PUBLIC nIdEmp        := 1

   PUBLIC cSqlLog       := "c:\temp\Logs\Sqlx1_Log_" + DToS( Date() ) + ".Log"


	 SET LANGUAGE TO PORTUGUESE
	 
	 SET CODEPAGE TO PORTUGUESE
	 
	 SET AUTOSCROLL ON
	 
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
   
   Public cActiveJan  := 'Main'
   Public aJanelas    := {}
   
   Private cOpAberto := ""
   
   Private nContItens := 0
   
   Private TxColorE  := Rgb( 255, 255, 255 )
   Private FrColorE  := Rgb( 9, 111, 137 )
   
   Private lTracking2 := .F.
   
   Public cLblSelected := ''  
   
   
    //{ 9, 111, 137 }

   Private BkColorE1 := Rgb( 9, 111, 137 )
   Private BkColorE2 := Rgb( 9, 111, 137 )
   
   Private lApaga := .f.
   
   Private lOut := .t.
   
   Private hBitmapDes := 0
   
   Private hBit2      := 0
   Private hBitMain   := 0
   
   Public hBit10      := 0
   Public hBit11      := 0
   Public hBit12      := 0
   
   Public hBit20      := 0

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
   Public cFontName  := 'Arial'
   Private FontSize  := 8   
   
   Private nColScrool := 0
   
   Private lScrool := .t.

   Public aBtnFont  := { "Arial", 8, .F., .F., .F., .F. }
   
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
   
   Aadd(aJanelas , { 'Main' , 'Main'  , 0}  )
   
   HMG_ActivateMainWindowFirst(.t.)
   

   Load Window Main

   Main.Center
   
   Main.Maximize()
   
   Load Window fSplitSubMenu
   
   
   
   Private aOpcoes := {{"Importar", Nil , 1 , 0  }, ;                                      
                   {"Consultas", Nil , 2 , 0    },;
                   {"Relatorios", Nil , 3 , 0    } }                   
                   
   Private nOpSel := 1                
   
   Private aItens := { {"1-Arquivo Sped",Nil} , ;
       {"2-Consulta Notas",Nil},{"2-Consulta Notas",Nil},{"2-Consulta Notas",Nil} , {"2-Consulta Notas",Nil}   }
      
                   
    Private nItemMax := 10
    
    Private nRowIni := 10                   
    
        
    n := 1
    
                  
    For n := 1 to Len(aOpcoes)    
    
        //msginfo( aOpcoes[n][LABEL_NAME] )
    
	      DEFINE LABEL &(aOpcoes[n][LABEL_NAME] )
	        PARENT    fSplit6
	        ROW       nRowIni
	        COL       21
	        WIDTH     fSplit6.Width       
	        FONTNAME  'Arial'
			    FONTSIZE  10
	        HEIGHT    16
	        VALUE     Alltrim(aOpcoes[n][LABEL_NAME]) 
	        ALIGNMENT Left
	        FONTCOLOR FONTCOR 
	        BACKCOLOR {255,255,255}
	      END LABEL    	      
	      
	      //msginfo( aOpcoes[n][LABEL_NAME] )
	      aadd(aMtrPos  , nRowIni)
	      aOpcoes[n][4] := nRowIni
	      
	      nRowIni += 15      
	
	      aOpcoes[n][LABEL_HWND] := GetProperty("fSplit6", aOpcoes[n][LABEL_NAME] , "HANDLE")
	      
	      //SetHandCursor( GetControlHandle(aOpcoes[n][LABEL_NAME] , "fSplit6"), "Finger.cur" )      
	
	      
	      EventProcessAllHookMessage(EventCreate({ || LabelEventHandler(aOpcoes) }, aOpcoes[n][LABEL_HWND]), .T.)	      
	      //n++
      
    Next
    
    
    EventProcessAllHookMessage(EventCreate({ || LabelEventHandler(aOpcoes) },   fSplit6.Img_seta1.Handle ) , .T.)	          
    EventProcessAllHookMessage(EventCreate({ || LabelEventHandler(aOpcoes) },   fSplit6.img_seta2.Handle ) , .T.)	    
       
    
    //HMG_ChangeWindowStyle(fSplit6.Handle    , 0x00010200 , NIL, .F., .F.)
    //HMG_ChangeWindowStyle( fSplit6.Handle  ,WS_EX_TOOLWINDOW  , NIL, .t., .t.)      
    
    HMG_ChangeWindowStyle( fSplit6.Handle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )    
    
    HMG_ChangeWindowStyle( fSplit3.Handle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )    
    HMG_ChangeWindowStyle( fSplit4.Handle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )    
    
    HMG_ChangeWindowStyle(fSplit2.Handle    , 0x00010200 , NIL, .F., .F.)
    HMG_ChangeWindowStyle( fSplit2.Handle  ,WS_EX_TOOLWINDOW  , NIL, .t., .t.)    
        
            
    DEFINE LABEL fLabel1Dt
        PARENT    fSplit3
        ROW       18
        COL       51
        WIDTH     140        
        HEIGHT    16
        VALUE     Alltrim(Dtoc(dDataBase))
        ALIGNMENT LEft
        FONTCOLOR {102,102,102}
        BACKCOLOR {255,255,255}    
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
        FONTCOLOR {102,102,102}
        BACKCOLOR {255,255,255}    
        //TRANSPARENT .T.
        ACTION xMenuPrin()   
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
        FONTCOLOR {102,102,102}
        BACKCOLOR {255,255,255}    
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
      
      
                    	
   Public aButTop := {} 
  
   //CrieBotJan()
   //ButtonsTop()
   
//   InstallEventHandler( "EventHndTop" )
   
   InstallEventHandler( "EventHndBut" )
   
   InstallEventHandler( "EventDl1" )
   
   InstallEventHandler( "EventIn2" )

   InstallEventHandler( "EventHndFlt" )
   
   InstallEventHandler( "EventInput" ) 
      
   Main.Activate 

RETURN


Function CrieBotJan()

  Local n2 := 31342
  Local n1 := 1
  Local cForm := 'fSplit2'
  Local nId
  
  
  
  If Len(aButTop) > 0
     aeval(aButTop , { |a| OBTN_Release( 'fSplit2' , a[1] ) }  )
     //msginfo('pp')
  End If
  
  aButTop := {}  
  

  For n1 := 1 To Len(aJanelas)
  
       If n1 == 1 
       		//aAdd( aButTop ,  { n2 ,  "Principal"	 , { ||      OpMenuPrin()     } } )  
       Else
       		//aAdd( aButTop ,  { n2 , aJanelas[n1][1] 	 , { ||      BringJan()     } } )  
       End If	
       aJanelas[n1][3] := n2 
       n2++	      
       
      // n2++  
  Next  
  
REturn

Function lMenuP( lVisible , nindice  )

 LOCAL nHButton := GetDlgItem(GetFormHandle('fSplit2') , aButTop [nindice][1]  )
     
  If !lVisible
  		HideWindow(nHButton)
  Else
			ShowWindow(nHButton)
  End If		
  
   
Return

Function ChkExist()
   Local nHan1 := GetControlHandle(  'Mnx0001Cles' , 'fSplitSubMenu'  ) 

   If _IsControlDefined( 'Mnx0001Cles' , 'fSplitSubMenu' )
      
            
       EventProcessAllHookMessage(EventCreate({ || LabelEventHandler(aOpcoes) }, nHan1  ), .T.)		  
       
   Else
       MsgInfo('Not Exis')      
   End If
    
Return

Function xMenuPrin()

  Local nHnd  := Nil 
  
  Local n1    := 1
  
  EscondeJan()    
  cactiveJan  := "Main"  
  
     
  If _isControlDefined('Image_5' , 'fSplit2')     
     SetProperty('fSplit2','Image_5','Visible', .f.)          
     If _isControlDefined('Img' + Right(cLblSelected,4) , 'fSplit2' )
     		SetProperty('fSplit2','Img' + Right(cLblSelected,4)   ,'Visible', .f.)          
     End If		
  End If   
  
  cLblSelected := ''
 
  For n1 := 1 to LeN(aButTop)
      aButTop[n1][3] := .f.
  Next
  
  ButtonsTop( .f. )    
  
  If nHanSelected > 0
  	 EventProcessAllHookMessage(EventCreate({ || LabelEventHandler(aOpcoes) }, nHanSelected  ), .T.)		  
  End If 	 
  
  nHanSelected := 0        
  SysWait(5)  
  
Return


Function RestauraBut()

  Local n1
  
  If _isControlDefined( 'Lblx1_' , 'fSplit2')
      _ReleaseControl( 'Lblx1_' , 'fSplit2')
  End If
          
  If _isControlDefined( 'Lblx2' , 'fSplit2')
      _ReleaseControl( 'Lblx2' , 'fSplit2')          
  End If 
  
  msginfo('REstaura but')
  
//  SysWait(.3)

  For n1 := 1 To Len(aJanelas) 
      //Obtn_Visible('fSplit2', aBut , .f. ) 
      Obtn_Visible('fSplit2', aJanelas[n1][3] , .t. ) 
      
      PostMessage(   OBTN_Handle('fSplit2',  aJanelas[n1][3] )   , WM_MOUSELEAVE,0,0)
      
       If OBTN_Handle( 'fSplit2' , aJanelas[n1][3] ) == 0
      		MsgBox( "Button does not exist!" )
      End if		   
      
  Next

Return

Function RefJanAll()

  Local n1
  
  For n1 := 1 To Len(aJanelas) 
      If OBTN_Visible('fSplit2',  aJanelas[n1][3] ) 
      		PostMessage(   OBTN_Handle('fSplit2',  aJanelas[n1][3] )   , WM_MOUSELEAVE,0,0)  
      End If 		
  Next

Return


Function PushButton( cjanela  , nIdBut )

  PostMessage(   OBTN_Handle(cJanela ,  nIdBut )   , WM_MOUSELEAVE,0,0) 
  
  EnableButton(cJanela  , nIdBut   , .f.)
  EnableButton(cJanela  , nIdBut  , .t.)    
  //msginfo(' push ' + cjanela ) 

Return

Function BringJan( cJanela  , nIdBut )

  //msginfo( cJanela )
  Local nind := 0
  Local cControl
  Local cForm
  
  Local cCapt := ''
  Local nCol  := {}
  
  //PostMessage(   OBTN_Handle('fSplit2',  nIdBut )   , WM_MOUSELEAVE,0,0)  
  
  //Obtn_Color('fSplit2', aJanelas[1][3] , {123,123,155} , .t. )
  //EnableButton("fSplit2", nIdBut   , .f.)
  //EnableButton("fSplit2", nIdBut  , .t.)  
  
  nind := Ascan(aJanelas , { |a| a[1] == cJanela })  
  
  SysWait(.1)
  
  msginfo('bring jan')
  
  If nind > 0
    
      cactivejan := aJanelas[nind][2]
      //RGB(0xd2,0xf0,0xff)RGB(0xd2,0xf0,0xff)
      
      If OBTN_Handle( 'fSplit2' , aJanelas[nind][3] ) == 0
      		MsgBox( "Button does not exist!" )
      End if		         
      
      Obtn_Visible('fSplit2', aJanelas[nind][3] , .f. )    
      
      nCol := OBTN_Pos( 'fSplit2' , aJanelas[nind][3] )      
      cCapt := OBTN_Caption( 'fSplit2' , aJanelas[nind][3] )      
      
      //msginfo(Str( nCol[2] ) +  '  ' + cCapt )           
    
      DoMethod( aJanelas[nind][2] , "Show" )
   		DoMethod( aJanelas[nind][2] , "SetFocus" )
   
   		    
  End If 
  
 
   If Len(nCol) > 0        
  	  CrieLabel( nCol[2] , cCapt ) 
  End If  
  
  RefJanAll()
 

Return

Function CrieLabel( nCol ,cTexto )

  Local cLabelx := 'Lblx1_' 
  Local cLabel2 := 'Lblx2'
  Local nHandle1
  Local nLin := 6

        DEFINE LABEL &(cLabelx )
			         PARENT    fSplit2
			         //PARENT    Main 
			         ROW       nLin
			         COL       nCol
			         WIDTH     75
			         HEIGHT    20
			         VALUE     Hb_AnsiToOem( cTexto )
			         ALIGNMENT CENTER
			         FONTNAME "Left"
        			 FONTSIZE 9
        			 FONTBOLD .t.
			         BACKCOLOR {3,24,1}
        			 FONTCOLOR {255,255,255}			         
			         TRANSPARENT .f.
         END LABEL      
         
         SetProperty( 'fSplit2',cLabelx,'BACKCOLOR', {5,102,126} )         
         
         nHandle1 := GetControlHandle(  cLabelx  , 'fSplit2' )  
         HMG_ChangeWindowStyle(nHandle1    , 0x00010200 , NIL, .F., .F.)
         HMG_ChangeWindowStyle(nHandle1  , WS_EX_STATICEDGE, NIL, .T., .T.)            
         
         
           DEFINE LABEL &(cLabel2 )
			         PARENT    fSplit2
			         //PARENT    Main 
			         ROW       nLin
			         COL       nCol+75 
			         WIDTH     20
			         HEIGHT    20
			         VALUE     QUEBRA+"X"
			         ALIGNMENT CENTER
			         FONTNAME "Arial"
        			 FONTSIZE 10
        			 FONTBOLD .t.
			         BACKCOLOR {3,24,1}
        			 FONTCOLOR {255,255,255}			         
			         TRANSPARENT .f.
         END LABEL      
         
         SetProperty( 'fSplit2',cLabel2,'BACKCOLOR', {5,102,126} )       
         
         nHandle1 := GetControlHandle( cLabel2, 'fSplit2' )    
        // SetHandCursor( nHandle1  , "Finger.cur" )          
         
         EventProcessAllHookMessage(EventCreate({ || LabelEvX() }, nHandle1  ), .T.)  
         
         SetProperty( 'fSplit2',cLabel2,'BACKCOLOR', {5,102,126} )                                  
         

Return

Function LabelEvx()

  STATIC lTracking10 := .F.
  LOCAL  nHWnd   := EventHWND()
  LOCAL  nMsg    := EventMSG()
  LOCAL  nWParam := EventWPARAM()
  LOCAL  cControl
  LOCAL  cForm
  Local cName

  GetControlNameByHandle(nHWnd, @cControl, @cForm)  
  
   //cLabel3 := "LblX2" + StrZero(n1,4)
  
  If (Left(cControl,5) == 'LblX2')
  
      If (nMsg == WM_LBUTTONDOWN)                
          
          nI1 := Ascan(aJanelas , {|a|a[2] == Alltrim(cActiveJan) } )
          
          If nI1 > 0
             nTam := Len(aJanelas)
             Adel(aJanelas , nI1 )             
             aSize(aJanelas, nTam - 1)
          End If
          
          
          If _isControlDefined( 'Lblx1_' , 'fSplit2')
             _ReleaseControl( 'Lblx1_' , 'fSplit2')
          End If
          
          If _isControlDefined( 'Lblx2' , 'fSplit2')
             _ReleaseControl( 'Lblx2' , 'fSplit2')          
          End If
          
          _ReleaseWindow( cActiveJan )          
          
          //OpMenuPrin()
          
          //DoMethod('Main' , 'Show' )
          
          
      End If
  
  
     If (nMsg =  WM_MOUSEMOVE) .And. (!lTracking10)
     
        //SetProperty( 'fSplit2',cControl,'BACKCOLOR', {5,102,126} )    
        
         SetProperty(cForm, cControl, "BACKCOLOR", {4,66,81}  )
      	 SetProperty(cForm, cControl, "FONTBOLD", .T.)    
      	 
      	 lTracking10 := TrackMouseEvent(nHWnd) //TME_LEAVE is default flag                    
     
     
     End If
     
     If (nMsg =  WM_MOUSELEAVE)
     
        // msginfo('ok')
     
         SetProperty(cForm, cControl, "BACKCOLOR", {5,102,126} )
      	 //SetProperty(cForm, cControl, "FONTBOLD", .f.)         
         lTracking10 := .F.
         
     End If  
  
  
  End If


Return



Function EscondeJan()

   Local i := 1
   Local nTam := Len(aJanelas)
   Local lDel := .f.
   
   Aeval( aButTop , { |a| HideJan(a[2]) } )
 

Return

Function HideJan( cJanela )

  If _isWindowDefined(  'F' + Left(cJanela,5) )
  		DoMethod(  'F' + Left(cJanela,5)    , "Hide" )         
  		//msginfo( cJanela )
  Else
  
  End If
  
  RefreshAll('fSplitSubMenu')


Return


FUNCTION EnableButton(cForm, nID, lShow)
//  msginfo('enable button')
  IF OBTN_Handle(cForm, nID) == 0
    MsgBox("Button does not exist!")
  ELSE
    OBTN_Enable(cForm, nID, lShow)
  ENDIF

RETURN NIL

Function CaptTelas(  cExtra )

    hBit10 := BT_BitmapCaptureWindow ('fSplit5' , 0 , 0 , fSplit5.Width , fSplit5.Height)       
    hBit11 := BT_BitmapCaptureWindow ('fSplit2' , 0 , 0 , fSplit2.Width , fSplit2.Height)   
    hBit12 := BT_BitmapCaptureWindow ('fSplit10' , 0 , 0 , fSplit10.Width , fSplit10.Height)   
    
    Default cExtra := ''
    
   
    
    BT_BitmapSaveFile (hBit10  , "hBit10.bmp")  
    BT_BitmapSaveFile (hBit11  , "hBit11.bmp")      
    BT_BitmapSaveFile (hBit12  , "hBit12.bmp")  

Return

Function ButtonsTop( lCria )

  Local cMenuName := 'fSplit2'
  Local nCol := 34
  Local nHBut1
  Local nColx := 0
  Local nRow := 1
  Local nHandle1 
  Local cLabelx
  Local cLabel3
  Local nacum := 33
  Local cUltl := ''
  Local nPulo := 130
  Local cSelected := ''
  Local n1
  
  Default lCria := .t.
 
  
  If lCria
  	 aCords := {}
  End If	 
  
  For n1 := 1 To Len(aButTop) 
  
     cLabelx := "LblUp" + StrZero(n1,4)
     
     If lCria     
        
        cUltl   := cLabelx
           
        If !_IsControlDefined( cLabelx, cMenuName )
			        
			        DEFINE LABEL &(cLabelx)
			               PARENT    fSplit2
						         ROW       10
						         COL       nCol
						         WIDTH     110
						         HEIGHT    40
						         VALUE     " " + Hb_AnsiToOem( alltrim(  aButTop[n1][2] )   )			         
						         ALIGNMENT LEFT
						         FONTNAME "Arial"
			        			 FONTSIZE 9
						         BACKCOLOR {7,101,125}
			        			 FONTCOLOR {255,255,255}			         
						         TRANSPARENT .f.
						         VISIBLE .T.
						         ACTION ( PlaceJan( This.Name  ) , ShowJan( alltrim(This.Value) 	)				)                    
			         END LABEL			  		           
			         
			         SetProperty( 'fSplit2' , cLabelx , 'BACKCOLOR' , {9,111,137} )
			         
			         Aadd( aCords  , { cLabelx , nCol ,nCol+110} )			         
			         
			         If aButTop[n1][3]
			            cSelected := cLabelx
			         End If
			      
			        
			        cImagex := "Img_" + StrZero(n1,4)
			        
			        @ 1,nCol+110 IMAGE &(cImagex) OF fSplit2  PICTURE "img\Fechax.Bmp" WIDTH 20 HEIGHT 40 STRETCH ACTION FechaJan(  This.Name )       
			        
			        nHandle1 := GetControlHandle( cLabelx , 'fSplit2'  )  
				      nAcum += nPulo          
         
       End If
		     
		   nColx := nCol		     
		   
		 Else
		 
		      //SysWait(.3)
		      
			    If _IsControlDefined( cLabelx, cMenuName )
			       //msginfo('defined')
			       SetProperty('fSplit2', cLabelx , 'Visible'    , .t. )
			       SetProperty('fSplit2', "Img_" + StrZero(n1,4) , 'Visible' , .t. )			       
			    End If		   
		   
     End If     
     
     nCol += nPulo+2
     
  Next    
  
  //Refreshall('fSplit2')//
  //syswait(.6)
  
  If !Empty(cSelected)
  		PlaceJan(  cSelected )
  End If
  
  lVScrool := .f.
  
  If (nacum >= GetProperty('fSplit2','Width'))     
      //lTracking6 := .f.
      lVScrool := .t.
      lVertScrol( .t. )        
  End If  
   
Return nColx

Function FechaJan(  cJanela  , lExclBut , nI1 , nI2) 

  Local cId := Right(cJanela,4)
  Local cJan := GetProperty('fSplit2' , 'LblUp' + cid , 'Value' )  
  Local n1  
  Local nTam := Len(aButTop)
  
  Default lExclBut := .f. 
  
  Default nI1 := 0
  Default nI2 := 0
  
  //msginfo( 'ok1' )  
  
  //msginfo('f')  
  
  If (nI1 > 0)
	   EventRemove ( nI1 )
	  // msginfo('removido')
	End If
	
	If (nI2 > 0)
	   EventRemove ( nI2 )
	End If
  
      
  n1 := ascan(aButTop , {|a| alltrim(a[2]) == alltrim(cJan) })
  
  If n1 > 0
  
     adel( aButTop , n1)
     aSize( aButTop , nTam - 1 )     
   
     DelImgBut()
     
     If Len(aButTop) = 0       
        clblSelected := ''
     End If   
     
     _ReleaseControl( 'LblUp' + cid  , 'fSplit2' )   
     _ReleaseControl( 'Img_' + cid  , 'fSplit2' )  
     
     
  End If
  
  
  If Empty(cLblSelected)    
     Refreshall('fSplitSubMenu')     
  End If  
    
  If _IsWindowDefined( 'F' + Left(alltrim(cJan),5) )   
  		Refreshall('fSplitSubMenu')  
      DoMethod(   'F' + Left(alltrim(cJan),5) , 'Release' )             
      SysWait(.2)     
  Else     
      
  End If    
  
   If nHanSelected > 0
  	 EventProcessAllHookMessage(EventCreate({ || LabelEventHandler(aOpcoes) }, nHanSelected  ), .T.)		  
  End If 	 
  
  PostMessage( nHanSelected , WM_MOUSELEAVE ,0,0  )
  
  nHanSelected := 0
  
  
Return

Function DelImgBut()
  
    Local cImg1 := 'Img' + Right(cLblSelected,4)
    
    If _isControlDefined(cImg1 , 'fSplit2' )
    		_ReleaseControl( cImg1 , 'fSplit2' )  
    		_ReleaseControl( 'Image_5' , 'fSplit2' )  
     End If 		
   
Return

Function BusqueCord(xCord)

  //Aadd( aCords  , { cLabelx , nCol ,nCol+110} )			         
  Local nret := 0
  Local n1 := Ascan( aCords , { |a| (xCord >= a[2]) .and. (xCord <= a[3] ) } )
  
  If n1 > 0
      nRet := aCords[n1][2]    
  End If

Return nRet

Function ReleaseTeto()

    Local n1
    Local cLabelx

    For n1 := 1 To Len(aButTop)   
		     
		     cLabelx := "LblUp" + StrZero(n1,4)
		           
		     //msginfo(cLabelx)      
		     
		     If _IsControlDefined( cLabelx, 'fSplit2' )
		         //msginfo('ok')
		        _ReleaseControl( cLabelx , 'fSplit2') 
		     End If
		     
		     aButTop[n1][3] := .f.
		     
		Next     

Return


Function PlaceJan(  cLbl )

   //Local cTexto := GetProperty('fSplit2',cLabel,'Value')
   Local nCol   := GetProperty('fSplit2',cLbl ,'Col')
   Local cTexto := GetProperty('fSplit2' ,cLbl , 'Value')
   Local cLblAnt := cLblSelected
   
     
   Local nCol1 := 0
   Local nRow1 := 0
   Local hWnd
   Local cControlName 
   Local cFormName
   Local zCord
   
   GetCursorPos (@nCol1, @nRow1)
   
   hWnd := WindowFromPoint (nCol1, nRow1)
   
   If GetControlIndexByHandle (hWnd) > 0
      GetControlNameByHandle (hWnd, @cControlName, @cFormName)      		
      zCord := BusqueCord(  nCol1  )
      nCol := zCord
      //msginfo(cControlName + '  ' + cFormName + ' ' + str(nCol1) + '  ' + Str( zCord ) )
   End If
   
   //Msginfo(str(nCol1) + '  ' + cTexto )
   
   If !Empty( alltrim(cLblSelected ))      
       
       SetProperty('fSplit2',cLblSelected ,'Visible', .t. )    
       SetProperty('fSplit2', 'Img_' + Right(cLblSelected,4) , 'Visible' , .t. )  
   
   End If
   
   cLblSelected := cLbl
   SetProperty('fSplit2',cLbl,'Visible',.f.)
   SetProperty('fSplit2', 'Img_' + Right(cLbl,4) , 'Visible' , .f. )
   
   nColSel := nCol
  
   PutImagem(nCol , cTexto , Right(cLbl,4) ) 

Return

Function ShowJan( cJan) 
   
    If _IsWindowDefined( 'F' + Left(alltrim(cJan),5) )
       DoMethod(   'F' + Left(alltrim(cJan),5) , 'Show' )
       DoMethod(   'F' + Left(alltrim(cJan),5) , 'SetFocus' )
       
       cactivejan := 'F' + Left(alltrim(cJan),5)
       
    End If  

REturn

Function PutImagem(nColx , cTexto , cSeq1 )

  Local aRGBcolor := { 7, 101, 125 }
  Local nWidthBmp := 110
  
  Local nHandle1
  Local nHandle2
  Local hWnd
  Local BTstruct
  Local hDc
  Local nTYpe
  Local cImgName := 'Img' + cSeq1
  
  //msginfo( cImgName + ' -> ' + cSeq1)
  
  hBitMap2 := BT_BitmapCreateNew (nWidthBmp , 40 , aRGBcolor)
  
  hDC := BT_CreateDC (hBitmap2, BT_HDC_BITMAP  , @BTstruct)     
     
 	BT_DrawGradientFillVertical ( hDC,   0 , 0  , nWidthBmp ,  40 , { 9, 125 , 155 } ,{3,48,58} )
 	
   	
  nTypeText    := BT_TEXT_TRANSPARENT 
   	  //+ BT_TEXT_BOLD   
  nAlingText   := BT_TEXT_LEFT + BT_TEXT_TOP
  nOrientation := BT_TEXT_NORMAL_ORIENTATION
  BT_DrawText (hDC, 8, 4 , alltrim(cTexto) , "arial", 9, WHITE, WHITE, nTypeText, nAlingText, nOrientation)
   	
   
  BT_DeleteDC (BTstruct)

 		If !_isControlDefined('Image_5' , 'fSplit2' ) 		
 		   
       @ 1,nColx - 1 IMAGE Image_5 OF fSplit2 PICTURE NIL WIDTH nWidthBmp HEIGHT 40 STRETCH ACTION ShowJan( cTexto )
       @ 1,nColx+nWidthBmp - 1 IMAGE &cImgName OF fSplit2 PICTURE "Img\Closex.bmp" WIDTH 20 HEIGHT 40 STRETCH ACTION FechaJan( This.Name , .t. )     
       
       //msginfo('cr')
                
   Else   
      
       SetProperty('fSplit2','Image_5','Visible', .t.)
       SetProperty('fSplit2',cImgName,'Visible', .t.)
   
       SetProperty('fSplit2','Image_5','Col',nColx - 1)          
       SetProperty('fSplit2',cImgName,'Col',nColx+nWidthBmp - 1)   
       
   End If       
   
   BT_HMGSetImage ("fSplit2", "Image_5",   hBitMap2, .t.)        
   bt_BitMapSaveFile( hBitMap2 , "e1.Bmp" )
   
  // BT_DeleteDC ( hDc )        
   
Return    


Function VisibleLbl(lVisible)

 Local cMenuName := 'fSplit2'
 Local cLabelx
 Local n1
 
 Default lVisible := .f.
 
  For n1 := 1 To Len(aButTop)   
     
       cLabelx := "LblUp" + StrZero(n1,4)
           
       If _IsControlDefined( cLabelx, cMenuName )
           SetProperty(cMenuName , cLabelx , "Visible" , lVisible )        
       End If
      
  Next 


Return

Function lVertScrol( lVisible )

   Local nLeft := GetProperty('Main','Width' )

  SetProperty('fSplit10', 'imgEsquerda','Visible', lVisible )
  SetProperty('fSplit10', 'imgDireita','Visible', lVisible )
  
  
  
  
  If lVisible 
     SetProperty("fSplit10","Image_1",  "Visible" , .f.)
  Else
  	 SetProperty("fSplit10","Image_1",  "Visible" , .t.)
  End If     
  
    

Return

Function ChkJan()



Return

Function ScrolVert(nDirecao)
  
   Local ncumt := (32 +    (130 * Len(aButTop) ))
   
   if lTracking6
      //msginfo('Travado')
   End If
   
   If nDirecao == 1      
      //msginfo(Str( nacumz ) + ' ' + Str(ncumt) )
      
      If nacumz > ncumt
        //msginfo('tingido')
      Else
        nColScrool +=  130
        nacumz     +=  130 
      End If
      
   Else   
   
       If nacumz > GetProperty('fSplit2','Width')
     		  nColScrool -= 130
          nacumz     -=  130  
       Else
          nacumz := GetProperty('fSplit2','Width')
          // msginfo('tingido')
       End If
       
       
       //msginfo(Str( nacumz ) + ' ' + Str(ncumt) )
   End If	  
   
   //SysWait(.4)
   
   _HMG_PRINTER_SETHSCROLLVALUE( GetFormHandle(  'fSplit2'  )  , nColScrool)
  
Return


function TestBut()

  aButTop := {}
  aAdd( aButTop ,  { 0 ,  "Clientes"	 , { ||      Nil    } } )  
  aAdd( aButTop ,  { 0 ,  "Fornecedores"	 , { ||      Nil    } } )  
  aAdd( aButTop ,  { 0 ,  "Teste 03 AAAAA"	 , { ||      Nil    } } )  
  aAdd( aButTop ,  { 0 ,  "Teste 04"	 , { ||      Nil    } } )  
  aAdd( aButTop ,  { 0 ,  "Teste 05"	 , { ||      Nil     } } )  
  aAdd( aButTop ,  { 0 ,  "Teste 06"	 , { ||      Nil     } } )  
  aAdd( aButTop ,  { 0 ,  "Teste 07"	 , { ||      Nil     } } )  
  aAdd( aButTop ,  { 0 ,  "Teste 08"	 , { ||      Nil    } } )  
  aAdd( aButTop ,  { 0 ,  "Teste 09"	 , { ||      Nil     } } )  
  
  aAdd( aButTop ,  { 0 ,  "Teste 10"	 , { ||      Nil     } } )  
  aAdd( aButTop ,  { 0 ,  "Teste 11"	 , { ||      Nil     } } )  
  aAdd( aButTop ,  { 0 ,  "Teste 12"	 , { ||      Nil     } } )  
  
  //HMG_ChangeWindowStyle(GetFormHandle('fSplit2'), NIL, WS_BORDER, .F., .T.)
  //HMG_ChangeWindowStyle(GetFormHandle('fSplit2'),  NIL , WS_EX_CLIENTEDGE,  .F., .F.)
  
  //HMG_ChangeWindowStyle ( GetFormHandle('fSplit2') ,  NIL , WS_THICKFRAME ,  .F., .f.)
  
  
  //HMG_ChangeWindowStyle(GetFormHandle('fSplit2') , NIL,WS_EX_CLIENTEDGE/*WS_BORDER*/, .F., .T.)
  //HMG_ChangeWindowStyle(GetFormHandle('fSplit2'),  NIL , WS_STATICEDGE,  .F., .F.)
//  RedrawWindow(GetFormHandle('fSplit2'))
  
  //SysWait(.4)
  //DoMethod('fJanSelected','show')
  //msginfo('lp')
  //HMG_ChangeWindowStyle(GetFormHandle('fJanSelected'), WS_EX_STATICEDGE, NIL, .T., .T.)
  
   //nColScrool := 0
   nacumz := GetProperty('fSplit2','Width')
   
  ButtonsTop( .t.)
 // lVertScrol( .t. )
  //RefreshAll('fSplit2')
 // msginfo('ok')


Return

Function EventLbl( cLabel )

   MsgInfo(cLabel)
   
REturn


Function LeaveBut(aAr1 , cJan)
  
  Local nHan
  Local n1

  For n1 := 1 To Len(aAr1)
      nHan :=  OBTN_Handle( cJan, aAr1[n1][1] )
      PostMessage( nHan , WM_MOUSELEAVE, 0, 0)     
      Do Events
      
      //msginfo('l')
  Next    

Return


Function  EventTopButton()

   //STATIC lTracking2 := .F.

   LOCAL  nHWnd   := EventHWND()
   LOCAL  nMsg    := EventMSG()
   LOCAL  nWParam := EventWPARAM()
   LOCAL  nLParam := EventLPARAM()

   LOCAL nind1
   LOCAL nIdBut := 0

   LOCAL n1   
   Local cFormx := 'fSplit2'   
   LOCAL ButHnd
   

   For n1 := 1 TO Len( aButTop )

      If ( OBTN_Handle( cFormx, aButTop[ n1 ][ 1 ] ) == nHWnd )
         nIdBut := aButTop[n1 ][ 1 ]        
      End If
      
   Next
   
   IF ( nIdBut > 0 )
   
       //msginfo('nf222')

      If ( nMsg == WM_MOUSEMOVE ) .and. (!lTracking2)
          //.and. (!lTracking2)

         lTracking2 := TrackMouseEvent( nHWnd ) // TME_LEAVE is default flag

         OBTN_Color( cFormx, nIdBut,  aBtnSl , .T. )
         OBTN_Enable( cFormx, nIdBut, .T. )
         //OBTN_Visible( cFormx, nIdBut, .T. )
         //msginfo('move')
         

      End If

      If ( nMsg == WM_MOUSELEAVE )
         
         ShowBut( cFormX , nidBut )      

         lTracking2 := .F.

      End If
      
   ELSE

   END IF

RETURN

Function ShowBut( cForm1 , nidBut1 )

  	OBTN_Color( cForm1,  nIdBut1,  aBtnCorSl , .T. )
    OBTN_Enable( cForm1, nIdBut1,   .T. )
    OBTN_Visible( cForm1 , nIdBut1, .T. )

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
					        WIDTH     fsplit6.Width - 5
			            HEIGHT    nItemHeight
			            FONTNAME  'Arial'
			            FONTSIZE  10
					        VALUE     '         '  + Padr(Alltrim(hb_ansiToOem(aOpcoes[n1])),70) + '                  '
					        ALIGNMENT Left
					        TRANSPARENT .f.
					        FONTCOLOR FONTCOR
	        				BACKCOLOR {229,237,242}
					        
		       END LABEL





		       
		       //msginfo('f1')
		       
		       nRow+=nItemHeight
		       
		       nHnd1 := GetProperty(cJan , cLbl  , "HANDLE")
		       
		       //msginfo(hb_ansiToOem(aOpcoes[n1])  )
		       
		       EventProcessAllHookMessage(EventCreate({ || LabelEventHandler(aOpcoes) }, nHnd1  ), .T.)		  
	         //SetHandCursor( nHnd1, "Finger.cur" )      
	    
		       
		   Else		   
		         SetProperty( cJan ,cLbl  ,"Visible",.t.)                                  		                     
		         DoMethod(cJan , cLbl ,"Show" )       		         
		       		   
		   End If   						   
  
  Next
  
   Refreshall('fSplitSubMenu')
	 //Refreshall('fSplit6')


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
        
        SetProperty(cForm, cControl, "BACKCOLOR", {255,255,255} )      
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
            nLin += (nTam+nitemHeight)+2
            lPula := .f.
        End If		
        
        //msginfo(cForm)
        
        SetProperty(cForm,cControl,'Row' , nLin)        
        DoMethod( cForm , cControl ,'Refresh' )
        
        
        If nOpSel > 0
        		If N1 == nOpSel
        		  
        			 
        			 SetProperty(cForm, cControl, "BACKCOLOR", {229,237,242}  )
        	 		 SetProperty(cForm, cControl, "FONTBOLD", .T.)        
        	 		 
         			 SetProperty(cForm,'Image1' , 'Visible' , .t.)        
        			 SetProperty(cForm,'Image1' , 'Col' , 0)        
        			 SetProperty(cForm,'Image1' , 'Row' , nLin)              			       			 
        			 
        			 
           		 lPula := .t.
           		 
        		End If
        End If
        
        //msginfo(cControl)        
        
    Next

Return


/////////////


FUNCTION LabelEventHandler(aLabel)
  STATIC lTracking27 := .F.
  LOCAL  nHWnd   := EventHWND()
  LOCAL  nMsg    := EventMSG()
  LOCAL  nWParam := EventWPARAM()
  LOCAL  cControl
  LOCAL  cForm
  Local cName
  Local lok := .f.
  Local cop2 := ''

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
      
      //msginfo('lp')
      //msginfo(cControl )
      
      nHanSelected := nHWnd
      
      If (alltrim(cControl) = 'Img_seta1')      
         ScrTest(1 , nContItens  )
         Return Nil
      End If
      
      If (alltrim(cControl) = 'img_seta2')      
         ScrTest(2 , nContItens )
         Return Nil
      End If      

      nacumz := GetProperty('fSplit2','Width')      
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
      
      
      //If (Alltrim(cOpcao) $ "Importar.Consultas")
      
       If (Ascan(aOpcoes , {|a| Alltrim(a[1]) == Alltrim(cOpcao) } ) > 0)
      
         SetWindowControlsVisible( 'fSplitSubMenu' , .f. )
         
         //msginfo('Fechar')
         
         nTop   := GetProperty(cForm, cControl, "Row")          
         cDesc := GetProperty(cForm, cControl, "Value") 
         
         If (Alltrim(cDesc) == Alltrim(cOpAberto))         
             
             cOpAberto := ''
             SetProperty(cForm,'Image1' , 'Visible' , .f.) 
             SetProperty('fSplit6','Image4' , 'Visible' , .f.) 
             
             RestMenu(1 , 0  , GetProperty('fSplitSubMenu' , 'Height') , 0 )
             DoMethod('fSplitSubMenu' ,'Hide' )         
             OffSeta()
             
            // msginfo('Fechar')
         
         Else
         
         		 nIndice := Ascan(aOpcoes , { |a|  Alltrim(a[1]) == Alltrim(cDesc) } )
         		 
         		 If nIndice <= 0
         		    msginfo('Falha em System 0')
         		    Return
         		 End If
         		 
         		 //msginfo('aqui')
         		 
         		 OffSeta()
         		 SetProperty('fSplit6',"Image4","Visible",.f.)
         		 
         		 nContItens := 0
         		 Aeval(aItens , { | a | Iif( Left(a[1],1) == Alltrim(Str(nindice)) , nContItens++ , Nil ) } )        
         		 
         		 //msginfo(Str(nContItens))
         		 
         		 If nContItens > nItemMax
         		    SetProperty('fSplitSubMenu' , 'Height',195)       
         		    nItemSel := nItemMax  		    
         		 Else
         		 	  SetProperty('fSplitSubMenu' , 'Height', (17 * nContItens)+2 )
         		 End If
         		 
         		 nLinRow := nTop + 15 +  GetProperty('fSplit6' , 'Row') + 28
         		 nLinRow :=  60 + ((nIndice + 1)  * nItemHeight) 
         		 
         		 //msginfo(str(nLinRow) + '   ' + str(nContItens) )
         		 
         
             If (nIndice < Len(aOpcoes))
                 nLinex1 := aOpcoes[nIndice][4] + GetProperty('fSplitSubMenu' , 'Height')   
                 
                 nIncremento := 0
                             
                 If (nContItens > nItemMax)
                     nIncremento := 32
                 End If            
		             
		             RestMenu(1 , nLinex1 , GetProperty('fSplitSubMenu' , 'Height')+nIncremento , nIndice )
		             
		         End If		        	         		         
		         
		         Do Events
         
         	   DoMethod('fSplitSubMenu' ,'Hide' )   	         
		         
		         cOpAberto := Alltrim(cDesc)
		         
		         aOpx1 := {}         
		         
		         Aeval(aItens , { | a | Iif( Left(a[1],1) == Alltrim(Str(nindice)) , Aadd(aOpx1,Right(a[1],Len(a[1]) - 2) ) , Nil ) } )         
		         
		         
		         
		         If (nContItens > nItemMax)
		             PutSeta(    nTop+17 ,  (nTop+17 ) +  GetProperty('fSplitSubMenu' , 'Height')+17 )		  
		                        
                 SetProperty( 'fSplitSubMenu' , 'Row', (nLinRow - 2)+18  )		         
		         
		         Else
		         		 SetProperty( 'fSplitSubMenu' , 'Row', nLinRow - 2 )
		         End If
		         
		         
		         
		         SetProperty( 'fSplitSubMenu' , 'Col', 1)		         
		         SetProperty( 'fSplitSubMenu' , 'Width', fSplit6.Width - 4 )
		         
		         ShowScrollBar( GetFormHandle( 'fSplitSubMenu' ), 0, .F. )
		         
		         ShowScrollBar( GetFormHandle( 'fSplitSubMenu' ), 1, .F. )		         
		         		         
		         DoMethod('fSplitSubMenu' ,'Show' )
		          
		         Do Events
		         SetProperty('fSplit6',"Image4","Visible",.f.)
		         
		         nLinhax := OpMenu( aOpx1 , 'fSplitSubMenu' , 0  , '' )	         
         
         End If
         
         //RefreshAll('fSplitSubMenu')
         
      
      End If
      
      
      If Alltrim(cOpcao) == 'Arquivo Sped'
         //msginfo('ok')
         //yAviso( 'ok', .t. )
         
         ImpSped()
         
         
      End If
      
      
      If alltrim(cOpcao) == 'Clientes'
         
                       
          If ( FindWindowEx( ,, ,'Cadastro de Clientes'  ) > 0 )
      			 yAviso( 'Este Cadastro ja esta Ativo.' )
      			 RefreshAll('fSplitSubMenu')      			 
   			 Else
   			 
//		   			 lTracking := .F.
		   			 
		   			 If Len(aButTop) > 0
		   			   	ReleaseTeto()   	
		   			 End If		 
		   			 
		   			 cActiveJan  := "FClien"
		   			  
		   			 aAdd( aButTop ,  { 0 ,  "Clientes" , .t.  }     )  
		   			 nCol1 := ButtonsTop( .t. )  			    		
		   		   
		   		   lok := .t.  
		   		   
		   		   cOp2 := 'Clientes'		   			   		   
		   			    			
		  			 CadCli(  nHWnd ,  aLabel)  
  			 
  			 End If

      End If      
      
      

    CASE WM_RBUTTONDOWN
     // SetFocus(nHWnd)
     // LabelSetBorder(aLabel, nHWnd)
     /// msginfo('rrr')
     // EXIT

    CASE WM_MOUSEMOVE
    
        
   
      IF ! lTracking27             
         
        If Left(Upper(cControl),4) == 'IMG_'
           //msginfo('ok')
           
           If cControl == 'Img_seta1'              
              If alltrim(Upper(GetProperty(cForm , cControl , 'picture' ))) = Upper("img\setab2.png")               
		           	 SetProperty(cForm , cControl , 'picture' , 'img\Setab22.Png' )		          
		          End If        
           End If
           
             If cControl == 'img_seta2'          
                If Upper(alltrim(GetProperty(cForm , cControl , 'picture' ))) = Upper("img\setac2.png")
					      	 SetProperty(cForm , cControl , 'picture' , 'img\Setac22.Png' )					              
					      End If		
      			 End If
      			 
      			 lTracking27 := TrackMouseEvent(nHWnd) //TME_LEAVE is default flag                
      			 
      			 Return
           
        Else      	
        
         
		        If Alltrim(Left(cControl,3)) = 'Mnx' 
		        
		           SetProperty(cForm, cControl, "BACKCOLOR", {216,228,236} )           		    
		           SetProperty(cForm, cControl, "FONTBOLD", .f.)               
		           
		           SetProperty('fSplit6',"Image4","Visible",.f.)
		           //msginfo('ok')
		           
		           If Alltrim(GetProperty(cForm, cControl,"Value")) = 'Arquivo Sped'
		              SetToolTip ( nHWnd  ,  hb_AnsiToOem("Realiza o processo de importação do arquivo Sped.") ,  GetFormToolTipHandle (cForm)  )       
		           End If   
		            
		                
		        Else
		        
		           nlinha1 := GetProperty(cForm, cControl , "Row") 
		           
		        	 SetProperty(cForm, cControl, "BACKCOLOR", {216,228,236})
		        	 SetProperty(cForm, cControl, "FONTBOLD", .T.)        
		        	 
		        	 If Empty(cOpAberto)
		        	 		 SetProperty(cForm,"Image4","Visible",.f.)
		        	 		 
		        	 		 SetProperty(cForm,"Imagem3","Visible",.t.)
		        	 	   SetProperty(cForm,"Imagem3","Row",  nLinha1 )
		        	     SetProperty(cForm,"Imagem3","Col", 0)       	 
		        	 Else
		        	 		 //SetProperty(cForm,"Imagem3","Visible",.f.)
		        	 		 
		        	 		 SetProperty(cForm,"Image4","Visible",.t.)
		        	 	   SetProperty(cForm,"Image4","Row",  nLinha1 )
		        	     SetProperty(cForm,"Image4","Col", 0)       	 
		        	 		 
		        	 		 
		        	 End if
		        	 
			         
			      End If 
			      
			      lTracking27 := TrackMouseEvent(nHWnd) //TME_LEAVE is default flag                
			      
			 Endif     
	      
	     //lTracking := TrackMouseEvent(nHWnd) //TME_LEAVE is default flag                
        
				
     ENDIF
      
      EXIT

    CASE WM_MOUSELEAVE
   
      
      If cControl == 'Img_seta1'
      		If alltrim(Upper(GetProperty(cForm , cControl , 'picture' ))) = Upper("img\setab22.png")     
		      		SetProperty(cForm , cControl , 'picture' , 'img\Setab2.Png' )		    
		      End If		
		      lTracking27  := .f.        
		      Return Nil
      End If
      
       If cControl == 'img_seta2'
       		If alltrim(Upper(GetProperty(cForm , cControl , 'picture' ))) = Upper("img\setac22.png")     
		      		SetProperty(cForm , cControl , 'picture' , 'img\Setac2.Png' )		      
		      End If		
		      lTracking27  := .f.
		      Return Nil    
      End If
    
      If Alltrim(cControl) = 'LblTitMenu'
      
      	SetProperty(cForm, cControl, "TRANSPARENT", .T.)            
      	SetProperty(cForm, cControl, "FONTBOLD", .t.)            
      
      Else
      
							cOpcao2 := GetProperty(cForm, cControl, "CAPTION" )
							
							If !Empty(cOpAberto)
							    //MSGINFO('l')
									If Alltrim(cOpcao2) != Alltrim(cOpAberto)
									
									    cName := GetProperty(cForm, cControl , "NAME")
									
									    SetProperty(cForm, cControl, "BACKCOLOR", {255,255,255} )											
											SetProperty(cForm, cControl, "FONTBOLD", .F.)
											
											
									End If
							Else
							
										SetProperty(cForm, cControl, "BACKCOLOR", {255,255,255})
										
										//BACKCOLOR {255,255,255}
										SetProperty(cForm, cControl, "FONTBOLD", .F.)
										//Image1
										If cForm == 'fSplit6'												
												SetProperty(cForm,"Image4","Visible",.f.)
												SetProperty(cForm,"Imagem3","Visible",.f.)
												SetProperty(cForm,"Image1","Visible",.f.)												
										End If
										
										Do Events
		
										
							End If
      
      End If
      
      lTracking27  := .f.        
      
      //msginfo(Alltrim(cControl))
      
      
      
      //PostMessage( fSplit2.LblTitmenu.Handle , WM_MOUSELEAVE, 0, 0)     
      //Msginfo('x0101')
      
      lTracking27 := .F.
      EXIT
      
  ENDSWITCH
  
  

RETURN NIL

Function RetIndJan()

  Local nI1 := Ascan(aButTop , {|a|  ('F' + Left(a[2],5)) ==  (Alltrim(cActiveJan))    } )
  
  //Aeval(aButTop , { |b| msginfo(cActivejan + '  ' + b[2]) } )  
  
  If nI1 <= 0
    // msginfo('ind jan Não Localizado')
  End If
  
  //msginfo(StrZero( nI1 , 4))
  
Return StrZero( nI1 , 4)  

Function MenuPrin(lVisible)

   SetProperty("fSplit6","Cadastros","Visible",lVisible)
   SetProperty("fSplit6","Movimentos","Visible",lVisible)
   SetProperty("fSplit6","Relatorios","Visible",lVisible)
   SetProperty("fSplit6","Parametros","Visible",lVisible)
   
   DO EVENTS

Return


Function PutSeta( nLin1  , nLin2 )

   Local lVisible := .t.

   SetProperty("fSplit6","img_seta1","Visible",lVisible)
   SetProperty("fSplit6","img_seta2","Visible",lVisible)
   
   SetProperty("fSplit6","img_seta1","Row",nLin1)
   SetProperty("fSplit6","img_seta2","Row",nLin2)

Return 

Function OffSeta()

  Local lVisible := .f.

  SetProperty("fSplit6","img_seta1","Visible",lVisible)
  SetProperty("fSplit6","img_seta2","Visible",lVisible)

Return

Function ScrTest( nDir , nTamanho )
  Local nIncre := 16
  
  If nDir == 1
  
      If nItemSel = nTamanho         
         Return
  		End If  
  
  	 nLinSc := nLinSc+nIncre
  	 nItemSel := nItemSel + 1
  	 
  	 SetProperty('fSplit6' , 'img_seta2' , 'picture' , 'img\Setac2.Png' )	
  	 //msginfo(Str(nItemSel)  + ' ' + str(nTamanho) )
  	 
  	 
  	  If nItemSel = nTamanho
         //msginfo('Tamanho maximo atingido!')
          SetProperty('fSplit6' , 'img_seta1' , 'picture' , 'img\setab2d.Png' )	
        // Return
  		End If
  	 
  Else  
     
     If nItemSel > nItemMax
     
        SetProperty('fSplit6' , 'img_seta1' , 'picture' , 'img\Setab2.Png' )	
        
     		nLinSc := nLinSc-nIncre
     		nItemSel := nItemSel - 1
     		//msginfo(nItemSel)
     		
     		If nItemSel = nItemMax
     		 	 SetProperty('fSplit6' , 'img_seta2' , 'picture' , 'img\setac2d.Png' )	 	
     		End If     		
     		
     Else
        //msginfo('Topo atingido!')      
        SetProperty('fSplit6' , 'img_seta2' , 'picture' , 'img\setac2d.Png' )	 		
     End If
     
  End If	  
     
  _HMG_PRINTER_SETVSCROLLVALUE( fSplitSubMenu.Handle, nLinSc )
 

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

Function ShowButTop( lShow )
 
    Local n1
    Local cLabelx
    Local cImgx
    Local cImgName
    
    
     For n1 := 1 To Len(aButTop)         
         cLabelx := "LblUp" + StrZero(n1,4)
         
         cImgx := "Img_" + StrZero(n1,4)
         
         If _isControlDefined(cLabelx , 'fSplit2')
            SetProperty('fSplit2',cLabelx,'Visible', lShow )
           // DoMethod('fSplit2',cLabelx,'Hide')
            
         End If                  
         
         If _isControlDefined(cImgx , 'fSplit2')
            SetProperty('fSplit2',cImgx,'Visible', lShow )
         End If          
                 
		 Next	 
		 
		 SetProperty('fSplit2','Image_1','Visible', lShow)
		 SetProperty('fSplit10','Image_1','Visible', lShow)		 
		 
		// SetProperty('fSplit5','LblEmpresa','Visible', lShow)
		 
		 If (lVScrool)
		 		 SetProperty('fSplit10','ImgEsquerda','Visible', lShow)
		 		 SetProperty('fSplit10','ImgDireita','Visible', lShow)
		 		 //SetProperty('fSplit10','Image_1','Visible', lShow)		 
		 End If
		 
		 If !Empty(cLblSelected)
		 
		     cImgName := 'Img' + Right(cLblSelected,4)
				 If _IsControlDefined('Image_5','fSplit2')
				 		 SetProperty('fSplit2','Image_5','Visible', lShow)
		    		 SetProperty('fSplit2',cImgName,'Visible',  lShow)				    		 
		     End If
		     
     End If
		 
		 //RefreshAll('fSplit2')
		 //msginfo('nf')		 

REturn

Function D1Black(cJan,zBitMap)
   
    Local hDc
//    Local cJan 
    
    Local nRow := 0
    Local nCol := 0
    
    LOCAL Width  := BT_ClientAreaWidth  (cJan)
		LOCAL Height := BT_ClientAreaHeight (cJan)	
		
		LOCAL BTstruct 	
    
		If lAtivaBlack
		
		   hDC    = BT_CreateDC ( cJan  , BT_HDC_INVALIDCLIENTAREA, @BTstruct)			       
		   BT_DrawGradientFillVertical (hDC,  nRow  ,  nCol  ,  Width,  Height , BLACK , BLACK)    
		       
		   BT_DrawBitmapAlphaBlend (hDC, nRow ,  nCol  , nil, nil, 120 , BT_COPY  , zBitmap)        
		   
		   BT_DeleteDC ( BTstruct )      
		    
		Else
		   
		    Proc_ON_PAINT(cJan)     
		    
		End If
		

Return

fUNCTION DrawTransp(cJan , zBitMap , cTitulo , nQreg , cTitConsu , cTitFltr )

  Local hDc
  LOCAL Width  := BT_ClientAreaWidth  (cJan)
	LOCAL Height := BT_ClientAreaHeight (cJan)
	
	Local nRow := 35
	Local nCol := 0
	
	Local nRx1 := 0
	
	LOCAL BTstruct 	
	
	Local cGrid := 'Br_Grid'
	
  LOCAL cFormName := ''
  
  Local nTypeText    := BT_TEXT_TRANSPARENT 
  //+ BT_TEXT_BOLD
	Local nAlingText   := BT_TEXT_LEFT + BT_TEXT_TOP
	Local nOrientation := BT_TEXT_NORMAL_ORIENTATION							
  
  Default nQreg := 0
  
  Default cTitulo := ''
  Default CtitConsu := ''
  
  Default cTitFltr := ''
  
 
  GetFormNameByHandle ( GetActiveWindow(), @cFormName )
	
	hDC    = BT_CreateDC ( cJan  , BT_HDC_INVALIDCLIENTAREA, @BTstruct)	
	
	If lDrawMain 
	  	//hb_memowrit('cli221ok.txt', 'Transp : ' + cJan + ' ' + Str(Width) + ' ' + Str(Height) + ' rrow : ' + Str(nRow) )
	   nRow := 0
	End if
	
  
  If Flag_AlphaBlend_Effect   
  
      //msginfo('apl ' + cJan)
      
      BT_DrawGradientFillVertical (hDC,  nRow  ,  nCol  ,  Width,  Height , BLACK , BLACK)              //
      BT_DrawBitmapAlphaBlend (hDC, nRow ,  nCol  , nil, nil, 120 , BT_COPY  , zBitmap)     
      
      BT_DeleteDC (BTstruct )       

  Else     	  
  
  
       If (_isControlDefined( cGrid , cJan)) .And. (cJan = cactivejan)
       
          nZ2   := GetDeskTopHeight() - (GetProperty(cJan , cGrid ,'Row') + GetProperty(cJan , cGrid,'Height') )
       
		       nRx1 := GetProperty(cJan , cGrid ,'Row') + GetProperty(cJan , cGrid,'Height') 
		       nC1  := GetProperty(cJan , cGrid,'Col')		       
		       
		       BT_DrawGradientFillVertical (hDC,  nRx1  ,  nC1  ,  GetProperty(cJan , cGrid,'Width'),   nZ2   , {7,101,125} , {4,57,70} )              //       
		       
		       If !Empty(cTitulo)		 
		         
		       
		           //msginfo(cTitulo)
		           nColz1 := Int(  GetProperty(cJan , cGrid,'Width') / 2)  		           
							 BT_DrawText ( hDC, nRx1+27  , 300  ,  hb_ANSIToOEM( cTitulo ), "Arial", 11 , WHITE ,  BLACK, BT_TEXT_TRANSPARENT, nAlingText, nOrientation )							 
						
		       End If		       		       
		       
		       If nQreg > 0		       		        
		          BT_DrawText ( hDC, nRx1+27 ,  650   ,  "Qtde. Registros : " , "Arial", 9, WHITE,  BLACK, nTypeText, nAlingText, nOrientation )		          
		          BT_DrawText ( hDC, nRx1+27  , 785   ,  Alltrim(Str(nQReg)) , "Arial", 9, WHITE,  BLACK, BT_TEXT_TRANSPARENT , nAlingText, nOrientation )
		       End If
		       
		       If !Empty(cTitConsu)
		           BT_DrawText ( hDC, nRx1+39 ,  650    ,  "Consulta : " + cTitConsu , "Arial", 9, WHITE,  BLACK, nTypeText, nAlingText, nOrientation )		          	       
		       Else
		       
		            If !Empty(cTitFltr)
		                BT_DrawText ( hDC, nRx1+39 ,  650     ,  "Filtro : " + cTitFltr, "Arial", 9, WHITE,  BLACK, nTypeText, nAlingText, nOrientation )		          	       
		            End If    
		            
		       End If	       
		       
		       
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

//IDC_SIZENESW


HB_FUNC ( DISABLEVSCROLLBAR )
{
 EnableScrollBar ( (HWND) hb_parnl (1), SB_VERT, ESB_DISABLE_BOTH );
}

#pragma ENDDUMP




