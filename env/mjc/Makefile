### this file helps in maintaing multiple jasmin compiler versions
### 
### $ make jasmin_glob_array3 # clones branch 'glob_array3'
###
### $ make pull_glob_array3 # runs git pull in 'jasmin_glob_array3'
###
### $ make build_glob_array3 # builds the compiler using nix-shell (check https://nixos.org/manual/nix/stable/package-management/channels.html for information on how to update package lists; sometimes 'nix-channel --update' can fix compilation issues)
###
### $ make install_glob_array3 # copies jasminc into /usr/local/bin and updates ~/.config/easycrypt/easycrypt.conf
###
### Last, '$ make install_glob_array3' from an clean state, should handle the whole process for you

BRANCHES := glob_array3 get-random constant-time
JASMINS := $(addprefix jasmin_, $(BRANCHES))
BUILDS := $(addprefix build_, $(BRANCHES))

.PRECIOUS: $(JASMINS)

default:
	echo "'make build' compiles everything, it can take some time."

build: $(BUILDS)

###

jasmin_%:
	git clone https://github.com/jasmin-lang/jasmin.git -b $* jasmin_$*

pull_%: jasmin_%
	(cd jasmin_$* && (git pull || true))

build_%: pull_%
	(cd jasmin_$* && nix-shell --command "(cd compiler && make clean && make CIL && make)")

install_%: build_%
	sudo install -b -D jasmin_$*/compiler/jasminc /usr/local/bin/
	echo "[general]\nidirs = Jasmin:$(shell pwd)/jasmin_$*/eclib" > ~/.config/easycrypt/easycrypt.conf

just_install_%:
	sudo install -b -D jasmin_$*/compiler/jasminc /usr/local/bin/
	echo "[general]\nidirs = Jasmin:$(shell pwd)/jasmin_$*/eclib" > ~/.config/easycrypt/easycrypt.conf
