{
  programs.nixvim = {
    plugins = {
      comment = {
        enable = true;

        settings = {
          mappings = {
            basic = true;
            extra = true;
          };
        };
      };

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
