(load "~/.emacs.d/my-loadpackages.el")
(load "~/.emacs.d/my-methods.el")
(add-hook 'after-init-hook '(lambda ()
  (load "~/.emacs.d/my-noexternals.el")))
