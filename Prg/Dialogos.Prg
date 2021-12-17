#include <hmg.ch>
#include <minigui.ch>

#define WM_SETFOCUS 7


DEFINE WINDOW main
DECLARE WINDOW fSplit6

DECLARE WINDOW fDialogo

REQUEST HB_LANG_PT
REQUEST HB_CODEPAGE_PT850

Function EfectEnd(cFname1)

   Local lEfect := .t.

   If (lEfect)
      Grayness_effect_End( cFName1 )      
   End If   
   
   //cDiaName := cSave1   
     
   lAtivaBlack := .f.
   //
 
Return

Function yEfect(cFormName , lEfect)

   LOCAL cControl := ''
   LOCAL cForm    := ''
   //LOCAL cFormName := ''
   Local cSave1    := cDiaName 
   
   *// MsgRun

   
   Default lEfect := .t.
   
   cDiaName := 'fProgress'

  
   //GetFormNameByHandle ( GetActiveWindow(), @cFormName )   
     
   lAtivaBlack := (Alltrim(cFormName) != "Main" )
   
   BT_BitmapRelease (hBit10)
   BT_BitmapRelease (hBit11)  
   BT_BitmapRelease (hBit12)    
   BT_BitmapRelease (hBit20)     
  
   CaptTelas()        
  

   If (lEfect)       
       //MsgInfo('2 ' + cFormName)
       Flag_AlphaBlend_Effect := .T.
   	   Grayness_effect_start(  cFormName )
   	   ShowButTop( .f. )  
   	   //msginfo('2 ' + cFormName)
   Else 
      lativaBlack := .f.	   
   End If	   
  
REturn





Function yRun(  cMsg1 , bBlock , lEfect , cFormName)  

   cDiaName := 'fProgress' 
   
   xMsgRun( cMsg1 , bBlock )
  
Return

FUNCTION yAviso( cMsgx1 , lEfect )

   LOCAL cControl := ''
   LOCAL cForm    := ''
   LOCAL cFormName := ''
   Local cSave1    := cDiaName 
   
   Default lEfect := .t.
   
   cDiaName := 'fDialogo'
   

  
   GetFormNameByHandle ( GetActiveWindow(), @cFormName )   
     
   lAtivaBlack := (Alltrim(cFormName) != "Main" )
   
   BT_BitmapRelease (hBit10)
   BT_BitmapRelease (hBit11)  
   BT_BitmapRelease (hBit12)    
   BT_BitmapRelease (hBit20)     
  
   CaptTelas()        
  

   If (lEfect)       
       Flag_AlphaBlend_Effect := .T.
   	   Grayness_effect_start(  cFormName )
   	   //msginfo('f ' + cformName)
   	   ShowButTop( .f. )  
   Else 
      lativaBlack := .f.	   
   End If	   

   msgAviso( cMsgx1 , 1 )
   
   If (lEfect)
      Grayness_effect_End( cFormName )
   End If   
   
   cDiaName := cSave1   
     
   lAtivaBlack := .f.
   //
   If !ResButSel()
      ShowButTop( .t. )   
   End If
   
  
RETURN


FUNCTION ConfirmAviso( cMsgx1,  cJanPadrao , cExtra1 , bBlock , lEfect )

   LOCAL cControl := ''
   LOCAL cForm    := ''
   LOCAL cFormName := ''
   LOCAL lOk := .F.
   Local cSalvad := cDiaName
   
   Private BlockRun := Nil
   
   PRIVATE lRetx := .F.
   cDiaName := 'fDialogo'
   
   Default cJanPadrao := 'Main'
   Default cExtra1 := ''
   Default bBlock := Nil
   DEfault lEfect := .t.
 
   cFormName := cJanPadrao
     
   lAtivaBlack := (Alltrim(cFormName) != "Main" )
   
   BT_BitmapRelease (hBit10)
   BT_BitmapRelease (hBit11)  
   BT_BitmapRelease (hBit12)    
   
  // BT_BitmapRelease (hBit20)  
  
  //msginfo('lp22')
   
   
   If Empty(alltrim(cExtra1))
      CaptTelas()       
   Else      
      CaptTelas(cExtra1)
   End If    
   


   Flag_AlphaBlend_Effect := .T.
   
   
   If (bBlock != Nil)     
      Eval(bBlock , .f.)         
   End If
   
   If lEfect  
       
		   Grayness_effect_start(  cFormName )  
		  
		   ShowButTop( .f. )  
		   
		   If !Empty(alltrim(cExtra1))
		       SetWindowControlsVisible(cExtra1 , .f. )
		       BT_ClientAreaInvalidateAll (cExtra1) 
		   End If    
		   
		   
	 End If        
	 
   msgAviso( cMsgx1, 2 )


   Grayness_effect_End(  cFormName )
 
   
   lAtivaBlack := .f.
     
    
   //lAtivaBlack := .f.
   //ShowButTop( .t. )         
   
   //msginfo('ira hide22')
   
   If !ResButSel()
       ShowButTop( .t. ) 
   End If
   
   If !Empty(cExtra1)
       BT_ClientAreaInvalidateAll (cExtra1) 
   End If
   
   If (bBlock != Nil)
        Eval(bBlock , .t.)   
   End If
   
   cDiaName := cSalvaD
   
