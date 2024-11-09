#    Copyright: 2001 John H. Merritt	
#
#    This file is part of fd2python.
#
#    fd2python is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    fd2python is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with fd2python; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

###################################################
# Configure the following lines appropriately:
###################################################
INSTALL_ROOT    = /home/jmerritt/gnu
X11_ROOT        = /usr/X11R6
#FORMS_ROOT      = /usr/X11R6
FORMS_ROOT      = /home/jmerritt/gnu
PATH_TO_FDESIGN = $(X11_ROOT)/bin/fdesign
###################################################
# End of Configuration.
###################################################
VERSION         = v1.1

INSTALL_BINDIR = $(INSTALL_ROOT)/bin
INSTALL_INCDIR = $(INSTALL_ROOT)/include
INSTALL_LIBDIR = $(INSTALL_ROOT)/lib

bin_SCRIPTS = fd2python

install: $(bin_SCRIPTS)
	-chmod +x fd2python
	-cp fd2python $(INSTALL_BINDIR)
	-cp forms.i $(INSTALL_INCDIR)

uninstall::
	-rm $(INSTALL_BINDIR)/fd2python
	-rm $(INSTALL_INCDIR)/forms.i

fd2python: Makefile
	@for h in $(bin_SCRIPTS); do \
	echo -n "Checking substitutions in file $$h ... "; \
	cp $$h $$h.in; \
	sed -e 's|\$fdesign.*=.*|\$fdesign    = \"$(PATH_TO_FDESIGN)\";|' \
         -e 's|\$version.*=.*|\$version    = \"$(VERSION)\";|' \
         -e 's|\$x_root.*=.*|\$x_root   = \"$(X11_ROOT)\";|' \
         -e 's|\$forms_root.*=.*|\$forms_root = \"$(FORMS_ROOT)\";|' \
    < $$h.in > $$h.new; \
	if cmp -s $$h $$h.new; then \
       rm $$h.new; \
       echo "$$h remains untouched."; \
    else \
       mv $$h.new $$h; \
       echo "substitutions made in $$h."; \
    fi; \
	rm -f $$h.in; \
    done
