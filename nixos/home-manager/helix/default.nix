{ config, pkgs, lib, ... }:

{
  xdg.configFile =
    let
      settingsFormat = pkgs.formats.toml { };
      genText = x: y: builtins.readFile (settingsFormat.generate x y);
    in
    {
      "helix/languages.toml".text = genText "config.toml" (import ./languages.nix { inherit pkgs lib; });
    };

  # lsps
  home.packages = with pkgs;[
    nil
    shfmt
    nixpkgs-fmt
    cmake-language-server
    clang-tools
    typst-lsp
    tailwindcss-language-server
    lldb

    # taplo
    # rustfmt
    # rust-analyzer
    # haskell-language-server
    # delve
  ]
  ++ (with pkgs.nodePackages_latest; [
    vscode-json-languageserver-bin
    vscode-html-languageserver-bin
    vscode-css-languageserver-bin
    bash-language-server
    vls
    prettier
  ]);


  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = pkgs.helix;

    settings = {
      # theme = "adwaita-dark";
      # theme = "base16_transparent";
      theme = "kanagawa";
      editor = {

        cursorline = true; # 光标所在行高亮显示
        cursorcolumn = true;
        bufferline = "multiple"; # 顶部显示缓冲区 { never | always | multiple }
        completion-trigger-len = 1;

        idle-timeout = 100; # 单位为毫秒ms
        mouse = false;
        scroll-lines = 1;

        line-number = "relative";
        auto-pairs = true;
        true-color = true;
        color-modes = true;
        soft-wrap = { enable = true; }; # line到达边缘自动换行

        file-picker.hidden = false; # 不忽略隐藏文件（显示隐藏文件）

        lsp = {
          enable = true;
          display-messages = true;
          display-inlay-hints = false; # 显示嵌套提示
          snippets = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true; # 渲染缩进
          character = "┊";
        };

        statusline = {
          left = [ "mode" "spinner" ];
          center = [ "file-name" ];
          right = [ "diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type" ];
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

      };

      keys.normal = {
        space = {
          s = ":w";
          m = ":format";
          q = ":q!";
          y = ":clipboard-yank";
          p = ":clipboard-paste-before";
          R = ":clipboard-paste-replace";
        };

        g = { a = "code_action"; }; # Maps `ga` to show possible code actions

        C-j = map (_: "move_line_down") (lib.range 0 4);
        C-k = map (_: "move_line_up") (lib.range 0 4);
        C-e = "scroll_down";
        C-y = "scroll_up";

      };
      keys.select = {
        C-j = map (_: "extend_line_down") (lib.range 0 4);
        C-k = map (_: "extend_line_up") (lib.range 0 4);
      };
    };
  };
}
