{
  puck = {
    hostName = "puck";
    ip = "192.168.0.156";
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAikxJyr2aBfVWqnrxu/Ual1hrMRg/dq0OYSmora8xaB";
  };
  meshify = {
    hostName = "meshify";
    ip = "192.168.0.126";
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJEMzg5GZ9mz1x8ujXPXgD03Y37eBT4I7HFE78HB418";
  };
  sylph = { 
    hostName = "sylph";
    ip = "192.168.0.148";
  };
  laptop-wsl = {
    hostName = "laptop-wsl";
    ip = "192.168.0.211";
    wsl = true;
  };
  terra = {
    hostName = "terra";
    ip = "192.168.0.147";
  };
  laptop = {
    hostName = "laptop";
    ip = "192.168.0.211";
  };
}