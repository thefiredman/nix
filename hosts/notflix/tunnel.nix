{ pkgs, ... }: {
  # networking = {
  #   firewall.allowedUDPPorts = [ 51820 ];
  #   wg-quick.interfaces = let server_ip = "146.70.165.130";
  #   in {
  #     wg0 = {
  #       address = [ "10.72.55.152/32" "fc00:bbbb:bbbb:bb01::9:3797/128" ];
  #
  #       # To match firewall allowedUDPPorts (without this wg
  #       # uses random port numbers).
  #       listenPort = 51820;
  #
  #       # Path to the private key file.
  #       privateKeyFile = "/etc/pwd/mullvad-vpn.key";
  #
  #       peers = [{
  #         publicKey = "cmUR4g9aIFDa5Xnp4B6Zjyp20jwgTTMgBdhcdvDV0FM=";
  #         allowedIPs = [ "0.0.0.0/0" ];
  #         endpoint = "${server_ip}:51820";
  #         persistentKeepalive = 25;
  #       }];
  #
  #       postUp = ''
  #         wg set wg0 fwmark 51820
  #       '';
  #
  #       postDown = ''
  #         ${pkgs.iptables}/bin/iptables -A INPUT -i wg0 -p udp --dport 8096:8099 -m state --state NEW,ESTABLISHED -j ACCEPT
  #         ${pkgs.iptables}/bin/iptables -A INPUT -i wg0 -p tcp --dport 8096:8099 -m state --state NEW,ESTABLISHED -j ACCEPT
  #         ${pkgs.iptables}/bin/iptables -A OUTPUT -o wg0 -p udp --sport 8096:8099 -m state --state NEW,ESTABLISHED -j ACCEPT
  #         ${pkgs.iptables}/bin/iptables -A OUTPUT -o wg0 -p tcp --sport 8096:8099 -m state --state NEW,ESTABLISHED -j ACCEPT
  #       '';
  #
  #     };
  #   };
  # };

  environment.persistence."/persist".directories = [ "/etc/pwd" ];
}
