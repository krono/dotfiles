; strange hack
(if (featurep 'aquamacs)
    (unless (fboundp 'frame-iconified-p)
            (fset 'frame-iconified-p 'frcmds-frame-iconified-p))
    )