/*
****************************************
  Owner button functions for HMG 3.4.3

  Author:  KDJ
  Version: 2016-12-09
****************************************

OBTN_Create(cParentFormName, nButtonID, [cCaption], [nRow], [nCol], [nWidth], [nHeight], [lEnabled], [lVisible], [lTabStop], [nShape], [aColor], [aFont])
  --> nHWndButton

OBTN_Release(cParentFormName, nButtonID)
  --> NIL

OBTN_Handle(cParentFormName, nButtonID)
  --> nHWndButton (Get)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
GetDlgCtrlID(nHWndButton)
  --> nButtonID (Get)
///////////////
OBTN_Pos(cParentFormName, nButtonID, [nRow], [nCol], [nWidth], [nHeight])
  --> aPos {nRow, nCol, nWidth, nHeight} (Get/Set)

OBTN_Visible(cParentFormName, nButtonID, [lVisible])
  --> lVisible (Get/Set)

OBTN_Enable(cParentFormName, nButtonID, [lEnable])
  --> lEnabled (Get/Set)

OBTN_Focus(cParentFormName, nButtonID, [.T.])
  --> lFocused (Get/Set)

OBTN_Caption(cParentFormName, nButtonID, [cCaption])
  --> cCaption (Get/Set)

OBTN_Font(cForm, nID, [aFont], [lRedraw])
  --> aFont (Get/Set)

OBTN_Shape(cParentFormName, nButtonID, [nShape], [lRedraw])
  --> nShape (Get/Set)

OBTN_Color(cForm, nID, [aColor], [lRedraw])
  --> aColor (Get/Set)

OBTN_Draw(nHWndParentForm, nButtonID, nDRAWITEMSTRUCT)
  --> NIL (to use only in event handler - if WM_DRAWITEM message is processed)

*****

nShape can be:
  -1  for ellipse
  >=0 for rectangle
  if >0 rectangle has rounded corners by a circle with diameter of nShape

aFont structure: {cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut}

aColor structure: {aColorEnabledButton, aColorDisabledButton, aColorFocusedButton}
  aColorEnabledButton, aColorDisabledButton, aColorFocusedButton: {nTextColor, nFrameColor, nBackColor1, nBackColor2, nGradientDirection}
    nTextColor, nFrameColor, nBackColor1, nBackColor2: 0x00bbggrr, eg:
      0x0000FF - red
      0x00FF00 - green
      0xFF0000 - blue
      0x000000 - black
      0x808080 - gray
      0xFFFFFF - white
    nGradientDirection - direction of the change background color from nBackColor1 to nBackColor2:
      0 - from top to bottom
      1 - from left to right
      2 - from outside to inside
    If nFrameColor in aColorFocusedButton is greater than 0xFFFFFF, additional frame is not drawn.
    nBackColor1 and nBackColor2 are used to draw the background in gradient colors.
*/

#include "hmg.ch"

