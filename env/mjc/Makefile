### this file helps in maintaing multiple jasmin compiler versions
### $ make clone # clones each 'branch' in BRANCHES
### $ make pull # runs git pull in each 'branch'
### $ make build # builds each 'branch'; 'make clean' should be run manually when needed
### $ make install_glob_array3 # copies jasminc into /usr/local/bin and updates ~/.config/easycrypt/easycrypt.conf
### $ make install_annotation # same as previous, but for annotation branch

BRANCHES := jasmin_glob_array3 jasmin_intel_syntax jasmin_annotation

jasmin_%:
	git clone https://github.com/jasmin-lang/jasmin.git -b $* $@

clone: $(BRANCHES)

pull:
	$(foreach b, $(BRANCHES), (cd $b && git pull);)

build:
	$(foreach b, $(BRANCHES), (cd $b && nix-shell --command "(cd compiler && make CIL && make)");)
	
install_%:
	sudo install -b -D jasmin_$*/compiler/jasminc /usr/local/bin/
	echo "[general]\nidirs = Jasmin:$(shell pwd)/jasmin_$*/eclib" > ~/.config/easycrypt/easycrypt.conf