RETURN lRetx




FUNCTION xMsgRun( cMsg1  , bBlock )

   PRIVATE cJanxDialog := 'fDialogo'
   
   Private BlockRun := bBlock

   DEFAULT cMsg1 := ''
 //  DEFAULT nTipo := 1

   PRIVATE cBmpx1 :=  "img\aviso1.bmp"

   PRIVATE cMensagem := cMsg1

   PRIVATE lRet := .F.


   Load Window fProgress
   
   //SetProperty('fDialogo','Progress1','Visible' , .t.)
   

   Center Window fProgress

   //SetProperty( "fDialogo", "lblMsg", "Value",  hb_ANSIToOEM(    AllTrim( cMsg1 )  )     )
   
   Activate Window fProgress

RETURN lRet




Static FUNCTION MsgAviso( cMsg1, nTp1 )

   PRIVATE cJanxDialog := 'fDialogo'

   //cMsg1 := ''
   nTipo := nTp1
   
   Private BlockRun := Nil

   PRIVATE cBmpx1 := iif( nTipo == 1, "img\exclamation2.bmp", "img\pergunta1.bmp" )

   PRIVATE cMensagem := iif( nTipo == 1, "Aviso", "Confirme Para Prosseguir" )

   PRIVATE lRet := .F.


   Load Window fDialogo

   Center Window fDialogo
   
   //msginfo( cMsg1 )
   
   

   SetProperty( "fDialogo", "lblMsg", "Value",  hb_AnsiToOem(    AllTrim( cMsg1 )  )     )
   
   //SysWait(.2)
   
   
   Activate Window fDialogo    

RETURN lRet

Function RlesaBt()

  Local n1
  
  For n1 := 6652 to 6554
      Obtn_Release('fDialogo',n1)
  Next


Return


FUNCTION xIniDialog( nTp )

   LOCAL cJanx 
   LOCAL nFontSize := 8
   
   //:= cJanxDialog
   
   HB_SetCodePage( "PT850" )
   
   
   If (nTp == 1) .Or. ( nTp == 2 )
   
       cJanx := cJanxDialog
       
		   If nTp == 1		   
		   
		
		      OBTN_Create( cJanxDialog, 6652, "Ok", 185, 245,  62,  24,  .T., .T., .T.,  8, RetColor1( 1 ), aBtnFont )
		      OBTN_Font( cJanxDialog, 6652,  { cFontName, nFontSize, .F., .F., .F., .F. } )
		
		      EventProcessAllHookMessage( EventCreate( {|| InputEv2(cJanx ) },    OBTN_Handle( cJanx, 6652 )   ), .T. )
		
		   Else
		
		      OBTN_Create( cJanx, 6653, "Sim", 185, 375,  62,  24,  .T., .T., .T.,  8, RetColor1( 1 ), aBtnFont )
		      OBTN_Create( cJanx, 6654, hb_ANSIToOEM( "Não" ), 185, 435,  62,  24,  .T., .T., .T.,  8, RetColor1( 1 ), aBtnFont )
		
		      OBTN_Font( cJanx, 6653,  { cFontName, nFontSize, .F., .F., .F., .F. } )
		      OBTN_Font( cJanx, 6654,  { cFontName, nFontSize, .F., .F., .F., .F. } )
		
		      EventProcessAllHookMessage( EventCreate( {|| InputEv2(cJanx ) },    OBTN_Handle( cJanx, 6653 )   ), .T. )
		      EventProcessAllHookMessage( EventCreate( {|| InputEv2(cJanx ) },    OBTN_Handle( cJanx, 6654 )   ), .T. )
		
		   End If
   End If
   
   
   If (nTp = 5)
   
      cJanx    := 'fProgress'
      cDiaName := cJanx
   
       OBTN_Create( cJanx , 6670 , "Cancelar", 125, 265 ,  62,  24,  .T., .T., .T.,  8, RetColor1( 1 ), aBtnFont )
		   OBTN_Font( cJanx   , 6670 ,  { cFontName, 8 , .F., .F., .F., .F. } )
		
		   EventProcessAllHookMessage( EventCreate( {|| InputEv2(cJanx ) },    OBTN_Handle( cJanx, 6670 )   ), .T. )   
   
   
   End If
   
   
   //msginfo('here')

   //InstallEventHandler( "EventDl1" )

