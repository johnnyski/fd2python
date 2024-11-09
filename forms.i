/* Suitable for xforms 0.89. */

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

%{
#include <forms.h>
#include <Python.h>
#include <stdio.h>

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

%}

/* The following %ignore statements are those routines that
 * use varargs declarations.
 */
%ignore fl_defpup;
%ignore fl_set_error_handler;
%ignore flimage_error;
%ignore fl_addtopup;

/* The following %ignore statements are those routines mentioned in
 * the forms.h include file, but, are not part of the library.
 */
%ignore fl_create_menubar;
%ignore fl_add_menubar;
%ignore fl_set_menubar;
%ignore fl_set_menubar_entries;
%ignore fl_clear_menubar;

%ignore fl_set_error_logfp;

%ignore fl_create_glcanvas;
%ignore fl_add_glcanvas;
%ignore fl_get_glcanvas_defaults;
%ignore fl_set_glcanvas_defaults;
%ignore fl_get_glcanvas_attributes;
%ignore fl_set_glcanvas_attributes;
%ignore fl_set_glcanvas_direct;
%ignore fl_activate_glcanvas;
%ignore fl_get_glcanvas_xvisualinfo;
%ignore fl_get_glcanvas_context;


%ignore fl_select_octree_quantizer;
%ignore fl_add_mesacanvas;
%ignore fl_create_mesacanvas;
%ignore fl_goodie_atclose;

%include "forms.h"
