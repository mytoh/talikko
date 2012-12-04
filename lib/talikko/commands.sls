
(library (talikko commands)
  (export
    commands
    update
    update-source-tree
    install
    deinstall
    reinstall
    info
    search)
  (import
    (rnrs)
    (talikko commands commands)
    (talikko commands update)
    (talikko commands search)
    (talikko commands deinstall)
    (talikko commands install)
    (talikko commands info)
    (talikko commands reinstall)
    ))
