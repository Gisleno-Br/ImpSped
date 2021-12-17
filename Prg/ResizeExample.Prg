/*
 * MINIGUI - Harbour Win32 GUI library Demo
 * bpd2000@gmail.com
*/

#include "minigui.ch"

FUNCTION MAIN

Define window oEdit At 0,0 width 600 height 400 main title "Move & Resize Control?" 

   Public nTitleBarHeight := GetTitleHeight()
   Public nBorderWidth := GetBorderWidth()
	
   DEFINE STATUSBAR Font "Arial" SIZE 8
			STATUSITEM "" 
		END STATUSBAR

      DEFINE button MoveControl1
         Row 220
         Col 15
         width 120
         backcolor rgb(34,34,34)
		 height 30
         caption "TEST BUTTON"
       action MsgBox( "Call context menu of this button to move or resize control" )
       END button
       
       DEFINE label lbl1
         Row 140
         Col 15
         width 185
         value "SDFDFD"
         backcolor rgb(34,34,34)
         transparent .t.
		 height 30
         caption "Lbel2"
       action MsgBox( "Call context menu of this button to move or resize control" )
       END button

	   DEFINE CONTROL CONTEXTMENU  MoveControl1
			MenuItem "Move button"	action moveControl( "lbl1" )
			MenuItem "Resize button"	action ResizeControl( "lbl1" )
		END MENU
End window

oEdit.center
oEdit.activate

return nil

************************************

PROCEDURE MoveControl( cControlName )
   LOCAL ControlHandle

	DoMethod(ThisWindow.Name, cControlName, "SetFocus")

	ControlHandle := GetControlHandle(cControlName, thisWindow.Name)

	InterActiveMove()
	nCurrentCol := GetWindowCol( ControlHandle ) - oEdit.Col - nBorderWidth
	nCurrentRow := GetWindowrow( ControlHandle ) - oEdit.Row - nTitleBarHeight - nBorderWidth
	//nCurrentCol := int(nCurrentCol / 10) * 10
	//nCurrentRow := int(nCurrentRow / 10) * 10


	SetProperty(ThisWindow.Name, cControlName,"Col", nCurrentCol)
	SetProperty(ThisWindow.Name, cControlName,"Row", nCurrentRow)
	
	msginfo('ok')
	

RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ResizeControl( cControlName )
	LOCAL ControlHandle := GetControlHandle( cControlName, 'oEdit' )
	local nNewWidth, nNewHeight
	
	DoMethod(ThisWindow.Name, cControlName, "SetFocus")
	ControlHandle := GetControlHandle(cControlName, thisWindow.Name)
	InterActiveSize()
	nNewWidth	:= GetWindowWidth( ControlHandle )
	nNewHeight	:= GetWindowHeight( ControlHandle )
	SetProperty(ThisWindow.Name, cControlName,"Width",nNewWidth)
	SetProperty(ThisWindow.Name, cControlName,"Height", nNewHeight )
	
	msginfo('ok')

RETURN

/*----------------------------------------------------------------------*/

*******************************************************

#pragma BEGINDUMP

#include <windows.h>

#include "hbapi.h"

HB_FUNC( SETPIXEL )
{
   hb_retnl( (ULONG) SetPixel( (HDC) hb_parnl( 1 ) ,
				hb_parni( 2 )      ,
				hb_parni( 3 )      ,
			(COLORREF) hb_parnl( 4 ) ) );
}

HB_FUNC( SETCROSSCURSOR )
{
   SetClassLong( ( HWND ) hb_parnl(1), GCL_HCURSOR, ( LONG ) LoadCursor(NULL, IDC_CROSS) );
}

HB_FUNC( INTERACTIVEMOVE )
{
   keybd_event(
      VK_RIGHT,  // virtual-key code
      0,         // hardware scan code
      0,         // flags specifying various function options
      0          // additional data associated with keystroke
      );

   keybd_event(
      VK_LEFT,   // virtual-key code
      0,         // hardware scan code
      0,         // flags specifying various function options
      0          // additional data associated with keystroke
      );

   SendMessage( GetFocus(), WM_SYSCOMMAND, SC_MOVE, 10 );
   RedrawWindow( GetFocus(), NULL, NULL, RDW_ERASE | RDW_INVALIDATE | RDW_ALLCHILDREN | RDW_ERASENOW | RDW_UPDATENOW );
}

HB_FUNC( INTERACTIVESIZE )
{
   keybd_event(
      VK_DOWN,
      0,
      0,
      0
      );

   keybd_event(
      VK_RIGHT,
      0,
      0,
      0
      );

   SendMessage( GetFocus(), WM_SYSCOMMAND, SC_SIZE ,  0 );
}

#pragma ENDDUMP