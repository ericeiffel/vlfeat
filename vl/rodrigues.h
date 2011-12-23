/** @file rodrigues.h
 ** @author Andrea Vedaldi
 ** @brief Rodrigues formulas
 **
 ** @section rodrigues Rodrigues formulas
 **
 ** - Use vl_rodrigues() to compute the Rodrigues formula and its derivative.
 ** - Use vl_irodrigues() to compute the inverse Rodrigues formula and
 **   its derivative.
 **/

/*
Copyright (C) 2007-12 Andrea Vedaldi and Brian Fulkerson.
All rights reserved.

This file is part of the VLFeat library and is made available under
the terms of the BSD license (see the COPYING file).
*/

#ifndef VL_RODRIGUES
#define VL_RODRIGUES

#include "generic.h"

VL_EXPORT void vl_rodrigues  (double* R_pt,  double* dR_pt, const double* om_pt) ;
VL_EXPORT void vl_irodrigues (double* om_pt, double* dom_pt, const double* R_pt) ;

/* VL_RODRIGUES */
#endif


