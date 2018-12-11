# ChaCha20

There are 3 Jasmin implementations of ChaCha20 for x64:

* `src/crypto_stream/chacha20/ref`
* `src/crypto_stream/chacha20/avx`
* `src/crypto_stream/chacha20/avx2`

There are also 3 other implementations of ChaCha20 that are used for the correctness/
equivalence proofs (they are intermediate implementations):

* `proof/crypto_stream/chacha20/ref` : simplified version of `src/crypto_stream/chacha20/ref`.
* `proof/crypto_stream/chacha20/avx` : pre-vectorized version of `src/crypto_stream/chacha20/avx`.
* `proof/crypto_stream/chacha20/avx2` : pre-vectorized version of `src/crypto_stream/chacha20/avx2`.

For brevity only `src` and `proof` will be used to refer to the previously mentioned
implementations of ChaCha20. The following equivalence proofs are needed to cover
all `src` implementations:

* specification `<=>` `proof/ref`
* `proof/ref` `<=>` `src/ref`
* `proof/ref` `<=>` `proof/avx`
* `proof/ref` `<=>` `proof/avx2`
* `proof/avx` `<=>` `src/avx`
* `proof/avx2` `<=>` `src/avx2`
