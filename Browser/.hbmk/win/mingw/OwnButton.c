/*
 * Harbour 3.2.0dev (r1703241902)
 * MinGW GNU C 5.3 (32-bit)
 * Generated C source from "C:\trab\Browser\OwnButton.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( OBTN_CREATE );
HB_FUNC_EXTERN( _OWNBUTTONCREATE );
HB_FUNC_EXTERN( GETFORMHANDLE );
HB_FUNC_EXTERN( VALTYPE );
HB_FUNC( OBTN_SHAPE );
HB_FUNC( OBTN_COLOR );
HB_FUNC( OBTN_FONT );
HB_FUNC( OBTN_RELEASE );
HB_FUNC_EXTERN( GETDLGITEM );
HB_FUNC_EXTERN( GETFOCUS );
HB_FUNC_EXTERN( SETFOCUS );
HB_FUNC_EXTERN( GETNEXTDLGTABITEM );
HB_FUNC_EXTERN( DESTROYWINDOW );
HB_FUNC( OBTN_HANDLE );
HB_FUNC( OBTN_POS );
HB_FUNC_EXTERN( GETWINDOWRECT );
HB_FUNC_EXTERN( SCREENTOCLIENT );
HB_FUNC_EXTERN( PCOUNT );
HB_FUNC_EXTERN( MOVEWINDOW );
HB_FUNC( OBTN_VISIBLE );
HB_FUNC_EXTERN( SHOWWINDOW );
HB_FUNC_EXTERN( HIDEWINDOW );
HB_FUNC_EXTERN( ISWINDOWVISIBLE );
HB_FUNC( OBTN_ENABLE );
HB_FUNC_EXTERN( ENABLEWINDOW );
HB_FUNC_EXTERN( DISABLEWINDOW );
HB_FUNC_EXTERN( ISWINDOWENABLED );
HB_FUNC( OBTN_FOCUS );
HB_FUNC( OBTN_CAPTION );
HB_FUNC_EXTERN( SETWINDOWTEXT );
HB_FUNC_EXTERN( GETWINDOWTEXT );
HB_FUNC_EXTERN( HB_HHASKEY );
HB_FUNC_EXTERN( REDRAWWINDOW );
HB_FUNC( OBTN_DRAW );
HB_FUNC_EXTERN( GETFORMNAMEBYINDEX );
HB_FUNC_EXTERN( GETFORMINDEXBYHANDLE );
HB_FUNC_EXTERN( _OWNBUTTONDRAW );
HB_FUNC_EXTERN( ERRORSYS );
HB_FUNC_INITSTATICS();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_OWNBUTTON )
{ "OBTN_CREATE", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_CREATE )}, NULL },
{ "_OWNBUTTONCREATE", {HB_FS_PUBLIC}, {HB_FUNCNAME( _OWNBUTTONCREATE )}, NULL },
{ "GETFORMHANDLE", {HB_FS_PUBLIC}, {HB_FUNCNAME( GETFORMHANDLE )}, NULL },
{ "_HMG_SYSDATA", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "VALTYPE", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALTYPE )}, NULL },
{ "OBTN_SHAPE", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_SHAPE )}, NULL },
{ "OBTN_COLOR", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_COLOR )}, NULL },
{ "OBTN_FONT", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_FONT )}, NULL },
{ "OBTN_RELEASE", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_RELEASE )}, NULL },
{ "GETDLGITEM", {HB_FS_PUBLIC}, {HB_FUNCNAME( GETDLGITEM )}, NULL },
{ "GETFOCUS", {HB_FS_PUBLIC}, {HB_FUNCNAME( GETFOCUS )}, NULL },
{ "SETFOCUS", {HB_FS_PUBLIC}, {HB_FUNCNAME( SETFOCUS )}, NULL },
{ "GETNEXTDLGTABITEM", {HB_FS_PUBLIC}, {HB_FUNCNAME( GETNEXTDLGTABITEM )}, NULL },
{ "DESTROYWINDOW", {HB_FS_PUBLIC}, {HB_FUNCNAME( DESTROYWINDOW )}, NULL },
{ "OBTN_HANDLE", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_HANDLE )}, NULL },
{ "OBTN_POS", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_POS )}, NULL },
{ "GETWINDOWRECT", {HB_FS_PUBLIC}, {HB_FUNCNAME( GETWINDOWRECT )}, NULL },
{ "SCREENTOCLIENT", {HB_FS_PUBLIC}, {HB_FUNCNAME( SCREENTOCLIENT )}, NULL },
{ "PCOUNT", {HB_FS_PUBLIC}, {HB_FUNCNAME( PCOUNT )}, NULL },
{ "MOVEWINDOW", {HB_FS_PUBLIC}, {HB_FUNCNAME( MOVEWINDOW )}, NULL },
{ "OBTN_VISIBLE", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_VISIBLE )}, NULL },
{ "SHOWWINDOW", {HB_FS_PUBLIC}, {HB_FUNCNAME( SHOWWINDOW )}, NULL },
{ "HIDEWINDOW", {HB_FS_PUBLIC}, {HB_FUNCNAME( HIDEWINDOW )}, NULL },
{ "ISWINDOWVISIBLE", {HB_FS_PUBLIC}, {HB_FUNCNAME( ISWINDOWVISIBLE )}, NULL },
{ "OBTN_ENABLE", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_ENABLE )}, NULL },
{ "ENABLEWINDOW", {HB_FS_PUBLIC}, {HB_FUNCNAME( ENABLEWINDOW )}, NULL },
{ "DISABLEWINDOW", {HB_FS_PUBLIC}, {HB_FUNCNAME( DISABLEWINDOW )}, NULL },
{ "ISWINDOWENABLED", {HB_FS_PUBLIC}, {HB_FUNCNAME( ISWINDOWENABLED )}, NULL },
{ "OBTN_FOCUS", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_FOCUS )}, NULL },
{ "OBTN_CAPTION", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_CAPTION )}, NULL },
{ "SETWINDOWTEXT", {HB_FS_PUBLIC}, {HB_FUNCNAME( SETWINDOWTEXT )}, NULL },
{ "GETWINDOWTEXT", {HB_FS_PUBLIC}, {HB_FUNCNAME( GETWINDOWTEXT )}, NULL },
{ "HB_HHASKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_HHASKEY )}, NULL },
{ "REDRAWWINDOW", {HB_FS_PUBLIC}, {HB_FUNCNAME( REDRAWWINDOW )}, NULL },
{ "OBTN_DRAW", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( OBTN_DRAW )}, NULL },
{ "GETFORMNAMEBYINDEX", {HB_FS_PUBLIC}, {HB_FUNCNAME( GETFORMNAMEBYINDEX )}, NULL },
{ "GETFORMINDEXBYHANDLE", {HB_FS_PUBLIC}, {HB_FUNCNAME( GETFORMINDEXBYHANDLE )}, NULL },
{ "_OWNBUTTONDRAW", {HB_FS_PUBLIC}, {HB_FUNCNAME( _OWNBUTTONDRAW )}, NULL },
{ "ERRORSYS", {HB_FS_PUBLIC}, {HB_FUNCNAME( ERRORSYS )}, NULL },
{ "(_INITSTATICS00003)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITSTATICS}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_OWNBUTTON, "C:\\trab\\Browser\\OwnButton.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_OWNBUTTON
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_OWNBUTTON )
   #include "hbiniseg.h"
#endif

HB_FUNC( OBTN_CREATE )
{
	static const HB_BYTE pcode[] =
	{
		13,22,13,36,77,0,176,1,0,176,2,0,95,1,
		12,1,95,2,95,3,95,4,95,5,95,6,95,7,
		95,8,95,9,95,10,12,10,80,14,36,79,0,121,
		80,15,36,80,0,121,80,16,36,81,0,97,255,255,
		255,0,80,17,36,82,0,97,255,255,255,0,80,18,
		36,83,0,121,80,19,36,84,0,97,128,128,128,0,
		80,20,36,85,0,97,128,128,128,0,80,21,36,86,
		0,97,224,224,224,0,80,22,36,87,0,97,224,224,
		224,0,80,23,36,88,0,121,80,24,36,89,0,121,
		80,25,36,90,0,121,80,26,36,91,0,97,255,255,
		255,0,80,27,36,92,0,97,255,255,255,0,80,28,
		36,93,0,121,80,29,36,95,0,98,3,0,93,86,
		1,1,80,30,36,96,0,98,3,0,93,87,1,1,
		80,31,36,97,0,9,80,32,36,98,0,9,80,33,
		36,99,0,9,80,34,36,100,0,9,80,35,36,102,
		0,95,14,121,69,29,147,3,36,103,0,176,4,0,
		95,12,12,1,106,2,65,0,8,29,77,2,36,104,
		0,176,4,0,95,12,122,1,12,1,106,2,65,0,
		8,29,171,0,36,105,0,176,4,0,95,12,122,1,
		122,1,12,1,106,2,78,0,8,28,13,36,106,0,
		95,12,122,1,122,1,80,15,36,108,0,176,4,0,
		95,12,122,1,92,2,1,12,1,106,2,78,0,8,
		28,14,36,109,0,95,12,122,1,92,2,1,80,16,
		36,111,0,176,4,0,95,12,122,1,92,3,1,12,
		1,106,2,78,0,8,28,14,36,112,0,95,12,122,
		1,92,3,1,80,17,36,114,0,176,4,0,95,12,
		122,1,92,4,1,12,1,106,2,78,0,8,28,14,
		36,115,0,95,12,122,1,92,4,1,80,18,36,117,
		0,176,4,0,95,12,122,1,92,5,1,12,1,106,
		2,78,0,8,28,14,36,118,0,95,12,122,1,92,
		5,1,80,19,36,122,0,176,4,0,95,12,92,2,
		1,12,1,106,2,65,0,8,29,181,0,36,123,0,
		176,4,0,95,12,92,2,1,122,1,12,1,106,2,
		78,0,8,28,14,36,124,0,95,12,92,2,1,122,
		1,80,20,36,126,0,176,4,0,95,12,92,2,1,
		92,2,1,12,1,106,2,78,0,8,28,15,36,127,
		0,95,12,92,2,1,92,2,1,80,21,36,129,0,
		176,4,0,95,12,92,2,1,92,3,1,12,1,106,
		2,78,0,8,28,15,36,130,0,95,12,92,2,1,
		92,3,1,80,22,36,132,0,176,4,0,95,12,92,
		2,1,92,4,1,12,1,106,2,78,0,8,28,15,
		36,133,0,95,12,92,2,1,92,4,1,80,23,36,
		135,0,176,4,0,95,12,92,2,1,92,5,1,12,
		1,106,2,78,0,8,28,15,36,136,0,95,12,92,
		2,1,92,5,1,80,24,36,140,0,176,4,0,95,
		12,92,3,1,12,1,106,2,65,0,8,29,181,0,
		36,141,0,176,4,0,95,12,92,3,1,122,1,12,
		1,106,2,78,0,8,28,14,36,142,0,95,12,92,
		3,1,122,1,80,25,36,144,0,176,4,0,95,12,
		92,3,1,92,2,1,12,1,106,2,78,0,8,28,
		15,36,145,0,95,12,92,3,1,92,2,1,80,26,
		36,147,0,176,4,0,95,12,92,3,1,92,3,1,
		12,1,106,2,78,0,8,28,15,36,148,0,95,12,
		92,3,1,92,3,1,80,27,36,150,0,176,4,0,
		95,12,92,3,1,92,4,1,12,1,106,2,78,0,
		8,28,15,36,151,0,95,12,92,3,1,92,4,1,
		80,28,36,153,0,176,4,0,95,12,92,3,1,92,
		5,1,12,1,106,2,78,0,8,28,15,36,154,0,
		95,12,92,3,1,92,5,1,80,29,36,159,0,176,
		4,0,95,13,12,1,106,2,65,0,8,29,181,0,
		36,160,0,176,4,0,95,13,122,1,12,1,106,2,
		67,0,8,28,11,36,161,0,95,13,122,1,80,30,
		36,163,0,176,4,0,95,13,92,2,1,12,1,106,
		2,78,0,8,28,12,36,164,0,95,13,92,2,1,
		80,31,36,166,0,176,4,0,95,13,92,3,1,12,
		1,106,2,76,0,8,28,12,36,167,0,95,13,92,
		3,1,80,32,36,169,0,176,4,0,95,13,92,4,
		1,12,1,106,2,76,0,8,28,12,36,170,0,95,
		13,92,4,1,80,33,36,172,0,176,4,0,95,13,
		92,5,1,12,1,106,2,76,0,8,28,12,36,173,
		0,95,13,92,5,1,80,34,36,175,0,176,4,0,
		95,13,92,6,1,12,1,106,2,76,0,8,28,12,
		36,176,0,95,13,92,6,1,80,35,36,180,0,176,
		5,0,95,1,95,2,176,4,0,95,11,12,1,106,
		2,78,0,8,28,6,95,11,25,3,121,20,3,36,
		181,0,176,6,0,95,1,95,2,95,15,95,16,95,
		17,95,18,95,19,4,5,0,95,20,95,21,95,22,
		95,23,95,24,4,5,0,95,25,95,26,95,27,95,
		28,95,29,4,5,0,4,3,0,20,3,36,182,0,
		176,7,0,95,1,95,2,95,30,95,31,95,32,95,
		33,95,34,95,35,4,6,0,20,3,36,185,0,95,
		14,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_RELEASE )
{
	static const HB_BYTE pcode[] =
	{
		13,2,2,36,189,0,176,2,0,95,1,12,1,80,
		3,36,190,0,176,9,0,95,3,95,2,12,2,80,
		4,36,192,0,176,10,0,12,0,95,4,8,28,20,
		36,193,0,176,11,0,176,12,0,95,3,95,4,9,
		12,3,20,1,36,196,0,176,13,0,176,9,0,95,
		3,95,2,12,2,20,1,36,198,0,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_HANDLE )
{
	static const HB_BYTE pcode[] =
	{
		13,0,2,36,203,0,176,9,0,176,2,0,95,1,
		12,1,95,2,20,2,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_POS )
{
	static const HB_BYTE pcode[] =
	{
		13,3,6,36,207,0,176,2,0,95,1,12,1,80,
		7,36,208,0,176,9,0,95,7,95,2,12,2,80,
		8,36,209,0,121,121,121,121,4,4,0,80,9,36,
		211,0,176,16,0,95,8,95,9,20,2,36,212,0,
		95,9,92,3,1,95,9,122,1,49,95,9,92,3,
		2,36,213,0,95,9,92,4,1,95,9,92,2,1,
		49,95,9,92,4,2,36,214,0,176,17,0,95,7,
		95,9,122,148,95,9,92,2,148,20,3,36,216,0,
		176,18,0,12,0,92,3,35,28,29,36,217,0,95,
		9,92,2,1,95,9,122,1,95,9,92,3,1,95,
		9,92,4,1,4,4,0,110,7,36,220,0,176,4,
		0,95,3,12,1,106,2,78,0,69,28,12,36,221,
		0,95,9,92,2,1,80,3,36,224,0,176,4,0,
		95,4,12,1,106,2,78,0,69,28,11,36,225,0,
		95,9,122,1,80,4,36,228,0,176,4,0,95,5,
		12,1,106,2,78,0,69,28,12,36,229,0,95,9,
		92,3,1,80,5,36,232,0,176,4,0,95,6,12,
		1,106,2,78,0,69,28,12,36,233,0,95,9,92,
		4,1,80,6,36,236,0,176,19,0,95,8,95,4,
		95,3,95,5,95,6,120,20,6,36,238,0,176,15,
		0,95,1,95,2,20,2,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_VISIBLE )
{
	static const HB_BYTE pcode[] =
	{
		13,1,3,36,242,0,176,9,0,176,2,0,95,1,
		12,1,95,2,12,2,80,4,36,244,0,176,4,0,
		95,3,12,1,106,2,76,0,8,28,67,36,245,0,
		95,3,28,14,36,246,0,176,21,0,95,4,20,1,
		25,48,36,248,0,176,10,0,12,0,95,4,8,28,
		25,36,249,0,176,11,0,176,12,0,176,2,0,95,
		1,12,1,95,4,9,12,3,20,1,36,252,0,176,
		22,0,95,4,20,1,36,0,1,176,23,0,95,4,
		20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_ENABLE )
{
	static const HB_BYTE pcode[] =
	{
		13,1,3,36,4,1,176,9,0,176,2,0,95,1,
		12,1,95,2,12,2,80,4,36,6,1,176,4,0,
		95,3,12,1,106,2,76,0,8,28,67,36,7,1,
		95,3,28,14,36,8,1,176,25,0,95,4,20,1,
		25,48,36,10,1,176,10,0,12,0,95,4,8,28,
		25,36,11,1,176,11,0,176,12,0,176,2,0,95,
		1,12,1,95,4,9,12,3,20,1,36,14,1,176,
		26,0,95,4,20,1,36,18,1,176,27,0,95,4,
		20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_FOCUS )
{
	static const HB_BYTE pcode[] =
	{
		13,1,3,36,22,1,176,9,0,176,2,0,95,1,
		12,1,95,2,12,2,80,4,36,24,1,176,4,0,
		95,3,12,1,106,2,76,0,8,28,25,95,3,28,
		21,176,27,0,95,4,12,1,28,12,36,25,1,176,
		11,0,95,4,20,1,36,28,1,176,10,0,12,0,
		95,4,8,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_CAPTION )
{
	static const HB_BYTE pcode[] =
	{
		13,1,3,36,32,1,176,9,0,176,2,0,95,1,
		12,1,95,2,12,2,80,4,36,34,1,176,4,0,
		95,3,12,1,106,2,67,0,8,28,14,36,35,1,
		176,30,0,95,4,95,3,20,2,36,38,1,176,31,
		0,95,4,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_FONT )
{
	static const HB_BYTE pcode[] =
	{
		13,0,4,116,39,0,36,44,1,176,4,0,95,3,
		12,1,106,2,65,0,8,29,96,1,36,45,1,176,
		32,0,103,1,0,95,1,12,2,29,21,1,36,46,
		1,176,32,0,103,1,0,95,1,1,95,2,12,2,
		29,242,0,36,47,1,176,4,0,95,3,122,1,12,
		1,106,2,67,0,8,28,20,36,48,1,95,3,122,
		1,103,1,0,95,1,1,95,2,1,122,2,36,50,
		1,176,4,0,95,3,92,2,1,12,1,106,2,78,
		0,8,28,22,36,51,1,95,3,92,2,1,103,1,
		0,95,1,1,95,2,1,92,2,2,36,53,1,176,
		4,0,95,3,92,3,1,12,1,106,2,76,0,8,
		28,22,36,54,1,95,3,92,3,1,103,1,0,95,
		1,1,95,2,1,92,3,2,36,56,1,176,4,0,
		95,3,92,4,1,12,1,106,2,76,0,8,28,22,
		36,57,1,95,3,92,4,1,103,1,0,95,1,1,
		95,2,1,92,4,2,36,59,1,176,4,0,95,3,
		92,5,1,12,1,106,2,76,0,8,28,22,36,60,
		1,95,3,92,5,1,103,1,0,95,1,1,95,2,
		1,92,5,2,36,62,1,176,4,0,95,3,92,6,
		1,12,1,106,2,76,0,8,28,56,36,63,1,95,
		3,92,6,1,103,1,0,95,1,1,95,2,1,92,
		6,2,25,34,36,66,1,95,3,103,1,0,95,1,
		1,95,2,2,25,18,36,69,1,95,2,95,3,177,
		1,0,103,1,0,95,1,2,36,72,1,176,4,0,
		95,4,12,1,106,2,76,0,8,28,28,95,4,28,
		24,36,73,1,176,33,0,176,9,0,176,2,0,95,
		1,12,1,95,2,12,2,20,1,36,77,1,176,32,
		0,103,1,0,95,1,12,2,28,28,176,32,0,103,
		1,0,95,1,1,95,2,12,2,28,13,103,1,0,
		95,1,1,95,2,1,25,3,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_SHAPE )
{
	static const HB_BYTE pcode[] =
	{
		13,0,4,116,39,0,36,83,1,176,4,0,95,3,
		12,1,106,2,78,0,8,28,94,36,84,1,176,32,
		0,103,2,0,95,1,12,2,28,18,36,85,1,95,
		3,103,2,0,95,1,1,95,2,2,25,18,36,87,
		1,95,2,95,3,177,1,0,103,2,0,95,1,2,
		36,90,1,176,4,0,95,4,12,1,106,2,76,0,
		8,28,74,95,4,28,70,36,91,1,176,33,0,176,
		9,0,176,2,0,95,1,12,1,95,2,12,2,20,
		1,25,46,36,94,1,176,32,0,103,2,0,95,1,
		12,2,28,31,176,32,0,103,2,0,95,1,1,95,
		2,12,2,28,16,36,95,1,103,2,0,95,1,1,
		95,2,1,80,3,36,99,1,95,3,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_COLOR )
{
	static const HB_BYTE pcode[] =
	{
		13,0,4,116,39,0,36,105,1,176,4,0,95,3,
		12,1,106,2,65,0,8,29,120,3,36,106,1,176,
		32,0,103,3,0,95,1,12,2,29,45,3,36,107,
		1,176,32,0,103,3,0,95,1,1,95,2,12,2,
		29,10,3,36,108,1,176,4,0,95,3,122,1,12,
		1,106,2,65,0,8,29,230,0,36,109,1,176,4,
		0,95,3,122,1,122,1,12,1,106,2,78,0,8,
		28,24,36,110,1,95,3,122,1,122,1,103,3,0,
		95,1,1,95,2,1,122,1,122,2,36,112,1,176,
		4,0,95,3,122,1,92,2,1,12,1,106,2,78,
		0,8,28,26,36,113,1,95,3,122,1,92,2,1,
		103,3,0,95,1,1,95,2,1,122,1,92,2,2,
		36,115,1,176,4,0,95,3,122,1,92,3,1,12,
		1,106,2,78,0,8,28,26,36,116,1,95,3,122,
		1,92,3,1,103,3,0,95,1,1,95,2,1,122,
		1,92,3,2,36,118,1,176,4,0,95,3,122,1,
		92,4,1,12,1,106,2,78,0,8,28,26,36,119,
		1,95,3,122,1,92,4,1,103,3,0,95,1,1,
		95,2,1,122,1,92,4,2,36,121,1,176,4,0,
		95,3,122,1,92,5,1,12,1,106,2,78,0,8,
		28,26,36,122,1,95,3,122,1,92,5,1,103,3,
		0,95,1,1,95,2,1,122,1,92,5,2,36,126,
		1,176,4,0,95,3,92,2,1,12,1,106,2,65,
		0,8,29,245,0,36,127,1,176,4,0,95,3,92,
		2,1,122,1,12,1,106,2,78,0,8,28,26,36,
		128,1,95,3,92,2,1,122,1,103,3,0,95,1,
		1,95,2,1,92,2,1,122,2,36,130,1,176,4,
		0,95,3,92,2,1,92,2,1,12,1,106,2,78,
		0,8,28,28,36,131,1,95,3,92,2,1,92,2,
		1,103,3,0,95,1,1,95,2,1,92,2,1,92,
		2,2,36,133,1,176,4,0,95,3,92,2,1,92,
		3,1,12,1,106,2,78,0,8,28,28,36,134,1,
		95,3,92,2,1,92,3,1,103,3,0,95,1,1,
		95,2,1,92,2,1,92,3,2,36,136,1,176,4,
		0,95,3,92,2,1,92,4,1,12,1,106,2,78,
		0,8,28,28,36,137,1,95,3,92,2,1,92,4,
		1,103,3,0,95,1,1,95,2,1,92,2,1,92,
		4,2,36,139,1,176,4,0,95,3,92,2,1,92,
		5,1,12,1,106,2,78,0,8,28,28,36,140,1,
		95,3,92,2,1,92,5,1,103,3,0,95,1,1,
		95,2,1,92,2,1,92,5,2,36,144,1,176,4,
		0,95,3,92,3,1,12,1,106,2,65,0,8,29,
		23,1,36,145,1,176,4,0,95,3,92,3,1,122,
		1,12,1,106,2,78,0,8,28,26,36,146,1,95,
		3,92,3,1,122,1,103,3,0,95,1,1,95,2,
		1,92,3,1,122,2,36,148,1,176,4,0,95,3,
		92,3,1,92,2,1,12,1,106,2,78,0,8,28,
		28,36,149,1,95,3,92,3,1,92,2,1,103,3,
		0,95,1,1,95,2,1,92,3,1,92,2,2,36,
		151,1,176,4,0,95,3,92,3,1,92,3,1,12,
		1,106,2,78,0,8,28,28,36,152,1,95,3,92,
		3,1,92,3,1,103,3,0,95,1,1,95,2,1,
		92,3,1,92,3,2,36,154,1,176,4,0,95,3,
		92,3,1,92,4,1,12,1,106,2,78,0,8,28,
		28,36,155,1,95,3,92,3,1,92,4,1,103,3,
		0,95,1,1,95,2,1,92,3,1,92,4,2,36,
		157,1,176,4,0,95,3,92,3,1,92,5,1,12,
		1,106,2,78,0,8,28,62,36,158,1,95,3,92,
		3,1,92,5,1,103,3,0,95,1,1,95,2,1,
		92,3,1,92,5,2,25,34,36,162,1,95,3,103,
		3,0,95,1,1,95,2,2,25,18,36,165,1,95,
		2,95,3,177,1,0,103,3,0,95,1,2,36,168,
		1,176,4,0,95,4,12,1,106,2,76,0,8,28,
		28,95,4,28,24,36,169,1,176,33,0,176,9,0,
		176,2,0,95,1,12,1,95,2,12,2,20,1,36,
		173,1,176,32,0,103,3,0,95,1,12,2,28,28,
		176,32,0,103,3,0,95,1,1,95,2,12,2,28,
		13,103,3,0,95,1,1,95,2,1,25,3,100,110,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( OBTN_DRAW )
{
	static const HB_BYTE pcode[] =
	{
		13,5,3,36,177,1,176,35,0,176,36,0,95,1,
		12,1,12,1,80,4,36,178,1,176,5,0,95,4,
		95,2,12,2,80,5,36,179,1,176,6,0,95,4,
		95,2,12,2,80,6,36,180,1,176,7,0,95,4,
		95,2,12,2,80,7,36,181,1,176,14,0,95,4,
		95,2,12,2,80,8,36,183,1,176,37,0,95,3,
		95,8,20,2,36,185,1,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITSTATICS()
{
	static const HB_BYTE pcode[] =
	{
		117,39,0,3,0,116,39,0,177,0,0,82,1,0,
		177,0,0,82,2,0,177,0,0,82,3,0,7
	};

	hb_vmExecute( pcode, symbols );
}

#line 445 "C:\\trab\\Browser\\OwnButton.prg"

#include "SET_COMPILE_HMG_UNICODE.ch"
#include "HMG_UNICODE.h"
#include <windows.h>
#include <commctrl.h>
#include <math.h>
#include "hbapi.h"
#include "tchar.h"

//static HBRUSH CreateGradientBrush();


       //                 1         2    3          4       5       6         7          8           9           10
       //_OwnButtonCreate(nHParent, nID, cCaption, [nRow], [nCol], [nWidth], [nHeight], [lEnabled], [lVisible], [lTabStop])
HB_FUNC( _OWNBUTTONCREATE )
{
  
  //DWORD  dwStyle =  WS_BORDER | WS_VISIBLE | WS_TABSTOP | WS_CHILD | LVS_REPORT | LVS_OWNERDRAWFIXED| LVS_EX_FULLROWSELECT ;
  //DWORD dwStyle = WS_BORDER | WS_VISIBLE | WS_TABSTOP | WS_CHILD | LVS_REPORT | LVS_OWNERDRAWFIXED | LVS_EX_FULLROWSELECT;
  DWORD dwStyle =  WS_BORDER | WS_VISIBLE | WS_TABSTOP | WS_CHILD | LVS_REPORT | LVS_EX_FULLROWSELECT ;
  // LVS_REPORT | LVS_OWNERDRAWFIXED 
  HWND hButton;

/*
  if (! hb_parldef(8, 1))
    dwStyle |= WS_DISABLED;
  if (hb_parldef(9, 1))
    dwStyle |= WS_VISIBLE;
  if (hb_parldef(10, 1))
    dwStyle |= WS_CLIPSIBLINGS;
    */
    
    //WC_BUTTON
    

  hButton = CreateWindowEx( 0 ,
                           WC_LISTVIEW  ,
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
                           
  SetClassLong( (LONG_PTR) hButton  , GCL_HCURSOR, ( LONG ) LoadCursor( NULL, IDC_HAND ) );
  
  //ListView_SetExtendedListViewStyleEx( (LPCTSTR) HMG_parc(3)  , 0, LVS_EX_GRIDLINES |  LVS_EX_FULLROWSELECT);
  
  SendMessage((LONG_PTR) hButton  ,LVM_SETEXTENDEDLISTVIEWSTYLE, 0,  WS_BORDER | WS_VISIBLE | WS_TABSTOP | WS_CHILD | LVS_REPORT | LVS_EX_FULLROWSELECT  );
  
  
  //LVS_EX_FULLROWSELECT | LVS_TYPESTYLEMASK | LVS_NOCOLUMNHEADER | LVS_OWNERDRAWFIXED );   // add (LPARAM)
  
  //ListView_Update( (LONG_PTR) hButton , 2);
  
                           
  HMG_retnl((LONG_PTR) hButton);
}


       //               1                2       3        4        5        6
       //_OwnButtonDraw(nDRAWITEMSTRUCT, nShape, aColor1, aColor2, aColor3, aFont)