FUNCTION OBTN_Create( cForm, nID, cCaption, nRow, nCol, nWidth, nHeight, lEnabled, lVisible, lTabStop, nShape, aColor, aFont )

   LOCAL nHButton := _OwnButtonCreate( GetFormHandle( cForm ), nID, cCaption, nRow, nCol, nWidth, nHeight, lEnabled, lVisible, lTabStop )

   LOCAL nTxColorE  := 0x000000
   LOCAL nFrColorE  := 0x000000
   LOCAL nBkColorE1 := 0xFFFFFF
   LOCAL nBkColorE2 := 0xFFFFFF
   LOCAL nGradDirE  := 0
   LOCAL nTxColorD  := 0x808080 
   LOCAL nFrColorD  := 0x808080
   LOCAL nBkColorD1 := 0XE0E0E0
   LOCAL nBkColorD2 := 0XE0E0E0
   LOCAL nGradDirD  := 0
   LOCAL nTxColorF  := 0x000000
   LOCAL nFrColorF  := 0x000000
   LOCAL nBkColorF1 := 0xFFFFFF
   LOCAL nBkColorF2 := 0xFFFFFF
   LOCAL nGradDirF  := 0

   LOCAL cFontName  := _HMG_SYSDATA[ 342 ]
   LOCAL nFontSize  := _HMG_SYSDATA[ 343 ]
   LOCAL lBold      := .F.
   LOCAL lItalic    := .F.
   LOCAL lUnderline := .F.
   LOCAL lStrikeOut := .F.

   IF nHButton != 0
      IF ValType( aColor ) == "A"
         IF ValType( aColor[ 1 ] ) == "A"
            IF ValType( aColor[ 1 ][ 1 ] ) == "N"
               nTxColorE := aColor[ 1 ][ 1 ]
            ENDIF
            IF ValType( aColor[ 1 ][ 2 ] ) == "N"
               nFrColorE := aColor[ 1 ][ 2 ]
            ENDIF
            IF ValType( aColor[ 1 ][ 3 ] ) == "N"
               nBkColorE1 := aColor[ 1 ][ 3 ]
            ENDIF
            IF ValType( aColor[ 1 ][ 4 ] ) == "N"
               nBkColorE2 := aColor[ 1 ][ 4 ]
            ENDIF
            IF ValType( aColor[ 1 ][ 5 ] ) == "N"
               nGradDirE := aColor[ 1 ][ 5 ]
            ENDIF
         ENDIF

         IF ValType( aColor[ 2 ] ) == "A"
            IF ValType( aColor[ 2 ][ 1 ] ) == "N"
               nTxColorD := aColor[ 2 ][ 1 ]
            ENDIF
            IF ValType( aColor[ 2 ][ 2 ] ) == "N"
               nFrColorD := aColor[ 2 ][ 2 ]
            ENDIF
            IF ValType( aColor[ 2 ][ 3 ] ) == "N"
               nBkColorD1 := aColor[ 2 ][ 3 ]
            ENDIF
            IF ValType( aColor[ 2 ][ 4 ] ) == "N"
               nBkColorD2 := aColor[ 2 ][ 4 ]
            ENDIF
            IF ValType( aColor[ 2 ][ 5 ] ) == "N"
               nGradDirD := aColor[ 2 ][ 5 ]
            ENDIF
         ENDIF

         IF ValType( aColor[ 3 ] ) == "A"
            IF ValType( aColor[ 3 ][ 1 ] ) == "N"
               nTxColorF := aColor[ 3 ][ 1 ]
            ENDIF
            IF ValType( aColor[ 3 ][ 2 ] ) == "N"
               nFrColorF := aColor[ 3 ][ 2 ]
            ENDIF
            IF ValType( aColor[ 3 ][ 3 ] ) == "N"
               nBkColorF1 := aColor[ 3 ][ 3 ]
            ENDIF
            IF ValType( aColor[ 3 ][ 4 ] ) == "N"
               nBkColorF2 := aColor[ 3 ][ 4 ]
            ENDIF
            IF ValType( aColor[ 3 ][ 5 ] ) == "N"
               nGradDirF := aColor[ 3 ][ 5 ]
            ENDIF
         ENDIF
      ENDIF

      IF ValType( aFont ) == "A"
         IF ValType( aFont[ 1 ] ) == "C"
            cFontName := aFont[ 1 ]
         ENDIF
         IF ValType( aFont[ 2 ] ) == "N"
            nFontSize := aFont[ 2 ]
         ENDIF
         IF ValType( aFont[ 3 ] ) == "L"
            lBold := aFont[ 3 ]
         ENDIF
         IF ValType( aFont[ 4 ] ) == "L"
            lItalic := aFont[ 4 ]
         ENDIF
         IF ValType( aFont[ 5 ] ) == "L"
            lUnderline := aFont[ 5 ]
         ENDIF
         IF ValType( aFont[ 6 ] ) == "L"
            lStrikeOut := aFont[ 6 ]
         ENDIF
      ENDIF

      OBTN_Shape( cForm, nID, If( ValType(nShape ) == "N", nShape, 0 ) )
      OBTN_Color( cForm, nID, { { nTxColorE, nFrColorE, nBkColorE1, nBkColorE2, nGradDirE }, { nTxColorD, nFrColorD, nBkColorD1, nBkColorD2, nGradDirD }, { nTxColorF, nFrColorF, nBkColorF1, nBkColorF2, nGradDirF } } )
      OBTN_Font( cForm, nID, { cFontName, nFontSize, lBold, lItalic, lUnderline, lStrikeOut } )
   ENDIF

