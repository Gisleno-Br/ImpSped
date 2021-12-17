
#include "hmg.ch"

Function Main

   Load Window Test

   #define TCS_OWNERDRAWFIXED    0x2000
   HMG_ChangeWindowStyle ( Test.Tab_1.HANDLE, TCS_OWNERDRAWFIXED, NIL, .F. )

   hFont := HMG_CreateFont ( NIL , "ARIAL", 9, .T., .T., .F., .F. )

   TabCtrl_SetItemSize (Test.Tab_1.HANDLE, 20, 40)

   CREATE EVENT PROCNAME DrawTab() STOREINDEX nIndex
   EventProcessAllHookMessage ( nIndex, .T. ) 
   
   Activate Window Test

Return


Function DrawTab
LOCAL lParam := EventLPARAM()
   #define WM_DRAWITEM 43
   IF EventMSG() == WM_DRAWITEM
      i := ASCAN (_HMG_SYSDATA [3], CUSTOMDRAWITEM_HANDLE (lParam))
      if i > 0 .AND. _HMG_SYSDATA [1] [i] == "TAB"
         k := CUSTOMDRAWITEM_ID (lParam) + 1
         if k > 0
            return CUSTOMDRAWITEM ( lParam, _HMG_SYSDATA [33] [i] [k], RGB(0,0,255), RGB(255,0,0), hFont, Test.HANDLE, Test.Tab_1.HANDLE)
         endif
      endif
   ENDIF
RETURN NIL



#pragma BEGINDUMP

#include "SET_COMPILE_HMG_UNICODE.ch"
#include "HMG_UNICODE.h"
#include <windows.h>
#include <shlobj.h>
#include <uxtheme.h>
#include <tmschema.h>
#include "hbapi.h"


/*
The HMG internal function _GETTABBRUSH need some changes

HB_FUNC( _GETTABBRUSH )
{
	HBRUSH hBrush ;
	RECT rc;
	HDC hDC ;
	HDC hDCMem  ;
	HBITMAP hBmp ;
	HBITMAP hBmp2 ;


// ADD for Tab Custom Draw
// if( Tab_Custom_Draw )
//   hBrush = CreateSolidBrush (RGB(255,255,255));   // set custom draw background color
//   HMG_retnl ((LONG_PTR) hBrush);
//   return;
// ENDIF


	GetWindowRect ( (HWND) HMG_parnl (1), &rc ) ;
	hDC = GetDC( (HWND) HMG_parnl (1) ) ;
	hDCMem = CreateCompatibleDC(hDC);
	hBmp = CreateCompatibleBitmap(hDC, rc.right - rc.left, rc.bottom - rc.top);
	hBmp2 = (HBITMAP)(SelectObject(hDCMem, hBmp));
	SendMessage( (HWND) HMG_parnl (1), WM_PRINTCLIENT , (WPARAM)(hDCMem) , (LPARAM)(PRF_ERASEBKGND | PRF_CLIENT | PRF_NONCLIENT ) ) ;
	hBrush = CreatePatternBrush(hBmp);

   HMG_retnl ((LONG_PTR) hBrush);

	SelectObject( hDCMem , hBmp2 ) ;

	DeleteObject(hBmp);
	DeleteDC(hDCMem);
	ReleaseDC( (HWND) HMG_parnl (1) , hDC);
}
*/


HMG_DEFINE_DLL_FUNC ( win_IsAppThemed,                                   // user function name
                      "uxtheme.dll",                                        // dll name
                      BOOL,                                              // function return type
                      WINAPI,                                               // function type
                      "IsAppThemed",                                     // dll function name
                      (),   // dll function parameters (types and names)
                      (),                        // function parameters (only names)
                      FALSE                                                    // return value if fail call function of dll
                    )


