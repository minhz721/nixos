{pkgsUnstable, ...}: {
  home.packages = with pkgsUnstable; [
    # Lsp python
    ty
  ];
}
