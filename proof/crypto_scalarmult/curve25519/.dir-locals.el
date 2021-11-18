((easycrypt-mode .
  ((eval .
    (cl-flet ((pre (s) (concat (locate-dominating-file buffer-file-name ".dir-locals.el") s)))
      (setq easycrypt-load-path `(, (pre ".")))
      (setq easycrypt-prog-args `("-emacs", "-pp-width", "120", "-I", (concat "Jasmin:" (pre "../../eclib/")), "-I", (concat "JasminExtra:" (pre "../../eclib_extra"))))
    )))))