HMG_DEFINE_DLL_FUNC ( win_GetCurrentThemeName,                                   // user function name
                      "uxtheme.dll",                                        // dll name
                      HRESULT,                                              // function return type
                      WINAPI,                                               // function type
                      "GetCurrentThemeName",                                     // dll function name
                      (LPWSTR pszThemeFileName, int dwMaxNameChars, LPWSTR pszColorBuff, int cchMaxColorChars, LPWSTR pszSizeBuff, int cchMaxSizeChars),   // dll function parameters (types and names)
                      (pszThemeFileName, dwMaxNameChars, pszColorBuff, cchMaxColorChars, pszSizeBuff, cchMaxSizeChars),                        // function parameters (only names)
                      -1                                                    // return value if fail call function of dll
                    )

HMG_DEFINE_DLL_FUNC ( win_OpenThemeData,                                   // user function name
                      "uxtheme.dll",                                        // dll name
                      HTHEME,                                              // function return type
                      WINAPI,                                               // function type
                      "OpenThemeData",                                     // dll function name
                      (HWND hWnd, LPCWSTR pszClassList),   // dll function parameters (types and names)
                      (hWnd, pszClassList),                        // function parameters (only names)
                      NULL                                                    // return value if fail call function of dll
                    )


HMG_DEFINE_DLL_FUNC ( win_CloseThemeData,                                   // user function name
                      "uxtheme.dll",                                        // dll name
                      HRESULT,                                              // function return type
                      WINAPI,                                               // function type
                      "CloseThemeData",                                     // dll function name
                      (HTHEME hTheme),   // dll function parameters (types and names)
                      (hTheme),                        // function parameters (only names)
                      -1                                                    // return value if fail call function of dll
                    )


HMG_DEFINE_DLL_FUNC ( win_DrawThemeEdge,                                   // user function name
                      "uxtheme.dll",                                        // dll name
                      HRESULT,                                              // function return type
                      WINAPI,                                               // function type
                      "DrawThemeEdge",                                     // dll function name
                      (HTHEME hTheme, HDC hDC, int iPartId, int iStateId, LPCRECT pDestRect, UINT uEdge, UINT uFlags, LPRECT pContentRect),   // dll function parameters (types and names)
                      (hTheme, hDC, iPartId, iStateId, pDestRect, uEdge, uFlags, pContentRect),                        // function parameters (only names)
                      -1                                                    // return value if fail call function of dll
                    )


HMG_DEFINE_DLL_FUNC ( win_DrawThemeBackground,                                   // user function name
                      "uxtheme.dll",                                        // dll name
                      HRESULT,                                              // function return type
                      WINAPI,                                               // function type
                      "DrawThemeBackground",                                     // dll function name
                      (HTHEME hTheme, HDC hDC, int iPartId, int iStateId, const RECT *pRect, const RECT *pClipRect),   // dll function parameters (types and names)
                      (hTheme, hDC, iPartId, iStateId, pRect, pClipRect),                        // function parameters (only names)
                      -1                                                    // return value if fail call function of dll
                    )


HMG_DEFINE_DLL_FUNC ( win_DrawThemeParentBackground,                                   // user function name
                      "uxtheme.dll",                                        // dll name
                      HRESULT,                                              // function return type
                      WINAPI,                                               // function type
                      "DrawThemeParentBackground",                                     // dll function name
                      (HWND hWnd, HDC hDC, const RECT *prc),   // dll function parameters (types and names)
                      (hWnd, hDC, prc),                        // function parameters (only names)
                      -1                                                    // return value if fail call function of dll
                    )


HMG_DEFINE_DLL_FUNC ( win_IsThemeBackgroundPartiallyTransparent,                                   // user function name
                      "uxtheme.dll",                                        // dll name
                      BOOL,                                              // function return type
                      WINAPI,                                               // function type
                      "IsThemeBackgroundPartiallyTransparent",                                     // dll function name
                      (HTHEME hTheme, int iPartId, int iStateId),   // dll function parameters (types and names)
                      (hTheme, iPartId, iStateId),                        // function parameters (only names)
                      FALSE                                                    // return value if fail call function of dll
                    )





HB_FUNC ( TABCTRL_SETITEMSIZE )
{
   HWND hWnd = (HWND) HMG_parnl (1);
   INT  cx   = (INT)  hb_parni  (2);
   INT  cy   = (INT)  hb_parni  (3);
   DWORD OldSize = TabCtrl_SetItemSize (hWnd, cx, cy);
   hb_retni ((INT) OldSize);
}


