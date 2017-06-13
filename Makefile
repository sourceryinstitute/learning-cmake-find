# This file produces the following library
target = libio_routines.a

# Fortran compiler
compile = caf

# archiver
archive = ar

lib_src_dir=src

# Locate required source files
lib_src_files := $(shell ls $(lib_src_dir)/*.f90)
bare_lib_src := $(subst $(lib_src_dir)/,,$(lib_src_files)) # Eliminate paths 
source_files := $(bare_lib_src)

# Swap .f90 file extensions for .o extensions 
object_files := $(subst .f90,.o,$(source_files))

# $@ - means the target
# $^ - means all prerequisites
$(target): $(object_files)
	$(archive) rcs $@ $^

io_routines.o: $(lib_src_dir)/io_routines.f90 model_constants.o

# Pattern for compiling Fortran sorce into object files.
%.o: $(lib_src_dir)/%.f90
	$(compile) $(opt) -c $< -L /opt/local/lib -I /opt/local/include -l netcdff

.PHONY : clean 

clean :
	-rm -f  *.o *.mod *.smod $(target)