HB_FUNC( _OWNBUTTONDRAW )
{
  DRAWITEMSTRUCT *pDIS = (DRAWITEMSTRUCT *) HMG_parnl(1);
  
  // lRow = lDraw->rcItem;
 //  //lItem = lDraw->itemID;
  HDC hDc1;
  //INT rItem;
  INT DrawState;
  
  HWND hWnd = (HWND) HMG_parnl (2);
  
  
//  INT nTextLen = GetWindowTextLength(pDIS->hwndItem) + 1;  
  //TCHAR *Text  = (TCHAR *) hb_xgrab(nTextLen * sizeof(TCHAR));  
  //GetWindowText(pDIS->hwndItem, Text, nTextLen);
  
  RECT Rct1;
  
  Rct1 = pDIS->rcItem;
  
  DrawState = pDIS->itemState;
  
  hDc1 = pDIS->hDC;
  
  int Item;
  
  RECT Prc;
  
  Item = pDIS->itemID;
  //Item = 1;
  
  RECT Rect ;  
  int  code = (int)  LVIR_LABEL;  
  //MessageBox( 0, "Window Registration Failed!", "Error!", MB_ICONEXCLAMATION | MB_OK | MB_SYSTEMMODAL );
  
  //ListView_GetItemRect ( hWnd, i, &Rect, LVIR_LABEL );
  
  //ListView_GetItemRect( hWnd    ,  &Rct1 , Item  ,    code );
  
  TCHAR string [1024];
  
  ListView_GetItemRect(hWnd, Item, &Prc , code );
  
  //ListView_GetSubItemRect ( hWnd, iItem, iSubItem, code, &Rect ) ;
  
  ListView_GetItemText (hWnd, Item , 1 , string, 1024);
  
  
  //GetItemText(nItem, 0)
  
  //ListView_GetItemText(hWnd , lItem, 0, buffer, 5000);
    
  
 MessageBox( GetActiveWindow(),  string , Item  , MB_OK | MB_ICONSTOP | MB_SYSTEMMODAL );
  
  /*
  Rct1.right  = pDIS->rcItem.right;
  Rct1.left   = pDIS->rcItem.left;
  Rct1.top    = pDIS->rcItem.top;
  Rct1.bottom = pDIS->rcItem.bottom;
  */
  
  
  //RECT Prc;
  
  //hBrush = CreateGradientBrush(pDIS->hDC, (pDIS->rcItem.right  - pDIS->rcItem.left), (pDIS->rcItem.bottom - pDIS->rcItem.top), 1 , 2, RGB(255,255,255) , RGB(255,255,255));
  //hPen   = CreatePen(PS_INSIDEFRAME, 1, FrameColor);
  //hFont  = CreateFont(-MulDiv(nFontSize, GetDeviceCaps(pDIS->hDC, LOGPIXELSY), 72), 0, 0, 0, nBold, nItalic, nUnderline, nStrikeOut, DEFAULT_CHARSET, OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH | FF_DONTCARE, FontName);
  
  HBRUSH   hBrush;
  HBRUSH   hBrush2;
  HBRUSH   hBrushOld;
  
  
  hBrush = CreateSolidBrush(  0xFBF23F);
  hBrushOld = SelectObject(pDIS->hDC, hBrush);
  //hPenOld   = SelectObject(pDIS->hDC, hPen);
  //hFontOld  = SelectObject(pDIS->hDC, hFont);
  
  // SelectObject(hDc1, CreateFont(17, 0, 0, 0, FW_NORMAL, 0, 0, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, "Arial Black"));

   FillRect(pDIS->hDC, &Rct1 , hBrush );

   //SetBkMode(pDIS->hDC ,  0xE0E0E0);
   SetTextColor(pDIS->hDC, RGB(255,255,255));
  
  //SetTextColor( hDc1 , GetSysColor( COLOR_HIGHLIGHTTEXT ) );
  //SetBkColor ( hDc1 ,  (COLORREF) RGB( 23, 46,  120 )  );
  //FillRect ( hDc1 , &Rct1  , (HBRUSH) GetSysColor( COLOR_HIGHLIGHT ) );
  
  /*
     if ( DrawState == ODS_SELECTED )
        {
            SetTextColor( hdc1 , GetSysColor( COLOR_HIGHLIGHTTEXT ) );
            SetBkColor ( hdc1 , GetSysColor( COLOR_HIGHLIGHT ) );
            FillRect ( hdc1 , &Rct1  , (HBRUSH) GetSysColor( COLOR_HIGHLIGHT ) );
        }
        else if ( DrawState == ODS_DEFAULT )
        {
            SetTextColor( hdc1 , pDIS->itemID % 2 == 1 ? GetSysColor( COLOR_WINDOWTEXT ) : GetSysColor( COLOR_MENUTEXT ) );
            SetBkColor ( hdc1 , pDIS->itemID % 2 == 1 ? GetSysColor( COLOR_WINDOW ) : GetSysColor( COLOR_MENU ) );
            FillRect ( hdc1 , &Rct1 , pDIS->itemID % 2 == 1 ? (HBRUSH) GetSysColor( COLOR_WINDOW ) : (HBRUSH) GetSysColor( COLOR_MENU ) );
        }
  */
  
        //ListView_GetItemRect(listview, pDIS->itemID  , prc, LVIR_BOUNDS);
        
        //DrawText(hdc1 , 'ok!'  , -1, prc, DT_CALCRECT);
       //DrawText (hDc1, cText1 , -1, &Rct1    , DT_NOCLIP | DT_WORDBREAK | /*DT_EXTERNALLEADING |*/ DT_NOPREFIX | 0);
        
    
  // RECT* prc;
  
    //INT lRow = pDIS->rcItem.Right;
            
  /*

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
  
  */
  
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