HB_FUNC ( CUSTOMDRAWITEM_HANDLE )
{
   LPARAM lParam = (LPARAM) HMG_parnl (1);
   LPDRAWITEMSTRUCT lpDIS = (LPDRAWITEMSTRUCT) lParam;
   HMG_retnl ((LONG_PTR) lpDIS->hwndItem );
}


HB_FUNC ( CUSTOMDRAWITEM_ID )
{
   LPARAM lParam = (LPARAM) HMG_parnl (1);
   LPDRAWITEMSTRUCT lpDIS = (LPDRAWITEMSTRUCT) lParam;
   hb_retni ((INT) lpDIS->itemID );
}


void bt_GradientFill (HDC hDC, RECT Rect, COLORREF Color_RGB_O, COLORREF Color_RGB_D, ULONG Mode)
{
   TRIVERTEX      Vert [2];
   GRADIENT_RECT  gRect;
   
   Vert [0] .x      = Rect.left;
   Vert [0] .y      = Rect.top;
   Vert [0] .Red    = (USHORT) GetRValue(Color_RGB_O) << 8;
   Vert [0] .Green  = (USHORT) GetGValue(Color_RGB_O) << 8;
   Vert [0] .Blue   = (USHORT) GetBValue(Color_RGB_O) << 8;
   Vert [0] .Alpha  = 0x0000;

   Vert [1] .x      = Rect.right;
   Vert [1] .y      = Rect.bottom; 
   Vert [1] .Red    = (USHORT) GetRValue(Color_RGB_D) << 8;
   Vert [1] .Green  = (USHORT) GetGValue(Color_RGB_D) << 8;
   Vert [1] .Blue   = (USHORT) GetBValue(Color_RGB_D) << 8;
   Vert [1] .Alpha  = 0x0000;

   gRect.UpperLeft  = 0;
   gRect.LowerRight = 1;
   GradientFill (hDC, Vert, 2, &gRect, 1, Mode);
}



