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

char *SWIG_PackData(char *c, void *ptr, int sz)
{
  static char hex[17] = "0123456789abcdef";
  int i;
  unsigned char *u = (unsigned char *) ptr;
  register unsigned char uu;
  for (i = 0; i < sz; i++,u++) {
    uu = *u;
    *(c++) = hex[(uu & 0xf0) >> 4];
    *(c++) = hex[uu & 0xf];
  }
  return c;
}

/* Create a new pointer object */
PyObject *SWIG_NewPointerObj(void *ptr, char *type)
{
  PyObject *robj;
  if (!ptr) {
    Py_INCREF(Py_None);
    return Py_None;
  }

  {
    char result[512];
    char *r = result;
    *(r++) = '_';
    r = SWIG_PackData(r,&ptr,sizeof(void *));
    strcpy(r,type);
    robj = PyString_FromString(result);
  }

  return robj;
}

PyObject *FL_OBJECT_2_PyObject(FL_OBJECT *obj)
{
  swig_type_info sti;
  sti.name = "_p_FL_OBJECT";
  return SWIG_NewPointerObj((void *) obj, &sti);
}


void call_python (char *method, FL_OBJECT *obj, int arg)
{
  PyObject *pstr;
  PyObject *pmod;
  PyObject *pdict;
  PyObject *robj;

  robj = FL_OBJECT_2_PyObject(obj);

  pdict = PyImport_GetModuleDict();
  if (pdict == NULL) {
    fprintf(stderr, "call_python: PyImport_GetModuleDict failed.\n");
    return;
  }

  pmod  = PyDict_GetItemString(pdict, "__main__");
  if (pmod == NULL) {
    fprintf(stderr, "call_python: PyDict_GetItemString failed.\n");
    return;
  }

  pstr = PyObject_CallMethod(pmod, method, "Oi", robj, arg);
  if (pstr == NULL) {
    fprintf(stderr, "call_python: PyObject_CallMethod(...%s...) failed.\n", method);
    return;
  }

  /* Don't call Py_DECREF because the __main__ module needs the dictionary
   * and modules.   I learned this the hard way.
   */

}