RETURN



FUNCTION EventDl1( nHWnd, nMsg, nWParam, nLParam )

   LOCAL nID
   LOCAL ButHnd
   LOCAL nRow, nCol
   LOCAL nind1
   LOCAL cMenuName := cDiaName
   Local cForm
   Local cControl


   IF !_IsWindowDefined ( cMenuName )
      Return
   END IF
  

   IF nHWnd == GetProperty(  cMenuName, "HANDLE" )


      IF nMsg == WM_DRAWITEM

         IF ( nWParam >=  6652 ) .AND.  ( nWParam <=  6670 )
            OBTN_Draw( nHWnd,  nwParam, nLParam )
         END IF
         
         IF ( nWParam >=  50 ) .AND.  ( nWParam <=  60 )
            OBTN_Draw( nHWnd,  nwParam, nLParam )
         END IF


      END IF

      IF nMsg == 273
      
         nID := LoWord( nWParam )
      
         If ((nId >= 50) .And. (nId <= 60))
         
             nIe1 := Ascan(aRotHnd , { |a|a[1] == nId } )
             
             If (nIe1 > 0)             
                                  
                 PushButton( aRotHnd[nIe1][3]  , nId )
                 SysWait(.2)
                 Eval( aRotHnd[nIe1][2]  )             
                 
             End If
         
         End If

         

         IF nID == IDOK
            nID := GetDlgCtrlID( GetFocus() )
         ENDIF

         IF nId == 6652
             
            _ReleaseWindow("fDialogo")
            // Do Events
         END IF

         IF nId == 6653
           
            lRetx := .T.
            _ReleaseWindow("fDialogo")    
            
            //DoMethod("fdialogo","Hide")
            
         END IF

         IF nId == 6654
             lRetx := .F.           
             _ReleaseWindow("fDialogo")            
            //DoMethod("fdialogo","Hide")
         END IF

         IF nId == 6601
          
         END IF
         
         IF nId == 6670
            xStop1()       
         END IF



      END IF

   END IF

RETURN