RETURN nHButton


FUNCTION OBTN_Release( cForm, nID )

   LOCAL nHParent := GetFormHandle( cForm )
   LOCAL nHButton := GetDlgItem( nHParent, nID )

   IF GetFocus() == nHButton
      SetFocus( GetNextDlgTabItem( nHParent, nHButton, .F. ) )
   ENDIF

   DestroyWindow( GetDlgItem( nHParent, nID ) )

RETURN NIL


FUNCTION OBTN_Handle( cForm, nID )

RETURN GetDlgItem( GetFormHandle( cForm ), nID )


FUNCTION OBTN_Pos( cForm, nID, nRow, nCol, nWidth, nHeight )

   LOCAL nHParent := GetFormHandle( cForm )
   LOCAL nHButton := GetDlgItem( nHParent, nID )
   LOCAL aPos  := { 0, 0, 0, 0 }

   GetWindowRect( nHButton, aPos )
   aPos[ 3 ] := aPos[ 3 ] - aPos[ 1 ]
   aPos[ 4 ] := aPos[ 4 ] - aPos[ 2 ]
   ScreenToClient( nHParent, @aPos[ 1 ], @aPos[ 2 ] )

   IF PCount() < 3
      RETURN { aPos[ 2 ], aPos[ 1 ], aPos[ 3 ], aPos[ 4 ] }
   ENDIF

   IF ValType( nRow ) != "N"
      nRow := aPos[ 2 ]
   ENDIF

   IF ValType( nCol ) != "N"
      nCol := aPos[ 1 ]
   ENDIF

   IF ValType( nWidth ) != "N"
      nWidth := aPos[ 3 ]
   ENDIF

   IF ValType( nHeight ) != "N"
      nHeight := aPos[ 4 ]
   ENDIF

   MoveWindow( nHButton, nCol, nRow, nWidth, nHeight, .T. )
   // RedrawWindow(nHButton)

RETURN OBTN_Pos( cForm, nID )


FUNCTION OBTN_Visible( cForm, nID, lVisible )

   LOCAL nHButton := GetDlgItem( GetFormHandle( cForm ), nID )

   IF ValType( lVisible ) == "L"
      IF lVisible
         ShowWindow( nHButton )
         // savelog( 'Out453.txt' , 'Hide ' + cForm + ' ' + str(nId) )
      ELSE
         IF GetFocus() == nHButton
            SetFocus( GetNextDlgTabItem( GetFormHandle(cForm ), nHButton, .F. ) )
         ENDIF

         HideWindow( nHButton )
         // savelog( 'Out43.txt' , 'Hide ' + cForm + ' ' + str(nId) )


      ENDIF

   ENDIF

RETURN IsWindowVisible( nHButton )

/////////////////////////////
FUNCTION OBTN_Enable( cForm, nID, lEnable )

   LOCAL nHButton := GetDlgItem( GetFormHandle( cForm ), nID )

   IF ValType( lEnable ) == "L"
      IF lEnable
         EnableWindow( nHButton )
      ELSE
         IF GetFocus() == nHButton
            SetFocus( GetNextDlgTabItem( GetFormHandle(cForm ), nHButton, .F. ) )
         ENDIF

         DisableWindow( nHButton )
      ENDIF
   ENDIF

RETURN IsWindowEnabled( nHButton )


FUNCTION OBTN_Focus( cForm, nID, lFocus )

   LOCAL nHButton := GetDlgItem( GetFormHandle( cForm ), nID )

   IF ValType( lFocus ) == "L" .AND. lFocus .AND. IsWindowEnabled( nHButton )
      SetFocus( nHButton )
   ENDIF

RETURN ( GetFocus() == nHButton )


