poly1305.s: poly1305.japp
	jasminc -pasm $< > $@

poly1305.japp: poly1305_export.jazz poly1305.jazz
	gpp -o $@ $<

clean:
	rm -f poly1305.japp

