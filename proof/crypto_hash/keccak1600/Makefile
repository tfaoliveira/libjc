check:
	for i in `ls *.ec`; do echo $$i; easycrypt -timeout 30 -max-provers 2 -p Z3 -p Alt-Ergo -I ../../crypto_core/keccakf160064bits/ $$i; done