FUNCTION OBTN_Caption( cForm, nID, cCaption )

   LOCAL nHButton := GetDlgItem( GetFormHandle( cForm ), nID )

   IF ValType( cCaption ) == "C"
      SetWindowText( nHButton, cCaption )
   ENDIF

RETURN GetWindowText( nHButton )


FUNCTION OBTN_Font( cForm, nID, aFont, lRedraw )

   STATIC hFont := { => }

   IF ValType( aFont ) == "A"
      IF hb_HHasKey( hFont, cForm )
         IF hb_HHasKey( hFont[ cForm ], nID )
            IF ValType( aFont[ 1 ] ) == "C"
               hFont[ cForm ][ nID ][ 1 ] := aFont[ 1 ]
            ENDIF
            IF ValType( aFont[ 2 ] ) == "N"
               hFont[ cForm ][ nID ][ 2 ] := aFont[ 2 ]
            ENDIF
            IF ValType( aFont[ 3 ] ) == "L"
               hFont[ cForm ][ nID ][ 3 ] := aFont[ 3 ]
            ENDIF
            IF ValType( aFont[ 4 ] ) == "L"
               hFont[ cForm ][ nID ][ 4 ] := aFont[ 4 ]
            ENDIF
            IF ValType( aFont[ 5 ] ) == "L"
               hFont[ cForm ][ nID ][ 5 ] := aFont[ 5 ]
            ENDIF
            IF ValType( aFont[ 6 ] ) == "L"
               hFont[ cForm ][ nID ][ 6 ] := aFont[ 6 ]
            ENDIF
         ELSE
            hFont[ cForm ][ nID ] := aFont
         ENDIF
      ELSE
         hFont[ cForm ] := { nID => aFont }
      ENDIF

      IF ( ValType( lRedraw ) == "L" ) .AND. lRedraw
         RedrawWindow( GetDlgItem( GetFormHandle(cForm ), nID ) )
      ENDIF
   ENDIF

RETURN If( hb_HHasKey( hFont, cForm ) .AND. hb_HHasKey( hFont[ cForm ], nID ), hFont[ cForm ][ nID ], NIL )


FUNCTION OBTN_Shape( cForm, nID, nShape, lRedraw )


   
   STATIC hShape := { => }

   IF ValType( nShape ) == "N"
      IF hb_HHasKey( hShape, cForm )
         hShape[ cForm ][ nID ] := nShape
      ELSE
         hShape[ cForm ] := { nID => nShape }
      ENDIF

      IF ( ValType( lRedraw ) == "L" ) .AND. lRedraw
         RedrawWindow( GetDlgItem( GetFormHandle(cForm ), nID ) )
      ENDIF
   ELSE
      IF hb_HHasKey( hShape, cForm ) .AND. hb_HHasKey( hShape[ cForm ], nID )
         nShape := hShape[ cForm ][ nID ]
      ENDIF
   ENDIF

RETURN nShape