HB_FUNC ( CUSTOMDRAWITEM )
{

   LPARAM lParam = (LPARAM) HMG_parnl (1);
   LPDRAWITEMSTRUCT lpDIS = (LPDRAWITEMSTRUCT) lParam;

   if (lpDIS->CtlType == ODT_TAB)
   {

      HWND hWnd = (HWND) HMG_parnl (7);
      TabCtrl_GetItemRect (hWnd, lpDIS->itemID, &lpDIS->rcItem);
      HRGN hRgnNew = CreateRectRgnIndirect (&lpDIS->rcItem);

      HFONT hFont = (HFONT) HMG_parnl (5);
      if ( hFont != NULL )
         SelectObject (lpDIS->hDC, hFont);
     
   
      HBRUSH hBrush1 = CreateSolidBrush (RGB(255,255,255));
      HBRUSH hBrush2 = CreateSolidBrush (0);
      HBRUSH hBrush3 = CreateSolidBrush (RGB(0,0,255));
      
      SetBkMode    (lpDIS->hDC, TRANSPARENT);
      SetTextColor (lpDIS->hDC, hb_parni(4));
     
      TCHAR *cText = (TCHAR *) HMG_parc (2);
      SIZE Size;
     
      GetTextExtentPoint32 (lpDIS->hDC, cText, lstrlen (cText), &Size);

      Size.cy = lpDIS->rcItem.bottom - (((lpDIS->rcItem.bottom - lpDIS->rcItem.top) - Size.cy) / 2);

      if ( lpDIS->itemState & ODS_SELECTED )
      {   lpDIS->rcItem.bottom += 2;
          Size.cy -= 3;
          FillRect  (lpDIS->hDC, &lpDIS->rcItem, hBrush1);
      }
      else
         bt_GradientFill (lpDIS->hDC, lpDIS->rcItem, GetSysColor(COLOR_BTNFACE), GetSysColor(COLOR_BTNSHADOW), 1); // 1-Vertical 0-Horizontal
    

      if ( Size.cx > (lpDIS->rcItem.right - lpDIS->rcItem.left) )
      {   Size.cx = lpDIS->rcItem.left;
          SetTextAlign (lpDIS->hDC, TA_LEFT | TA_BOTTOM );
      }
      else
      {   Size.cx = (lpDIS->rcItem.right + lpDIS->rcItem.left)/2;
          SetTextAlign (lpDIS->hDC, TA_CENTER | TA_BOTTOM);
      }

//      HRGN hRgnOld = SelectObject (lpDIS->hDC, hRgnNew);

      TextOut(lpDIS->hDC, Size.cx, Size.cy, cText, lstrlen (cText) ); 
//    DrawText (lpDIS->hDC, cText, -1, &lpDIS->rcItem, DT_CENTER | DT_VCENTER | DT_SINGLELINE );

//      SelectObject (lpDIS->hDC, hRgnOld);
      DeleteObject (hRgnNew);
      
      DeleteObject (hBrush1);
      DeleteObject (hBrush2);
      DeleteObject (hBrush3);



if ( ! win_IsAppThemed() )   
{   
      BOOL bPainted;
      HWND hWndTab = WindowFromDC (lpDIS->hDC);
      HTHEME hTheme = win_OpenThemeData (NULL, L"TAB");   
      if (hTheme != NULL)   
      {   
      // TIS_DISABLED, TIS_FOCUSED, TIS_HOT, TIS_NORMAL, TIS_SELECTED
         RECT ContentRect;
         UINT uEdge  = EDGE_ETCHED;
         UINT uFlags = BF_ADJUST; //BF_RECT;
#ifndef _WIN64
   #define ODS_HOTLIGHT 0x0040
   #define ODS_INACTIVE 0x0080
   #define ODS_NOACCEL 0x0100
   #define ODS_NOFOCUSRECT 0x0200
#endif
         if ( win_IsThemeBackgroundPartiallyTransparent (hTheme, TABP_TABITEM, TIS_NORMAL) )   
              win_DrawThemeParentBackground (GetParent(hWndTab), lpDIS->hDC, &lpDIS->rcItem);
 
         if (lpDIS->itemState & ODS_SELECTED)
         {   
            bPainted = (win_DrawThemeBackground (hTheme, lpDIS->hDC, TABP_TABITEM, TIS_SELECTED, &lpDIS->rcItem, NULL) == S_OK);
            win_DrawThemeEdge (hTheme, lpDIS->hDC, TABP_TABITEM, TIS_SELECTED, &lpDIS->rcItem, uEdge, uFlags, &ContentRect);
         }
         else
         {
            bPainted = (win_DrawThemeBackground (hTheme, lpDIS->hDC, TABP_TABITEM, TIS_NORMAL, &lpDIS->rcItem, NULL) == S_OK);
//            win_DrawThemeEdge (hTheme, lpDIS->hDC, TABP_TABITEM, TIS_NORMAL, &lpDIS->rcItem, uEdge, uFlags, &ContentRect);
         }
         
//         SetWindowText ((HWND) HMG_parnl (6), _TEXT("Theme"));
         TextOut(lpDIS->hDC, (lpDIS->rcItem.right + lpDIS->rcItem.left)/2, Size.cy, cText, lstrlen (cText) ); 
      }
            
}   
      TCHAR cBuffer [1024];
      wsprintf (cBuffer, _TEXT("%d - %d - %d  - %d "), (int)lpDIS->itemState, (int)lpDIS->itemID, (int)lpDIS->rcItem.left, (int)lpDIS->rcItem.top );
//      SetWindowText ((HWND) HMG_parnl (6), cBuffer);

      hb_retni ((INT) TRUE);
   }
}



HB_FUNC ( GETCURRENTTHEMENAME )
{
   WCHAR pszThemeFileName [ MAX_PATH ];
   win_GetCurrentThemeName (pszThemeFileName, MAX_PATH, NULL, 0, NULL, 0);
   HMG_retc (pszThemeFileName);
}


#pragma ENDDUMP


