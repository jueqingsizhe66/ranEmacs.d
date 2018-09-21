;;; for auto insert
(eval-after-load 'autoinsert
  '(define-auto-insert '(perl-mode . "Perl skeleton")
     '("Description: "
       "#!/usr/bin/env perl" \n
       \n
       "use strict;" \n
       "use warnings;" \n \n
       _ \n \n
       "__END__" "\n\n"
       "=head1 NAME" "\n\n"
       str "\n\n"
       "=head1 SYNOPSIS" "\n\n\n"
       "=head1 DESCRIPTION" "\n\n\n"
       "=head1 COPYRIGHT" "\n\n"
       "Copyright (c) " (substring (current-time-string) -4) " "
       (getenv "ORGANIZATION") | (progn user-full-name) "\n\n"
       "This library is free software; you can redistribute it and/or" "\n"
       "modify it under the same terms as Perl itself." "\n\n"
       "=cut" "\n")))