FUNCTION OBTN_Color( cForm, nID, aColor, lRedraw )

   STATIC hColor := { => }

   IF ValType( aColor ) == "A"
      IF hb_HHasKey( hColor, cForm )
         IF hb_HHasKey( hColor[ cForm ], nID )
            IF ValType( aColor[ 1 ] ) == "A"
               IF ValType( aColor[ 1 ][ 1 ] ) == "N"
                  hColor[ cForm ][ nID ][ 1 ][ 1 ] := aColor[ 1 ][ 1 ]
               ENDIF
               IF ValType( aColor[ 1 ][ 2 ] ) == "N"
                  hColor[ cForm ][ nID ][ 1 ][ 2 ] := aColor[ 1 ][ 2 ]
               ENDIF
               IF ValType( aColor[ 1 ][ 3 ] ) == "N"
                  hColor[ cForm ][ nID ][ 1 ][ 3 ] := aColor[ 1 ][ 3 ]
               ENDIF
               IF ValType( aColor[ 1 ][ 4 ] ) == "N"
                  hColor[ cForm ][ nID ][ 1 ][ 4 ] := aColor[ 1 ][ 4 ]
               ENDIF
               IF ValType( aColor[ 1 ][ 5 ] ) == "N"
                  hColor[ cForm ][ nID ][ 1 ][ 5 ] := aColor[ 1 ][ 5 ]
               ENDIF
            ENDIF

            IF ValType( aColor[ 2 ] ) == "A"
               IF ValType( aColor[ 2 ][ 1 ] ) == "N"
                  hColor[ cForm ][ nID ][ 2 ][ 1 ] := aColor[ 2 ][ 1 ]
               ENDIF
               IF ValType( aColor[ 2 ][ 2 ] ) == "N"
                  hColor[ cForm ][ nID ][ 2 ][ 2 ] := aColor[ 2 ][ 2 ]
               ENDIF
               IF ValType( aColor[ 2 ][ 3 ] ) == "N"
                  hColor[ cForm ][ nID ][ 2 ][ 3 ] := aColor[ 2 ][ 3 ]
               ENDIF
               IF ValType( aColor[ 2 ][ 4 ] ) == "N"
                  hColor[ cForm ][ nID ][ 2 ][ 4 ] := aColor[ 2 ][ 4 ]
               ENDIF
               IF ValType( aColor[ 2 ][ 5 ] ) == "N"
                  hColor[ cForm ][ nID ][ 2 ][ 5 ] := aColor[ 2 ][ 5 ]
               ENDIF
            ENDIF

            IF ValType( aColor[ 3 ] ) == "A"
               IF ValType( aColor[ 3 ][ 1 ] ) == "N"
                  hColor[ cForm ][ nID ][ 3 ][ 1 ] := aColor[ 3 ][ 1 ]
               ENDIF
               IF ValType( aColor[ 3 ][ 2 ] ) == "N"
                  hColor[ cForm ][ nID ][ 3 ][ 2 ] := aColor[ 3 ][ 2 ]
               ENDIF
               IF ValType( aColor[ 3 ][ 3 ] ) == "N"
                  hColor[ cForm ][ nID ][ 3 ][ 3 ] := aColor[ 3 ][ 3 ]
               ENDIF
               IF ValType( aColor[ 3 ][ 4 ] ) == "N"
                  hColor[ cForm ][ nID ][ 3 ][ 4 ] := aColor[ 3 ][ 4 ]
               ENDIF
               IF ValType( aColor[ 3 ][ 5 ] ) == "N"
                  hColor[ cForm ][ nID ][ 3 ][ 5 ] := aColor[ 3 ][ 5 ]
               ENDIF
            ENDIF
         ELSE
            hColor[ cForm ][ nID ] := aColor
         ENDIF
      ELSE
         hColor[ cForm ] := { nID => aColor }
      ENDIF

      IF ( ValType( lRedraw ) == "L" ) .AND. lRedraw
         RedrawWindow( GetDlgItem( GetFormHandle(cForm ), nID ) )
      ENDIF
   ENDIF

RETURN If( hb_HHasKey( hColor, cForm ) .AND. hb_HHasKey( hColor[ cForm ], nID ), hColor[ cForm ][ nID ], NIL )


FUNCTION OBTN_Draw( nHParent, nID, nDRAWITEMSTRUCT )

   LOCAL cForm  := GetFormNameByIndex( GetFormIndexByHandle( nHParent ) )
   LOCAL nShape := OBTN_Shape( cForm, nID )
   LOCAL aColor := OBTN_Color( cForm, nID )
   LOCAL aFont  := OBTN_Font( cForm, nID )

   _OwnButtonDraw( nDRAWITEMSTRUCT, nShape, aColor[ 1 ], aColor[ 2 ], aColor[ 3 ], aFont )

RETURN NIL


#pragma BEGINDUMP

#include "SET_COMPILE_HMG_UNICODE.ch"
#include "HMG_UNICODE.h"
#include <windows.h>
#include <commctrl.h>
#include <math.h>
#include "hbapi.h"

static HBRUSH CreateGradientBrush();


       //                 1         2    3          4       5       6         7          8           9           10
       //_OwnButtonCreate(nHParent, nID, cCaption, [nRow], [nCol], [nWidth], [nHeight], [lEnabled], [lVisible], [lTabStop])
