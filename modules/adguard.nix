{
  services.dnscrypt-proxy2 = {
    enable = true;
    upstreamDefaults = true;
    settings = {
      server_names = ["adguard-dns"];
    };
  };

  networking.nameservers = ["127.0.0.1" "::1"];
  networking.networkmanager.dns = "none";
}