FUNCTION InputEv2( cJan1 )

   STATIC lTracking45 := .F.

   LOCAL  nHWnd   := EventHWND()
   LOCAL  nMsg    := EventMSG()
   LOCAL  nWParam := EventWPARAM()
   LOCAL  nLParam := EventLPARAM()

   LOCAL cFormx := 'fDialogo'
   
   LOCAL nind1
   LOCAL nIdBut := 0

   LOCAL n1
   LOCAL ButHnd
   
   //DEFAULT cFormx := 'fDialogo'

   // LOCAL n1
   If (Alltrim(cJan1) = "fDialogo")
		   FOR n1 := 6652 TO 6659
		      IF ( OBTN_Handle( cFormx, n1 ) == nHWnd )
		         IF nIdBut == 0
		            nIdBut := n1
		         END IF
		      END IF
		   NEXT
   End If
   
   
   If (Alltrim(cJan1) = "fProgress")
       
       IF ( OBTN_Handle( 'fProgress' , 6670 ) == nHWnd )
          nIdBut := 6670                 
       End If   
   
   End If
   
   
   If (alltrim(cJan1) != "fDialogo")
   
		    FOR n1 := 1 TO 100
		      IF ( OBTN_Handle( cJan1, n1 ) == nHWnd )
		         IF nIdBut == 0
		            cFormx := cJan1		            
		            nIdBut := n1
		         END IF
		      END IF
		   NEXT
   End If
   


   IF ( nIdBut > 0 )
   
     

      If ( nMsg == WM_MOUSEMOVE ) .And. (!lTracking45)

         lTracking45 := TrackMouseEvent( nHWnd ) // TME_LEAVE is default flag

         OBTN_Color( cFormx, nIdBut, RetColor1( 2 ), .T. )
         OBTN_Enable( cFormx, nIdBut, .T. )
         OBTN_Visible( cFormx, nIdBut, .T. )         
       

      End If

      IF ( nMsg == WM_MOUSELEAVE )

         OBTN_Color( cFormx,  nIdBut, RetColor1( 1 ), .T. )
         OBTN_Enable( cFormx, nIdBut, .T. )
         OBTN_Visible( cFormx, nIdBut, .T. )

         lTracking45 := .F.

      END IF
      
   ELSE

   END IF

RETURN

Function xWaitMsg( cText1 ,bBlock )

    Private BlockRun := bBlock

    Load Window fWaitMsg
    
    fWaitMsg.Lblmsg1.Value := Alltrim(cText1)
    
    Center Window fWaitMsg
    
    Activate Window fWaitMsg


REturn



FUNCTION InitDlg( aHandle, nTp1 )

   xIniDialog( nTp1 )
   
   //msginfo('2')

   HMG_ChangeWindowStyle( aHandle, WS_EX_DLGMODALFRAME, NIL, .T., .T. )
   HMG_ChangeWindowStyle( aHandle, WS_EX_STATICEDGE, NIL, .T., .T. )
   
   
   If (BlockRun != Nil)      
      Eval(BlockRun)
   End If
   
   //msginfo('3')

RETURN

FUNCTION RetColor1( nInd1, nModel )

   LOCAL aColor := {}

   LOCAL nTxColorE  := Rgb( 79, 79, 79 )
   LOCAL nFrColorE  := Rgb( 207, 207, 207 )

   LOCAL nBkColorE1 := Rgb( 251, 251, 251 )
   LOCAL nBkColorE2 := Rgb( 230, 230, 230 )

   LOCAL nGradDirE  := 0
   LOCAL nTxColorD  := 0x808080

   LOCAL nFrColorD  := Rgb( 232, 232, 232 )

   // { 9, 111, 137 }

   LOCAL nBkColorD1 := 0XE0E0E0
   LOCAL nBkColorD2 := 0XE0E0E0
   LOCAL nGradDirD  := 0
   LOCAL nTxColorF  := Rgb( 45, 55, 56 )
   LOCAL nFrColorF  := nFrColorE


   LOCAL nBkColorF1 :=  0xFFFFFF
   LOCAL nBkColorF2 :=  Rgb( 192, 192, 192 )

   LOCAL nGradDirF  := 0
   LOCAL cFontName  := 'Arial'
   LOCAL nFontSize  := 8

   LOCAL aBtnFont  := { "Arial", 8, .F., .F., .F., .F. }

   LOCAL aBtnColor := ;
      { { nTxColorE, nFrColorE, nBkColorE1, nBkColorE2, nGradDirE }, { nTxColorD, nFrColorD, nBkColorD1, nBkColorD2, nGradDirD }, { nTxColorF, nFrColorF, nBkColorF1, nBkColorF2,         nGradDirF } }

   LOCAL aBtnSel := ;
      { { nTxColorF, nFrColorF, nBkColorF1, nBkColorF2, nGradDirF }, { nTxColorD, nFrColorD, nBkColorD1, nBkColorD2, nGradDirD }, { nTxColorF, nFrColorF, nBkColorF1, nBkColorF2,       nGradDirF } }

   DEFAULT nModel := 1

   IF ( nModel != 1 )

   END IF

RETURN iif( nInd1 == 1, aBtnColor, aBtnSel )
