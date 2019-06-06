.PHONY: clean
.PRECIOUS: %.s

CC= gcc
FLAGS= -Wall -Ofast -Wno-unused-function
INC= -I../../../../../bench/misc/

all: b-sqr b-mul b-invert b-sqr_regs b-mul_regs b-invert_regs
run: r-sqr r-mul r-invert r-sqr_regs r-mul_regs r-invert_regs

r-%: b-%
	@echo "$<"
	@./$<

b-%: b-%.c x25519_%_export.s
	$(CC) $(FLAGS) $(INC) -o $@ $^

%.s: %.jazz
	gpp -I../ -o __temp.japp $<
	jasminc -lea -pasm __temp.japp > $@ || true

clean:
	rm -f __temp.japp
	ls b-* | grep -v "\.c$$" | xargs rm
