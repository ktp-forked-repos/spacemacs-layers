(setq bb-erc-packages
      '(emoji-cheat-sheet-plus
        erc
        (erc-image :excluded t)
        (erc-yt :excluded t)
        persp-mode
        typo))

(defun bb-erc/post-init-erc ()
  (spacemacs/set-leader-keys
    "aiq" 'erc-quit-server)

  (setq-default
   erc-timestamp-format-left "\n%A %B %e, %Y\n\n"
   erc-timestamp-format-right "%H:%M"
   erc-timestamp-right-column 80
   erc-prompt-for-nickserv-password nil
   erc-image-inline-rescale 300
   erc-hide-list '("JOIN" "PART" "QUIT" "NICK")
   erc-foolish-content
   '("\\[Github\\].* starred"
     "\\[Github\\].* forked"
     "\\[Github\\].* synchronize a Pull Request"
     "\\[Github\\].* labeled an issue in"
     "\\[Github\\].* unlabeled an issue in"
     "\\[Github\\].* opened an issue in"
     "\\[Github\\].* edited an issue in"
     "\\[Github\\].* labeled a Pull Request"
     "\\[Github\\].* unlabeled a Pull Request"
     "\\[Github\\].* opened a Pull Request to"
     "\\[Github\\].* closed a Pull Request to"
     "\\[Github\\].* edited a Pull Request to"
     "\\[Github\\].* commented in"))

  (add-hook 'erc-mode-hook
            (lambda () (setq-local global-hl-line-mode nil)))

  (add-hook 'erc-insert-pre-hook 'bb/erc-foolish-filter)

  (evil-set-initial-state 'erc-mode 'normal)

  (with-eval-after-load 'erc
    (setq erc-insert-modify-hook
          '(erc-controls-highlight
            erc-button-add-buttons
            erc-fill
            erc-match-message
            erc-add-timestamp
            erc-hl-nicks))
    (dolist (module '(track youtube image))
      (setq erc-modules (remove module erc-modules)))))

(defun bb-erc/post-init-emoji-cheat-sheet-plus ()
  (add-hook 'erc-mode-hook 'emoji-cheat-sheet-plus-display-mode))

(defun bb-erc/post-init-persp-mode ()
  (add-hook 'erc-mode-hook 'bb/add-buffer-to-erc-persp))

(defun bb-erc/post-init-typo ()
  (add-hook 'erc-mode-hook 'typo-mode))
