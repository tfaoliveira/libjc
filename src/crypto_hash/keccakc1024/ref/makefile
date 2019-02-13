.PHONY: clean

eval: test_theta.japp
	jasminc test_theta.japp | ./../../../../bench/misc/eval.pl

test_theta.japp: test_theta.jazz theta.jazz
	gpp -o $@ $<

clean:
	rm -f test_theta.japp



