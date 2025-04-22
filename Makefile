# Variables
AS  = as
LD  = ld
GCC = gcc

# File che richiedono GCC (perché usano main, fprintf, ecc.)
GCC_SRC = 20_calling_fn_from_liberies.s 21_working_with_files.s 22_std_in_out_err.s 26_Dynamic_linking.s

SRC = $(shell ls -1v *.s)
OBJ = $(SRC:.s=.o)

# Lista dei gruppi speciali da linkare insieme:
LINK_GROUPS = \
    09-1_tallest:09_constants_and_splitting

# Estrai i target principali dai gruppi
SPECIAL_EXE = $(foreach group,$(LINK_GROUPS),$(firstword $(subst :, ,$(group))))
SPECIAL_DEPS = $(foreach group,$(LINK_GROUPS),$(wordlist 2,999,$(subst :, ,$(group))))
SPECIAL_DEPS_FLAT = $(filter-out :,$(foreach depgroup,$(SPECIAL_DEPS),$(subst ., ,$(depgroup))))
EXE = $(filter-out $(SPECIAL_EXE) $(SPECIAL_DEPS_FLAT),$(SRC:.s=))

# Default rule
all: prepare_dirs header_assemble objs header_link exe special exe_footer

# Prepare obj/ and exe/ folders if missing
prepare_dirs:
	@mkdir -p obj exe

# Section headers
header_assemble:
	@echo "\n[-------- ASSEMBLING --------]"

header_link:
	@echo "\n[-------- LINKING --------]"

exe_footer:
	@echo "\n[DONE] All files built successfully.\n"

# Assembling
objs: $(OBJ)

%.o: %.s
	@echo "  - $<"
	@if echo "$(GCC_SRC)" | grep -q "$<"; then \
		$(GCC) -c $< -o obj/$@; \
	else \
		$(AS) $< -o obj/$@; \
	fi

# Linking generico 
exe: $(EXE)

%: %.o
	@echo "  - $@"
	@if echo "$(GCC_SRC)" | grep -q "$@.s"; then \
		$(GCC) obj/$@.o -o exe/$@; \
	else \
		$(LD) obj/$@.o -o exe/$@; \
	fi

# Linking speciali da LINK_GROUPS
special: $(foreach group,$(LINK_GROUPS),exe/$(firstword $(subst :, ,$(group))))

define make_special_rule
exe/$(1): $(addprefix obj/,$(addsuffix .o,$(subst ., ,$(2))))
	@echo "  - $(addsuffix .s,$(subst ., ,$(2))) (with $(1).s)"
	@$(LD) -e _start $$^ -o $$@
endef

$(foreach group,$(LINK_GROUPS),\
  $(eval $(call make_special_rule,$(firstword $(subst :, ,$(group)) ),$(lastword $(subst :, ,$(group)))))\
)

# Clean rule
clean:
	@echo "\n[-------- CLEANING --------]"
	@echo "Removing object files and executables...\n"
	@rm -f obj/*.o exe/*