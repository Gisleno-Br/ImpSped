/*
 * Harbour 3.2.0dev (r1703241902)
 * MinGW GNU C 5.3 (32-bit)
 * Generated C source from "C:\trab\img\Main.Prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( MAIN );
HB_FUNC_EXTERN( _DEFINEWINDOW );
HB_FUNC_EXTERN( _DEFINEIMAGE );
HB_FUNC_EXTERN( _ENDWINDOW );
HB_FUNC_EXTERN( DOMETHOD );
HB_FUNC_EXTERN( ERRORSYS );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_MAIN )
{ "MAIN", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( MAIN )}, NULL },
{ "_HMG_SYSDATA", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "_DEFINEWINDOW", {HB_FS_PUBLIC}, {HB_FUNCNAME( _DEFINEWINDOW )}, NULL },
{ "_DEFINEIMAGE", {HB_FS_PUBLIC}, {HB_FUNCNAME( _DEFINEIMAGE )}, NULL },
{ "_ENDWINDOW", {HB_FS_PUBLIC}, {HB_FUNCNAME( _ENDWINDOW )}, NULL },
{ "DOMETHOD", {HB_FS_PUBLIC}, {HB_FUNCNAME( DOMETHOD )}, NULL },
{ "ERRORSYS", {HB_FS_PUBLIC}, {HB_FUNCNAME( ERRORSYS )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_MAIN, "C:\\trab\\img\\Main.Prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_MAIN
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_MAIN )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		36,5,0,106,5,77,97,105,110,0,98,1,0,93,
		214,0,2,36,4,0,176,2,0,100,106,1,0,93,
		177,1,93,200,0,93,38,2,93,94,1,9,9,120,
		120,9,9,106,1,0,90,4,100,6,90,4,100,6,
		90,4,100,6,90,4,100,6,90,4,100,6,90,4,
		100,6,100,90,4,100,6,9,9,120,100,9,100,100,
		100,100,90,4,100,6,90,4,100,6,90,4,100,6,
		100,93,50,9,90,4,100,6,90,4,100,6,90,4,
		100,6,90,4,100,6,90,4,100,6,90,4,100,6,
		9,90,4,100,6,90,4,100,6,100,9,90,4,100,
		6,100,100,100,100,100,100,100,100,9,20,56,36,6,
		0,106,8,73,109,97,103,101,95,49,0,98,1,0,
		93,160,1,2,100,98,1,0,93,161,1,2,100,98,
		1,0,93,176,1,2,100,98,1,0,93,175,1,2,
		100,98,1,0,93,177,1,2,100,98,1,0,93,164,
		1,2,100,98,1,0,93,165,1,2,100,98,1,0,
		93,163,1,2,100,98,1,0,93,173,1,2,9,98,
		1,0,93,155,1,2,9,98,1,0,93,174,1,2,
		9,98,1,0,93,207,1,2,100,98,1,0,93,201,
		1,2,9,98,1,0,93,153,1,2,100,98,1,0,
		93,188,1,2,100,98,1,0,93,168,1,2,36,7,
		0,92,20,98,1,0,93,175,1,2,36,8,0,92,
		110,98,1,0,93,176,1,2,36,9,0,93,0,8,
		98,1,0,93,164,1,2,36,10,0,92,123,98,1,
		0,93,165,1,2,36,11,0,106,22,99,58,92,116,
		101,109,112,92,102,111,116,111,109,105,110,104,97,46,
		106,112,103,0,98,1,0,93,177,1,2,36,12,0,
		100,98,1,0,93,173,1,2,36,13,0,9,98,1,
		0,93,174,1,2,36,14,0,120,98,1,0,93,155,
		1,2,36,15,0,90,4,100,6,98,1,0,93,163,
		1,2,36,16,0,176,3,0,98,1,0,93,160,1,
		1,98,1,0,93,161,1,1,98,1,0,93,176,1,
		1,98,1,0,93,175,1,1,98,1,0,93,177,1,
		1,98,1,0,93,164,1,1,98,1,0,93,165,1,
		1,98,1,0,93,163,1,1,98,1,0,93,173,1,
		1,98,1,0,93,174,1,1,98,1,0,93,155,1,
		1,98,1,0,93,207,1,1,98,1,0,93,201,1,
		1,98,1,0,93,153,1,1,98,1,0,93,188,1,
		1,98,1,0,93,168,1,1,20,16,36,18,0,176,
		4,0,20,0,36,6,0,176,5,0,106,5,77,97,
		105,110,0,106,7,67,101,110,116,101,114,0,20,2,
		36,7,0,176,5,0,106,5,77,97,105,110,0,106,
		9,65,99,116,105,118,97,116,101,0,20,2,36,9,
		0,7
	};

	hb_vmExecute( pcode, symbols );
}

