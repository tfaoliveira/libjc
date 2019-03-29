This file describe the contant of files for the security of ChaCha20.

1/ Functional specification of ChaCha20:

  ChaCha20_Spec.ec: 
    the specification HACL* style
  ChaCha20_pref.ec: 
    basic imperative version 
  ChaCha20_pref_proof.ec: 
    proof that ChaCha20_pref satisfies its spec.

2/ ChaCha20_ref (use only scalar operations, no avx/avx2 instructions):

  ChaCha20_sref.ec: 
    extracted model of the jasmin program
  ChaCha20_sref_proof.ec: 
    equivalence between ChaCha20_pref and ChaCha20_sref
    proof that ChaCha20_sref satisfies its spec. 

  ChaCha20_sref_CT.ec:
    extracted constant time model of jasmin program
  ChaCha20_sref_CT_proof.ec:
    proof that ChaCha20_ref is constant time

3/ ChaCha20_savx:

  ChaCha20_savx_CT.ec:
    extracted constant time model of jasmin program
  ChaCha20_savx_CT_proof.ec:
    proof that ChaCha20_avx is constant time


4/ ChaCha20_savx2:
           		  	    		 
  ChaCha20_pavx2_cf.ec: 
    change in the control flow
    equivalence between ChaCha20_pref and ChaCha20_pavx2_cf
  ChaCha20_pavx2.ec:
    equivalence between ChaCha20_pavx2_cf and ChaCha20_pavx2
  ChaCha20_savx2.ec:
    extracted model of the jasmin program	  	      
  ChaCha20_savx2_proof.ec:
    equivalence between ChaCha20_pavx2 and ChaCha20_savx2
    proof that ChaCha20_avx2 satisfies its spec. 

  ChaCha20_savx2_CT.ec:
    extracted constant time model of jasmin program
  ChaCha20_savx2_CT_proof.ec:
    proof that ChaCha20_avx2 is constant time

