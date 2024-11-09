#!/usr/bin/python

from ajax_ui_cb import *
from ajax_ui import *

def create_pulldown(obj):
  if main_file_pulldown == obj:
    fl_set_menu(obj, "Compile|Run|Kill|Exit");
  elif main_configure_pulldown == obj:
    fl_set_menu(obj, "One|Two|Three|Four|Five");
  elif main_help_pulldown == obj:
    fl_set_menu(obj, "Contents|About");
    

#--------- MAIN ---------
if __name__ == '__main__':
  title = "Ajax -- the foaming cleanser."
  display = fl_init();

  create_the_forms();
  create_pulldown(main_file_pulldown);
  create_pulldown(main_configure_pulldown);
  create_pulldown(main_help_pulldown);
  
  fl_set_pixmap_file(ajax_pixmap, "ajax.xpm");
  fl_show_form(ajax, FL_PLACE_CENTER, FL_FULLBORDER, title);
  while 1:
    obj = fl_do_forms()
    
