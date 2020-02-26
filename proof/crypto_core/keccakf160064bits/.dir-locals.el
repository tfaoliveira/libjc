((easycrypt-mode .
  ((eval .
    (cl-flet ((pre (s) (concat (locate-dominating-file buffer-file-name ".dir-locals.el") s)))
           (setq easycrypt-load-path `(,(pre "../../crypto_core/keccakf160064bits/") ,(pre "../../common") ,(pre "../../sha3")))))))))
