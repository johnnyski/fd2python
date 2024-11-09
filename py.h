#ifndef _PY_H_
#define _PY_H_
/*
    Copyright: 2001 John H. Merritt	

    This file is part of fd2python.

    fd2python is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    fd2python is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with fd2python; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/
#include <Python.h>
#include <forms.h>
#include <stdio.h>

char *SWIG_PackData(char *c, void *ptr, int sz);

PyObject *SWIG_NewPointerObj(void *ptr, char *type);

PyObject *FL_OBJECT_2_PyObject(FL_OBJECT *obj);

void call_python (char *method, FL_OBJECT *obj, int arg);
#endif
