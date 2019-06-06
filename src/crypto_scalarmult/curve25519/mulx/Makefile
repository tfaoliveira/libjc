.PHONY: clean

x25519_scalarmult_export.s: *.jazz
	gpp -o x25519_scalarmult_export.japp x25519_scalarmult_export.jazz
	jasminc -lea -pasm x25519_scalarmult_export.japp > $@

clean:
	rm -f *.s *.japp

