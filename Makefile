# ==============================================================================
#	Makefile setup and global variables
# ==============================================================================
MAKEFLAGS		+=		--no-print-directory -r -R
THIS_MAKEFILE	:=		$(lastword $(MAKEFILE_LIST))
ROOT_DIR		:=		$(PWD)
ifeq ($(shell uname), Linux)
	ECHO_BIN	:=	echo -e
else ifeq ($(shell uname), Darwin)
	ECHO_BIN	:=	echo
else
	$(error "Unsupported OS")
endif

# ==============================================================================
#	Progress bar
# ==============================================================================
ifndef ECHO
HIT_TOTAL	:=	$(shell $(MAKE) $(MAKECMDGOALS) -f $(THIS_MAKEFILE) --dry-run ECHO="HIT_MARK" | grep -c "HIT_MARK")
HIT_N		:=	0
HIT_COUNT	=	$(eval HIT_N = $(shell expr $(HIT_N) + 1))$(HIT_N)
ECHO		=	$(ECHO_BIN) "[`expr $(HIT_COUNT) '*' 100 / $(HIT_TOTAL)`%]\t"
endif

# ==============================================================================
#	Project name
# ==============================================================================
NAME		:=	libasm.a
TEST_NAME	:=	test

# ==============================================================================
#	Project environment
# ==============================================================================
OBJ_DIR		:=	obj
SRC_DIR		:=	src

# ==============================================================================
#	Project sources
# ==============================================================================
SRCS				:=		ft_strlen.s ft_strcmp.s ft_strcpy.s ft_strdup.s ft_read.s ft_write.s
OBJS				:=		$(addprefix $(OBJ_DIR)/, $(SRCS:.s=.o))

# ==============================================================================
#	Compilers
# ==============================================================================
CC			:=	gcc
AS			:=	nasm

# ==============================================================================
#	Compilation and linking flags
# ==============================================================================
NA_FLAGS	:=	-f elf64
CC_FLAGS	:=	-Wall -Wextra -Werror

# ==============================================================================
#	Main commands
# ==============================================================================
.PHONY: all
all: $(NAME) $(TEST_NAME)

.PHONY: clean
clean:
	@rm -rf $(OBJ_DIR)

.PHONY: fclean
fclean: clean
	@rm -rf $(BIN_DIR)

.PHONY: re
re: fclean
	@$(MAKE) -f $(THIS_MAKEFILE) all

# ==============================================================================
#	Project workspace setup
# ==============================================================================
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# ==============================================================================
#	Compilation
# ==============================================================================

$(NAME): $(OBJS) Makefile
	@$(ECHO) "AR $(_GREEN)$@$(_END)"
	@ar rcs $(NAME) $(OBJS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s Makefile | $(OBJ_DIR)
	@$(ECHO) "NA $(_GREEN)$<$(_END)"
	@$(AS) $(NA_FLAGS) $< -o $@

$(TEST_NAME): $(NAME) main.c Makefile
	@$(ECHO) "CC $(_GREEN)$@$(_END)"
	@$(CC) main.c -L. -lasm $(CC_FLAGS) -o $(TEST_NAME)
	./$(TEST_NAME)

# ==============================================================================
#	Extra
# ==============================================================================
_GREY	= \033[30m
_RED	= \033[31m
_ORANGE	= \033[38;5;209m
_GREEN	= \033[32m
_YELLOW	= \033[33m
_BLUE	= \033[34m
_PURPLE	= \033[35m
_CYAN	= \033[36m
_WHITE	= \033[37m
_END	= \033[0m
