(defvar hatena-post-username "*An username of your Hatena account." nil)

(defvar hatena-post-password "*A password of your Hatena account. Leave it blank is the
recommended way because writing a password in .emacs file is so
dangerous." nil)

;;; CA certificate
(defvar hatena-post-cert-file nil
  "The full-path of the file including the certificates authorizing
servers on SSL.")

(defconst hatena-post-ca-cert-body
"-----BEGIN CERTIFICATE-----
MIIDjzCCAvigAwIBAgIDAMdDMA0GCSqGSIb3DQEBBQUAMFoxCzAJBgNVBAYTAkpQ
MSMwIQYDVQQKExpDeWJlcnRydXN0IEphcGFuIENvLiwgTHRkLjEmMCQGA1UEAxMd
Q3liZXJ0cnVzdCBKYXBhbiBQdWJsaWMgQ0EgRzEwHhcNMTAxMjEzMDc0MDM4WhcN
MTIxMjEzMTQ1OTAwWjBnMQswCQYDVQQGEwJKUDEOMAwGA1UECBMFS3lvdG8xEjAQ
BgNVBAcTCUt5b3RvLXNoaTEZMBcGA1UEChMQSGF0ZW5hIENvLiwgTHRkLjEZMBcG
A1UEAxMQd3d3LmhhdGVuYS5uZS5qcDCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC
gYEA7FV3Qv2Tc4Hu/Kq1YqAzo69CBpo/+Fx8Yalm8GO4p1yUMo/LmnpUwqnXMPwY
7tpO7AHLPEpn+3mLPN8gMTEaOCskEMKMgik//kb7lRPIgd4EzdaZeBa9slLCXlKd
3TZNGHIKDYzge8XqjXlp55QPfziJcvdh9KdKiBSDfrjXgbUCAwEAAaOCAVQwggFQ
MAkGA1UdEwQCMAAwgb8GA1UdIASBtzCBtDCBsQYIKoMIjJsRAQEwgaQwVwYIKwYB
BQUHAgIwSxpJRm9yIG1vcmUgZGV0YWlscywgcGxlYXNlIHZpc2l0IG91ciB3ZWJz
aXRlIGh0dHBzOi8vd3d3LmN5YmVydHJ1c3QubmUuanAgLjBJBggrBgEFBQcCARY9
aHR0cHM6Ly93d3cuY3liZXJ0cnVzdC5uZS5qcC9TdXJlU2VydmVyL3JlcG9zaXRv
cnkvaW5kZXguaHRtbDALBgNVHQ8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEG
CCsGAQUFBwMCMFUGA1UdHwROMEwwSqBIoEaGRGh0dHA6Ly9zdXJlc2VyaWVzLWNy
bC5jeWJlcnRydXN0Lm5lLmpwL1N1cmVTZXJ2ZXIvY3RqcHViY2FnMS9jZHAuY3Js
MA0GCSqGSIb3DQEBBQUAA4GBAK4/4X2ZV8s4F5anNC12KLv0YaQ8tQnoG3KGnKrc
6mfeDcvWX9bBzNOMWLjWKgNEDgwiQjR7ugf89EWJN3Ia4n86bS+BErsTX+hNrfVt
BssA0u05c5nvXGAltD0O8u0wZLegb50th6sFoeD5ityoEnmVD7sZEcFOjYpjd0HF
bzw6
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDuTCCAyKgAwIBAgIEBydcJTANBgkqhkiG9w0BAQUFADB1MQswCQYDVQQGEwJV
UzEYMBYGA1UEChMPR1RFIENvcnBvcmF0aW9uMScwJQYDVQQLEx5HVEUgQ3liZXJU
cnVzdCBTb2x1dGlvbnMsIEluYy4xIzAhBgNVBAMTGkdURSBDeWJlclRydXN0IEds
b2JhbCBSb290MB4XDTEwMDIyNDIwMDUxMFoXDTE4MDgxMzIzNTkwMFowWjELMAkG
A1UEBhMCSlAxIzAhBgNVBAoTGkN5YmVydHJ1c3QgSmFwYW4gQ28uLCBMdGQuMSYw
JAYDVQQDEx1DeWJlcnRydXN0IEphcGFuIFB1YmxpYyBDQSBHMTCBnzANBgkqhkiG
9w0BAQEFAAOBjQAwgYkCgYEAvr+27eTxTAKYC1p8wWkYIEiSAwgS0lI5z/TMn2zq
Oqv/Rtv03eUx7QGJkKxEdaYxX6NBiTaXq/RDfUwYFV5zyqqvcv9KmMyVJFqNn2eY
xs6h5khR+Ys8tDKC7BWpezWmhz6ELiFLbdF67YzLqOGIDxx1d3lFK3vLb7sIlHX9
WskCAwEAAaOCAW8wggFrMBIGA1UdEwEB/wQIMAYBAf8CAQAwUwYDVR0gBEwwSjBI
BgkrBgEEAbE+AQAwOzA5BggrBgEFBQcCARYtaHR0cDovL2N5YmVydHJ1c3Qub21u
aXJvb3QuY29tL3JlcG9zaXRvcnkuY2ZtMA4GA1UdDwEB/wQEAwIBBjCBiQYDVR0j
BIGBMH+heaR3MHUxCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9HVEUgQ29ycG9yYXRp
b24xJzAlBgNVBAsTHkdURSBDeWJlclRydXN0IFNvbHV0aW9ucywgSW5jLjEjMCEG
A1UEAxMaR1RFIEN5YmVyVHJ1c3QgR2xvYmFsIFJvb3SCAgGlMEUGA1UdHwQ+MDww
OqA4oDaGNGh0dHA6Ly93d3cucHVibGljLXRydXN0LmNvbS9jZ2ktYmluL0NSTC8y
MDE4L2NkcC5jcmwwHQYDVR0OBBYEFFqES7uXWOJC4IyqnKm9Ygds5JarMA0GCSqG
SIb3DQEBBQUAA4GBADFT6HyLCfSYdwsHBeQAPvNKrzz+6uCZqk7yzsGUrz3AC2in
/W/oL3BtIlm1fvVixTav6QtMOY+ATqQ3SWl4NTLWtfn5SLyYFvz/Pvrf+Es+ZnJP
Ahz40hL0vUztVrCic8hPgs4NtMSvDkNwbgjU7LDBxH91GJl2fWjSE2w3UjRW
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIICWjCCAcMCAgGlMA0GCSqGSIb3DQEBBAUAMHUxCzAJBgNVBAYTAlVTMRgwFgYD
VQQKEw9HVEUgQ29ycG9yYXRpb24xJzAlBgNVBAsTHkdURSBDeWJlclRydXN0IFNv
bHV0aW9ucywgSW5jLjEjMCEGA1UEAxMaR1RFIEN5YmVyVHJ1c3QgR2xvYmFsIFJv
b3QwHhcNOTgwODEzMDAyOTAwWhcNMTgwODEzMjM1OTAwWjB1MQswCQYDVQQGEwJV
UzEYMBYGA1UEChMPR1RFIENvcnBvcmF0aW9uMScwJQYDVQQLEx5HVEUgQ3liZXJU
cnVzdCBTb2x1dGlvbnMsIEluYy4xIzAhBgNVBAMTGkdURSBDeWJlclRydXN0IEds
b2JhbCBSb290MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVD6C28FCc6HrH
iM3dFw4usJTQGz0O9pTAipTHBsiQl8i4ZBp6fmw8U+E3KHNgf7KXUwefU/ltWJTS
r41tiGeA5u2ylc9yMcqlHHK6XALnZELn+aks1joNrI1CqiQBOeacPwGFVw1Yh0X4
04Wqk2kmhXBIgD8SFcd5tB8FLztimQIDAQABMA0GCSqGSIb3DQEBBAUAA4GBAG3r
GwnpXtlR22ciYaQqPEh346B8pt5zohQDhT37qw4wxYMWM4ETCJ57NE7fQMh017l9
3PR2VX2bY1QY6fDq81yx2YtCHrnAlU66+tXifPVoYb+O7AWXX1uw16OFNMQkpw0P
lZPvy5TYnh+dXIVtx6quTx8itc2VrbqnzPmrC3p/
-----END CERTIFICATE-----")

(defun hatena-post-delete-ca-cert ()
  (when (and hatena-post-cert-file
	     (file-exists-p hatena-post-cert-file))
    (delete-file hatena-post-cert-file))
  (setq hatena-post-cert-file nil))

(defun hatena-post-ensure-ca-cert ()
  "Return a full-path of the file including CA certificates.

If it does not exist, create it. The directory includes root certificates
in \"hash format\". In detail, see verify(1SSL)."
  (unless hatena-post-cert-file
    (let ((coding-system-for-write 'iso-safe)
	  (file (make-temp-file "hatena-cacert")))
      (with-temp-file file
	(insert hatena-post-ca-cert-body))
      (setq hatena-post-cert-file file)
      (add-hook 'kill-emacs-hook 'hatena-post-delete-ca-cert)))
  hatena-post-cert-file)