HB_FUNC( _OWNBUTTONCREATE )
{
  DWORD  dwStyle = BS_OWNERDRAW | WS_CHILD;
  HWND hButton;

  if (! hb_parldef(8, 1))
    dwStyle |= WS_DISABLED;
  if (hb_parldef(9, 1))
    dwStyle |= WS_VISIBLE;
  if (hb_parldef(10, 1))
    dwStyle |= WS_CLIPSIBLINGS;

  hButton = CreateWindowEx(0,
                           (LPCTSTR) WC_BUTTON,
                           (LPCTSTR) HMG_parc(3),
                           dwStyle,
                           hb_parnidef(5, 0),
                           hb_parnidef(4, 0),
                           hb_parnidef(6, 0),
                           hb_parnidef(7, 0),
                           (HWND) HMG_parnl(1),
                           (HMENU) HMG_parnl(2),
                           GetModuleHandle(NULL),
                           NULL);

  //SetClassLong( (HWND) hButton  , GCL_HCURSOR, ( LONG ) LoadCursor( 0 , IDC_HAND ) );

  SetClassLongPtr( (HWND) hButton  , GCLP_HCURSOR, ( LONG ) LoadCursor( 0 , IDC_HAND ) );

  //SetClassLong( ( HWND ) hButton , -12 , ( LONG ) LoadCursor( NULL, IDC_HAND ) );

  HMG_retnl((LONG_PTR) hButton);

}


       //               1                2       3        4        5        6
       //_OwnButtonDraw(nDRAWITEMSTRUCT, nShape, aColor1, aColor2, aColor3, aFont)
