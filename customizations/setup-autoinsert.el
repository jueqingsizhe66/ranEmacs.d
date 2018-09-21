;;; autoinsert expression evaluation method
(eval-after-load 'autoinsert
  '(define-auto-insert
     '("\\.\\(CC?\\|cc\\|cxx\\|cpp\\|c++\\)\\'" . "C++ skeleton")
     '("Short description: "
       "/*" \n
       (file-name-nondirectory (buffer-file-name))
       " -- " str \n
       " */" > \n \n
       "#include <iostream>" \n \n
       "using namespace std;" \n \n
       "main()" \n
       "{" \n
       > _ \n
       "}" > \n)))


(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.c\\'" . "C skeleton")
     '(
       "Short description: "
       "/**\n * "
       (file-name-nondirectory (buffer-file-name))
       " -- " str \n
       " *" \n
       " * Written on " (format-time-string "%A, %e %B %Y.") \n
       " */" > \n \n
       "#include <stdio.h>" \n
       "#include \""
       (file-name-sans-extension
        (file-name-nondirectory (buffer-file-name)))
       ".h\"" \n \n
       "int main()" \n
       "{" > \n
       > _ \n
       "}" > \n)))

;;; for perl auto insert
(eval-after-load 'autoinsert
  '(define-auto-insert '(perl-mode . "Perl skeleton")
     '("Description: "
       "#!/usr/bin/env perl" \n
       \n
       "use strict;" \n
       "use warnings;" \n 
       "use utf8;" \n \n
       _ \n \n
       "__END__" "\n\n"
       "=head1 NAME" "\n\n"
       str "\n\n"
       "=head1 SYNOPSIS" "\n\n\n"
       "=head1 DESCRIPTION" "\n\n\n"
       "=head1 COPYRIGHT" "\n\n"
       "Copyright (c) " (substring (current-time-string) -0) " "
       (getenv "ORGANIZATION") | (progn user-full-name) "\n\n"
       "This library is free software; you can redistribute it and/or" "\n"
       "modify it under the same terms as Perl itself." "\n\n"
       "=cut" "\n")))

;;; yasnippet method

 (defun my/autoinsert-yas-expand()
      "Replace text in yasnippet template."
      (yas/expand-snippet (buffer-string) (point-min) (point-max)))

   (custom-set-variables
     '(auto-insert 'other)
     '(auto-insert-directory "~/.emacs.d/template/")
     '(auto-insert-alist '((("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C / C++ header") . ["template.h" c++-mode my/autoinsert-yas-expand])
                           (("\\.sh\\'" . "Shell script") . ["sh-template.sh" my/autoinsert-yas-expand])
                           (("\\.el\\'" . "Emacs Lisp") . ["template.el" my/autoinsert-yas-expand])
                           (("\\.pm\\'" . "Perl module") . ["template.pm" my/autoinsert-yas-expand])
                           (("\\.py\\'" . "Python script") . ["py-template.py" my/autoinsert-yas-expand])
                           (("[mM]akefile\\'" . "Makefile") . ["cmake-template" my/autoinsert-yas-expand])
                           (("\\.tex\\'" . "TeX/LaTeX") . ["template.tex" my/autoinsert-yas-expand]))))
