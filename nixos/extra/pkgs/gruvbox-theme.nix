{ stdenv, fetchgit, makeWrapper, pkgs, ... }:

stdenv.mkDerivation rec {
  name = "myGruvboxTheme";
  src = fetchgit {
    url = "https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git";
    sha256 = "Y+6HuWaVkNqlYc+w5wLkS2LpKcDtpeOpdHnqBmShm5Q=";
  };


  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    # 进入主题目录
    cd $src

    # 确保路径正确性并增加一些错误处理
    if ! [ -d $src/icons -a -d $src/themes ]; then
      echo "Icons or themes directory not found!"
      exit 1
    fi

    # 创建安装目录
    mkdir -p $out/share/icons
    mkdir -p $out/share/themes

    # 复制文件到目标目录
    cp -r $src/icons/* $out/share/icons/
    cp -r $src/themes/* $out/share/themes/
  '';

  # 添加一个包含所有安装目录的环境变量，以便后续应用程序可以找到主题和图标
  meta = with pkgs.stdenv.lib; {
    # 添加 .local/share/icons 到图标搜索路径
    preferLocalBuild = true;
    preferLocalBuildUseSubstitutes = true;
    # 添加 .local/share/themes 到主题搜索路径
  };
}

###########################################################
# 1. 得到meta信息
# nix-prefetch-git https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme.git

# 2. 主题可以在这里找到
# ls .nix-profile/share/themes