HB_FUNC( _OWNBUTTONDRAW )
{
  DRAWITEMSTRUCT *pDIS = (DRAWITEMSTRUCT *) HMG_parnl(1);

  INT nShape = (INT) hb_parni(2);

  TCHAR *FontName  = (TCHAR *) HMG_parvc(6, 1);
  INT   nFontSize  = (INT)     hb_parvni(6, 2);
  INT   nBold      = hb_parvl(6, 3) ? FW_BOLD : FW_NORMAL;
  INT   nItalic    = hb_parvl(6, 4) ? 1 : 0;
  INT   nUnderline = hb_parvl(6, 5) ? 1 : 0;
  INT   nStrikeOut = hb_parvl(6, 6) ? 1 : 0;

  COLORREF TextColor;
  COLORREF FrameColor;
  COLORREF FrameColor2 = 0xFFFFFFFF;
  COLORREF BackColor1;
  COLORREF BackColor2;
  INT      nGradDir;
  HBRUSH   hBrush;
  HBRUSH   hBrush2;
  HBRUSH   hBrushOld;
  HPEN     hPen;
  HPEN     hPenOld;
  HFONT    hFont;
  HFONT    hFontOld;
  RECT     rcText;
  INT      nTextH;

  INT nTextLen = GetWindowTextLength(pDIS->hwndItem) + 1;
  TCHAR *Text  = (TCHAR *) hb_xgrab(nTextLen * sizeof(TCHAR));
  GetWindowText(pDIS->hwndItem, Text, nTextLen);

  if (pDIS->itemState & ODS_DISABLED)
  {
    TextColor  = (COLORREF) hb_parvni(4, 1);
    FrameColor = (COLORREF) hb_parvni(4, 2);
    BackColor1 = (COLORREF) hb_parvni(4, 3);
    BackColor2 = (COLORREF) hb_parvni(4, 4);
    nGradDir   = (INT)      hb_parvni(4, 5);
  }
  else if (pDIS->itemState & ODS_FOCUS)
  {
    TextColor   = (COLORREF) hb_parvni(5, 1);
    FrameColor  = (COLORREF) hb_parvni(5, 2); // Pablo
    FrameColor2 = (COLORREF) hb_parvni(5, 2);
    BackColor1  = (COLORREF) hb_parvni(5, 3);
    BackColor2  = (COLORREF) hb_parvni(5, 4);
    nGradDir    = (INT)      hb_parvni(5, 5);
  }
  else
  {
    TextColor  = (COLORREF) hb_parvni(3, 1);
    FrameColor = (COLORREF) hb_parvni(3, 2);
    BackColor1 = (COLORREF) hb_parvni(3, 3);
    BackColor2 = (COLORREF) hb_parvni(3, 4);
    nGradDir   = (INT)      hb_parvni(3, 5);
  }

  hBrush = CreateGradientBrush(pDIS->hDC, (pDIS->rcItem.right  - pDIS->rcItem.left), (pDIS->rcItem.bottom - pDIS->rcItem.top), nShape, nGradDir, BackColor1, BackColor2);
  hPen   = CreatePen(PS_INSIDEFRAME, 1, FrameColor);
  hFont  = CreateFont(-MulDiv(nFontSize, GetDeviceCaps(pDIS->hDC, LOGPIXELSY), 72), 0, 0, 0, nBold, nItalic, nUnderline, nStrikeOut, DEFAULT_CHARSET, OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH | FF_DONTCARE, FontName);

  hBrushOld = SelectObject(pDIS->hDC, hBrush);
  hPenOld   = SelectObject(pDIS->hDC, hPen);
  hFontOld  = SelectObject(pDIS->hDC, hFont);

  if (nShape >= 0)
  {
    if (FrameColor2 <= 0xFFFFFF)
    {
      hBrush2 = CreateSolidBrush(FrameColor2);
      SelectObject(pDIS->hDC, hBrush2);

      RoundRect(pDIS->hDC, pDIS->rcItem.left, pDIS->rcItem.top, pDIS->rcItem.right, pDIS->rcItem.bottom, nShape, nShape);

      SelectObject(pDIS->hDC, hBrush);
      DeleteObject(hBrush2);

      RoundRect(pDIS->hDC, pDIS->rcItem.left + 2, pDIS->rcItem.top + 2, pDIS->rcItem.right - 2, pDIS->rcItem.bottom - 2, nShape - 2, nShape - 2);
    }
    else
      RoundRect(pDIS->hDC, pDIS->rcItem.left, pDIS->rcItem.top, pDIS->rcItem.right, pDIS->rcItem.bottom, nShape, nShape);
  }
  else
  {
    if (FrameColor2 <= 0xFFFFFF)
    {
      hBrush2 = CreateSolidBrush(FrameColor2);
      SelectObject(pDIS->hDC, hBrush2);

      Ellipse(pDIS->hDC, pDIS->rcItem.left, pDIS->rcItem.top, pDIS->rcItem.right, pDIS->rcItem.bottom);

      SelectObject(pDIS->hDC, hBrush);
      DeleteObject(hBrush2);

      Ellipse(pDIS->hDC, pDIS->rcItem.left + 2, pDIS->rcItem.top + 2, pDIS->rcItem.right - 2, pDIS->rcItem.bottom - 2);
    }
    else
      Ellipse(pDIS->hDC, pDIS->rcItem.left, pDIS->rcItem.top, pDIS->rcItem.right, pDIS->rcItem.bottom);
  }

  rcText.left   = pDIS->rcItem.left;
  rcText.top    = pDIS->rcItem.top ;
  rcText.right  = pDIS->rcItem.right;
  rcText.bottom = pDIS->rcItem.bottom;

  SetTextColor(pDIS->hDC, TextColor);
  SetBkMode(pDIS->hDC, TRANSPARENT);

  nTextH = DrawText(pDIS->hDC, Text, -1, &rcText, DT_CALCRECT | DT_NOCLIP);

  rcText.left  = pDIS->rcItem.left  + 3;
  rcText.right = pDIS->rcItem.right - 3;

  if (nTextH < (pDIS->rcItem.bottom - pDIS->rcItem.top - 2 * 3))
  {
    rcText.top    = (pDIS->rcItem.bottom - pDIS->rcItem.top - nTextH) / 2;
    rcText.bottom = rcText.top + nTextH;
  }
  else
  {
    rcText.top    = pDIS->rcItem.top    + 3;
    rcText.bottom = pDIS->rcItem.bottom - 3;
  }

  DrawText(pDIS->hDC, Text, -1, &rcText, DT_CENTER);

  SelectObject(pDIS->hDC, hBrushOld);
  SelectObject(pDIS->hDC, hPenOld);
  SelectObject(pDIS->hDC, hFontOld);

  DeleteObject(hBrush);
  DeleteObject(hPen);
  DeleteObject(hFont);
  hb_xfree(Text);
}


