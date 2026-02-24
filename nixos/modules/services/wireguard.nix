{ config, lib, pkgs, ... }:

{
  options = {
    wireguard.enable = lib.mkEnableOption "Enable WireGuard VPN client configuration";
  };

  config = lib.mkIf config.wireguard.enable {
    
    # Firewall settings
    networking.firewall = {
      allowedUDPPorts = [ 443 ]; # Clients and peers can use the same port
    };

    # WireGuard interface configuration
    networking.wireguard.interfaces = {
      # "wg0" is the network interface name; can be arbitrary
      wg0 = {
        ips = [ "10.100.0.2/24" ];  # Client's IP and subnet
        listenPort = 443;          # Must match firewall allowedUDPPorts

        # Private key file path (recommended over inline private key)
        privateKeyFile = "/home/elodie/wireguard-keys/private";

        # Peer (server) configuration
        peers = [
          {
            publicKey = "1yXHDJrjZhQKDEobgp1l5Osq4euJsP7Xl4ei8HXU6Dk=";  # Server public key
            allowedIPs = [ "10.100.0.1/32" ];  # IP(s) routed via this peer
            endpoint = "178.118.72.79:443";   # Server address
            persistentKeepalive = 25;           # Keep NAT alive
          }
        ];
      };
    };
  };
}

