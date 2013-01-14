
(library (talikko commands)
  (export
    commands
    update-ports
    update-source-tree
    install
    deinstall
    reinstall
    info
    search)
  (import
    (silta base)
    (talikko commands commands)
    (talikko commands update)
    (talikko commands search)
    (talikko commands deinstall)
    (talikko commands install)
    (talikko commands info)
    (talikko commands reinstall)
    ))
