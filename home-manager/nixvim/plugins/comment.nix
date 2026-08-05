{
  programs.nixvim = {
    plugins = {
      comment.enable = true;

      todo-comments = {
        enable = true;
        settings = {
          highlight = {
            multiline = true;
          };
          search = {
            command = "rg";
          };
        };
      };
    };
  };
}
