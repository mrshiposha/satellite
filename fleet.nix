# This file contains fleet state and shouldn't be edited by hand

{
  version = "0.1.0";
  gcRootPrefix = "fleet-gc-eT5oBjPe";
  hosts = {
    satellite.encryptionKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWAjQXamZbDHbf0qDtjrUEljUJLMWL1AZQxEUy9wUIp root@satellite";
    sentinel.encryptionKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAvG/Y3msJtoZiTZGNKZ+/hINXmO6saD606+DRpYGJK5 root@nixos";
  };
  hostSecrets.sentinel = {
    coturn = {
      createdAt = "2025-01-05T19:18:39.861289068Z";
      secret.raw = ''
        <ENCRYPTED><BASE64-ENCODED>
        YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGswbklHQSBIVk5F
        bENVaWIyanZZZzhHbWtQLzBzVnk1UGpMeDZZejBxT1RQY1hzT1VzClBKZ3FxN2hE
        b001dzBZdG1uZFVWajNYTmxTZWYwSE5NUHZzT0lkTDFjL00KLT4gV11JdTwtZ3Jl
        YXNlIHZGV3dlSEEKTy9EWFZWQTdCRW1ZRVpyZHA4S1lhUEpyL3ZPRzJsSE5GQWMK
        LS0tIHJuMFNjMVhzZHlpSXo4ckVCYk1tcmxUV2NsME1mWWlkb0lScFlDWVQyM2MK
        9p/i9W4YDBuCDa9zoD5g5t671vrFVZkcJyEfxnX8hCxeLEXtD+pt47XcISNPPF/k
        3Hwbb8RFk3HPNwRmvNRrwQ
      '';
    };
    netbird-client = {
      createdAt = "2025-01-06T02:58:37.479370880Z";
      secret.raw = ''
        <ENCRYPTED><BASE64-ENCODED>
        YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGswbklHQSAzVTBY
        ZVR0MktyTEQ2UGhVTC82M1hUZndPQi9BYXlhTjRkajZDU29ERGw0CmNUSVR2M1Na
        TEtJblp2ZlJHcUN1YWw5WGNYM0V3N3NEckpMSTVYMDk5NGMKLT4gOkkuJD0tZ3Jl
        YXNlIC1aYSBUZmg2LwplaVR2UWRURkJLMWhjSVJRdUFVRGhkcVhPb01BRFhpQlNL
        ejZrTzl1L1hLT3ZkRW80ZEh3cVlydmdBVmlKMXB6CkFPempyU1hCY3FYUFloTzhv
        bmZNM3BzRmlKbG0vbnNxeE9IZ3Z1SWVlUQotLS0gckM0WmxQdEthSnJkMXdlTEJx
        dFQralZtYVFyOFpRd1FSYXdpWHFjVTM4RQr0c8pLs5lNKkpPQ4nJxGj4yEka/f44
        Hqm9IFH6g0u0wf4OGYf8IJSwMBuepecxYlgSm/VMW4IBAu/+/Z+YXQbPTm/1r1cX
        mjTxEKNEuPt/KLggAii8vh4+22oKbpwI5gJG
      '';
    };
    netbird-key = {
      createdAt = "2025-01-05T23:45:07.852480138Z";
      secret.raw = ''
        <ENCRYPTED><BASE64-ENCODED>
        YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGswbklHQSBRVWdz
        SENIbkxKSVJpeDVTWExzaURzQk9lb3QrME1teDBVUlJTYlIwUkRNClhQQ2xBTE5W
        TFE5RkRMbjFVZnRNb1ZLNUpnYUsvQXJadDlwaHVhRURUTG8KLT4gcnZuLWdyZWFz
        ZSBCUCQoIDg+VFpVfiBPV3o2bD4gaVh3TGBTfApkYTY0bUdVWklYVGlGdlJsZ0d0
        bzlMYjZaWExRS1A5czZLQ0RzWkNnMWMwRTduQzc1Nm5LLzhjanRHQkhuTVBICnVX
        NlJrUVB2WU56QXEvTXc3MmtEd1lNVmE0ZURDWFpoZVZlRFRMdFk1R0ZML0NsV1l3
        VXdiRGFaCi0tLSBUYUJOa1MvTEQzOW80dFBybzVoRHpEODZDekFXS1dVRWpVclVW
        UzYvdGF3Cl2E7JTRa94M3kTFwDSWHz6UbwQXfwCYeF9+Q90u4KDClz0cwXic1H+g
        d26E3nOO9KICiUTVjT8gQIOLXQTDe6p/JJ2m6eLUW+nXqwqB
      '';
    };
    netbird-turn = {
      createdAt = "2025-01-05T21:33:59.474646406Z";
      secret.raw = ''
        <ENCRYPTED><BASE64-ENCODED>
        YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNzaC1lZDI1NTE5IGswbklHQSBta05x
        M2x0NWhyalJNVmdmK1duY0tQZkQ1cnBMdXBLVTllUEtnUk1OWDB3CnVWc2p0M1NM
        VWxqRWhlbHJwblVsa1BQTjF4WjZERGdRc1Q0UDdObURPZzAKLT4gXXsxcS1ncmVh
        c2UgciEpNzxvCi83eVMvZ0x6ZERmejZsUTR3VGpTSFZJMlFJMk5FckdRUGNDUjNC
        N1NZZGVCQmV2VGVldGxmK1VRcU5CdlZNYWgKYWVRNnFZd1c0K1BZLzA3aAotLS0g
        Zy96TU42U2pLOVMyeXVPZXdESFBDYkRFNjFjY1lZWENTRWxEdVJuQlFTWQqAeGoG
        m0ruTqbRJVbXd+yK2ze3JUyyxPm/vLfQS0+j5aCKaXhmuTp2hAcPRO+b15O9ZqRJ
        KsJOs++N2mmrZFh+gG0GTGmwYuiUvL1utN+8hbmEonznMRpHiPJYowrxigzp
      '';
    };
    zitadel = {
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
  };
}


# vim: ts=2 et nowrap
