{pkgsUnstable, ...}: {
  home.packages = with pkgsUnstable; [
    fresh-editor
    ty
  ];
}
