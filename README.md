# Important Notice

The development of new Jasmin implementations switched to https://github.com/formosa-crypto/libjade

For more information about the Formosa Crypto Project, consult the following website: https://formosa-crypto.org/

# Setup
```
git clone --recurse-submodules https://github.com/tfaoliveira/libjc.git
cd libjc/env
vagrant up
```
You should now have an Ubuntu machine with [Jasmin](https://github.com/jasmin-lang/jasmin) compiler and [EasyCrypt](https://github.com/EasyCrypt/easycrypt) installed. If you also want to install [Proof General](https://proofgeneral.github.io/) -- check PG page for details:
```
M-x package-refresh-contents RET
M-x package-install RET
proof-general RET
```
You can read the following page if you encounter any gpg related error: https://elpa.gnu.org/packages/gnu-elpa-keyring-update.html. If the public key isn't found, probably the following command will fix the issue:
```
gpg --homedir ~/.emacs.d/elpa/gnupg --receive-keys 066DAFCB81E42C40
```

# Benchmarks

## ChaCha20
![chacha20](https://github.com/tfaoliveira/libjc/blob/master/bench/results/chacha20/svg/chacha20_libjc_xor_cycles_32_16384.svg)

## Poly1305
![poly1305](https://github.com/tfaoliveira/libjc/blob/master/bench/results/poly1305/svg/poly1305_libjc_cycles_32_16384.svg)

## SHAKE256
(output set 136 bytes)

![shake256](https://github.com/tfaoliveira/libjc/blob/master/bench/results/keccak/svg/shake256_libjc_cycles_128_16384.svg)




