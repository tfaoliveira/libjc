JASMINC?=jasminc -pasm

FILES:= shake256_jazz keccakFtest_jazz keccak2x-short

.SUFFIXES: .japp .jazz .s

all: test

test: $(foreach f,$(FILES),test/$(f).s)
	(cd test; make)

%.jazz: %.japp
	gpp -o $@ $<

test/%.s %.s: %.jazz
	$(JASMINC) -o $@ $<

test/%.s %.o: %.s
	$(AS) -c -o $@ $<

clean: 
	$(RM) -f *.o *.s $(foreach f,$(FILES),$(f).jazz) $(foreach f,$(FILES),test/$(f).s)

shake256_jazz.jazz: keccak2x.jazz

keccakFtest_jazz: keccak2x.jazz
