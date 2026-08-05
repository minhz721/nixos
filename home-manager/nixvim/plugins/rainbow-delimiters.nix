{
    programs.nixvim = {
        plugins = {
            treesitter.enable = true;

            rainbow-delimiters.enable = true;
        };
    };
}