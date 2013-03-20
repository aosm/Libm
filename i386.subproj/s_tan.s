/*
 * Written by J.T. Conklin <jtc@netbsd.org>.
 * Public domain.
 */

#include <machine/asm.h>

#include "abi.h"

RCSID("$NetBSD: s_tan.S,v 1.6 2001/06/19 00:26:31 fvdl Exp $")


PRIVATE_ENTRY(__tanl)  //not public. Currently used by single and double precision entry points.
ENTRY(tanl)
	XMM_ONE_ARG_LONG_DOUBLE_PROLOGUE
	fldt	ARG_LONG_DOUBLE_ONE
	fptan
	fnstsw	%ax
	andw	$0x400,%ax
	jnz	1f
	fstp	%st(0)
	XMM_LONG_DOUBLE_EPILOGUE
	ret
1:	fldpi
	fadd	%st(0)
	fxch	%st(1)
2:	fprem1
	fstsw	%ax
	andw	$0x400,%ax
	jnz	2b
	fstp	%st(1)
	fptan
	fstp	%st(0)
	XMM_LONG_DOUBLE_EPILOGUE
	ret
