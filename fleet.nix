# This file contains fleet state and shouldn't be edited by hand

{
  version = "0.1.0";
  gcRootPrefix = "fleet-gc-eT5oBjPe";
  hosts = {
    satellite.encryptionKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWAjQXamZbDHbf0qDtjrUEljUJLMWL1AZQxEUy9wUIp root@satellite";
    sentinel.encryptionKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAvG/Y3msJtoZiTZGNKZ+/hINXmO6saD606+DRpYGJK5 root@nixos";
  };
  hostSecrets.sentinel.zitadel = {
    createdAt = "2025-01-04T17:09:30.956697722Z";
    secret.raw = ''
      <ENCRYPTED><BASE64-ENCODED>
      YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGswbklHQSBNVXg4
      Q0xtZ1FGVDRkdG5YRXlCYjRNQTZCdHo1bE1mT0lNOGViOHNnN2k4Ckd6ZzlXZlkx
      SVVsVmwyb3ZTbXU4dDBJWUNPd3IycmJHTHFwaGRQVlNnclUKLT4gdi1ncmVhc2Ug
      diRhc2QgJDIiWFVmJQpORXJJYkVvNTE1akVYakVTNjRZQk9FNmJ2ZVhtUGxMTAot
      LS0gQmpFMmpmekxzZjVKOG5zbHFyVjhvUjhoQ0UxTFFma1oxWDU0Qm9nbk5pUQoT
      GqcJcjumCDzlh2QTuGuS97SXHRVdSE3XxnR3sDcj2O0EWw6odXSag2v+Bid4rIl7
      4q2tluJWZz4YPjleXrXm
    '';
  };
}


# vim: ts=2 et nowrap
