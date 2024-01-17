{ pkgs, config, lib, ... }:

let

  extraHostsText = ''
    127.0.0.2 other-localhost
    127.0.0.1 main.com
    127.0.0.1 localhost.com
    127.0.0.1 pchan.com

    185.199.108.154              github.githubassets.com
    140.82.114.21                central.github.com
    185.199.108.133              desktop.githubusercontent.com
    185.199.109.153              assets-cdn.github.com
    185.199.108.133              camo.githubusercontent.com
    185.199.108.133              github.map.fastly.net
    151.101.193.194              github.global.ssl.fastly.net
    140.82.112.3                 gist.github.com
    185.199.108.153              github.io
    140.82.114.3                 github.com
    140.82.113.5                 api.github.com
    185.199.111.133              raw.githubusercontent.com
    185.199.108.133              user-images.githubusercontent.com
    185.199.109.133              favicons.githubusercontent.com
    185.199.110.133              avatars5.githubusercontent.com
    185.199.111.133              avatars4.githubusercontent.com
    185.199.111.133              avatars3.githubusercontent.com
    185.199.111.133              avatars2.githubusercontent.com
    185.199.109.133              avatars1.githubusercontent.com
    185.199.108.133              avatars0.githubusercontent.com
    185.199.109.133              avatars.githubusercontent.com
    140.82.114.10                codeload.github.com
    54.231.163.177               github-cloud.s3.amazonaws.com
    52.216.170.3                 github-com.s3.amazonaws.com
    52.217.224.41                github-production-release-asset-2e65be.s3.amazonaws.com
    52.217.140.65                github-production-user-asset-6210df.s3.amazonaws.com
    54.231.162.241               github-production-repository-file-5c1aeb.s3.amazonaws.com
    185.199.109.153              githubstatus.com
    140.82.114.17                github.community
    185.199.109.133              media.githubusercontent.com
    185.199.110.133              objects.githubusercontent.com
    185.199.108.133              raw.github.com
    20.221.80.166                copilot-proxy.githubusercontent.com

    # Mirror Repo : https://gitlab.com/ineo6/hosts
    # Update at: 2023-11-10 14:13:31
  '';

  allowedPorts = [
    80
    443
    21
    22
    23
    20171
    20170
    2017
  ];

  allowedPortRanges = [
    { from = 8000; to = 8999; }
    { from = 6000; to = 6999; }
  ];

in
{
  networking = {
    extraHosts = extraHostsText;
    # usePredictableInterfaceNames = true; # 给网卡分配可预测的名称，例如eh0,eth1等。

    # nginx做实验。当127.0.0.1的56端口没有开放貌似会造成网络不通？
    # nameservers = [ "114.114.114.114" "127.0.0.1" ];
  };

  # 开启防火墙并开放部分端口
  networking.firewall =
    {
      enable = true;

      allowedTCPPorts = allowedPorts;
      allowedTCPPortRanges = allowedPortRanges;

      allowedUDPPorts = allowedPorts;
      allowedUDPPortRanges = allowedPortRanges;
    };

}