static HBRUSH CreateGradientBrush(HDC hDC, INT nWidth, INT nHeight, INT nShape, INT nDirection, COLORREF Color1, COLORREF Color2)
{
  INT     R1, G1, B1, R2, G2, B2;
  HDC     hDCComp;
  HBITMAP hBitmap;
  HBRUSH  hBrush, hBrushOld, hBrushPat;
  HPEN    hPen, hPenOld;
  RECT    rcF;
  INT     nCount;
  INT     i;

  R1 = GetRValue(Color1);
  G1 = GetGValue(Color1);
  B1 = GetBValue(Color1);
  R2 = GetRValue(Color2);
  G2 = GetGValue(Color2);
  B2 = GetBValue(Color2);

  hDCComp = CreateCompatibleDC(hDC);
  hBitmap = CreateCompatibleBitmap(hDC, nWidth, nHeight);
  SelectObject(hDCComp, hBitmap);

  if (nDirection == 0)
  {
    rcF.left   = 0;
    rcF.right  = nWidth;
    rcF.bottom = nHeight;

    for (i = 0; i < nHeight; i++)
    {
      rcF.top = i;
      hBrush  = CreateSolidBrush(RGB(R1 + (i * (R2 - R1) / nHeight), G1 + (i * (G2 - G1) / nHeight), B1 + (i * (B2 - B1) / nHeight)));
      FillRect(hDCComp, &rcF, hBrush);
      DeleteObject(hBrush);
    }
  }
  else if (nDirection == 1)
  {
    rcF.top    = 0;
    rcF.right  = nWidth;
    rcF.bottom = nHeight;

    for (i = 0; i < nWidth; i++)
    {
      rcF.left = i;
      hBrush   = CreateSolidBrush(RGB(R1 + (i * (R2 - R1) / nWidth), G1 + (i * (G2 - G1) / nWidth), B1 + (i * (B2 - B1) / nWidth)));
      FillRect(hDCComp, &rcF, hBrush);
      DeleteObject(hBrush);
    }
  }
  else
  {
    rcF.left   = 0;
    rcF.top    = 0;
    rcF.right  = nWidth;
    rcF.bottom = nHeight;
    nCount     = ceil(((nWidth > nHeight) ? nHeight : nWidth) / 2);

    if (nShape >= 0)
    {
      for (i = 0; i < nCount; i++)
      {
        hBrush = CreateSolidBrush(RGB(R1 + (i * (R2 - R1) / nCount), G1 + (i * (G2 - G1) / nCount), B1 + (i * (B2 - B1) / nCount)));
        FillRect(hDCComp, &rcF, hBrush);
        DeleteObject(hBrush);

        ++rcF.left;
        ++rcF.top;
        --rcF.right;
        --rcF.bottom;
      }
    }
    else
    {
      for (i = 0; i < nCount; i++)
      {
        hBrush = CreateSolidBrush(RGB(R1 + (i * (R2 - R1) / nCount), G1 + (i * (G2 - G1) / nCount), B1 + (i * (B2 - B1) / nCount)));
        hPen   = CreatePen(PS_NULL, 0, 0);

        hBrushOld = SelectObject(hDCComp, hBrush);
        hPenOld   = SelectObject(hDCComp, hPen);

        Ellipse(hDCComp, rcF.left, rcF.top, rcF.right, rcF.bottom);

        SelectObject(hDCComp, hBrushOld);
        SelectObject(hDCComp, hPenOld);

        DeleteObject(hBrush);
        DeleteObject(hPen);

        ++rcF.left;
        ++rcF.top;
        --rcF.right;
        --rcF.bottom;
      }
    }
  }

  hBrushPat = CreatePatternBrush(hBitmap);

  DeleteDC(hDCComp);
  DeleteObject(hBitmap);

  return hBrushPat;
}

#pragma ENDDUMP
