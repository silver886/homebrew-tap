class StubbyConfig < Formula
  desc "Config for stubby"
  version "1.1.1"
  homepage "https://dnsprivacy.org/wiki/display/DP/DNS+Privacy+Daemon+-+Stubby"
  url "https://example.com/index.html"
  sha256 "ea8fac7c65fb589b0d53560f5251f74f9e9b243478dcb6b3ea79b5e36449c8d9"
  depends_on "stubby"

  @@config_file_path = "stubby/stubby.yml"

  def install
    touch prefix/"brew-keep"

    time = Time.now.strftime("%Y-%m-%dT%H:%M:%S.%L%z")
    mv etc/@@config_file_path, etc/"#{@@config_file_path}.bak.#{time}", force: true
    File.open(etc/@@config_file_path, "w").write("""
########################## BASIC & PRIVACY SETTINGS ############################
resolution_type: GETDNS_RESOLUTION_STUB

dns_transport_list:
  - GETDNS_TRANSPORT_TLS

tls_authentication: GETDNS_AUTHENTICATION_REQUIRED

# EDNS0 option to pad the size of the DNS query to the given blocksize
# 128 is currently recommended by
# https://tools.ietf.org/html/draft-ietf-dprive-padding-policy-03
tls_query_padding_blocksize: 128

# EDNS0 option for ECS client privacy as described in Section 7.1.2 of
# https://tools.ietf.org/html/rfc7871
edns_client_subnet_private: 1

############################# CONNECTION SETTINGS ##############################
# Set to 1 to instruct stubby to distribute queries across all available name
# servers - this will use multiple simultaneous connections which can give
# better performance in most (but not all) cases.
# Set to 0 to treat the upstreams below as an ordered list and use a single
# upstream until it becomes unavailable, then use the next one.
round_robin_upstreams: 1

# EDNS0 option for keepalive idle timeout in milliseconds as specified in
# https://tools.ietf.org/html/rfc7828
# This keeps idle TLS connections open to avoid the overhead of opening a new
# connection for every query. Note that if a given server doesn't implement
# EDNS0 keepalive and uses an idle timeout shorter than this stubby will backoff
# from using that server because the server is always closing the connection.
# This can degrade performance for certain configurations so reducing the
# idle_timeout to below that of that lowest server value is recommended.
idle_timeout: 5000

# Control the maximum number of connection failures that will be permitted
# before Stubby backs-off from using an individual upstream (default 2)
tls_connection_retries: 2

# Control the maximum time in seconds Stubby will back-off from using an
# individual upstream after failures under normal circumstances (default 3600)
tls_backoff_time: 300

# Specify the location for CA certificates used for verification purposes are
# located - this overrides the OS specific default location.
# tls_ca_path: \"/etc/ssl/certs/\"

# Limit the total number of outstanding queries permitted
# limit_outstanding_queries: 100

# Specify the timeout in milliseconds on getting a response to an individual
# request (default 5000)
timeout: 2500

# Set the acceptable ciphers for DNS over TLS.  With OpenSSL 1.1.1 this list is
# for TLS1.2 and older only. Ciphers for TLS1.3 should be set with the
# tls_ciphersuites option. This option can also be given per upstream.
# tls_cipher_list: \"EECDH+AESGCM:EECDH+CHACHA20\"

# Set the acceptable cipher for DNS over TLS1.3. OpenSSL >= 1.1.1 is required
# for this option. This option can also be given per upstream.
# tls_ciphersuites: \"TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256\"

# Set the minimum acceptable TLS version. Works with OpenSSL >= 1.1.1 only.
# This option can also be given per upstream.
tls_min_version: GETDNS_TLS1_2

# Set the maximum acceptable TLS version. Works with OpenSSL >= 1.1.1 only.
# This option can also be given per upstream.
# tls_max_version: GETDNS_TLS1_3

################################ LISTEN ADDRESS ################################
# Set the listen addresses for the stubby DAEMON. This specifies localhost IPv4
# and IPv6. It will listen on port 53 by default. Use <IP_address>@<port> to
# specify a different port
listen_addresses:
  - 127.0.0.1@54
  - 0::1@54

############################### DNSSEC SETTINGS ################################
# Require DNSSEC validation. This will withhold answers with BOGUS DNSSEC
# status and answers that could not be validated (i.e. with DNSSEC status
# INDETERMINATE). Beware that if no DNSSEC trust-anchor is provided, or if
# stubby is not able to fetch and validate the DNSSEC trust-anchor itself,
# (using Zero configuration DNSSEC) stubby will not return answers at all.
# If DNSSEC validation is required, a trust-anchor is also required.
# dnssec: GETDNS_EXTENSION_TRUE

# Stubby tries to fetch and validate the DNSSEC root trust anchor on the fly
# when needed (Zero configuration DNSSEC), but only if it can store then
# somewhere.  The default location to store these files is the \".getdns\"
# subdirectory in the user's home directory on Unixes, and the %appdata%\getdns
# directory on Windows. If there is no home directory, or
# the required subdirectory could not be created (or is not present), Stubby
# will fall back to the current working directory to try to store the
# trust-anchor files.
#
# When stubby runs as a special system-level user without a home directory
# however (such as in setups using systemd), it is recommended that an explicit
# location for storing the trust-anchor files is provided that is writable (and
# readable) by that special system user.
# appdata_dir: \"/var/cache/stubby\"

# When Zero configuration DNSSEC failed, because of network unavailability or
# failure to write to the appdata directory, stubby will backoff trying to
# refetch the DNSSEC trust-anchor for a specified amount of time  expressed
# in milliseconds (which defaults to two and a half seconds).
# trust_anchors_backoff_time: 2500

# Specify the location of the installed trust anchor files to override the
# default location (see above)
# dnssec_trust_anchors:
#   - \"/etc/unbound/getdns-root.key\"

##################################  UPSTREAMS  ################################
# Specify the list of upstream recursive name servers to send queries to
# In Strict mode upstreams need either a tls_auth_name or a tls_pubkey_pinset
# so the upstream can be authenticated.
# The list below includes all the available test servers but only has the subset
# operated the stubby/getdns developers enabled. You can enable any of the
# others you want to use by uncommenting the relevant section. See:
# https://dnsprivacy.org/wiki/display/DP/DNS+Privacy+Test+Servers
# If you don't have IPv6 then comment then out those upstreams.
# In Opportunistic mode they only require an IP address in address_data.
# The information for an upstream can include the following:
# - address_data: IPv4 or IPv6 address of the upstream
#   port: Port for UDP/TCP (default is 53)
#   tls_auth_name: Authentication domain name checked against the server
#                  certificate
#   tls_pubkey_pinset: An SPKI pinset verified against the keys in the server
#                      certificate
#     - digest: Only \"sha256\" is currently supported
#       value: Base64 encoded value of the sha256 fingerprint of the public
#              key
#   tls_port: Port for TLS (default is 853)

upstream_recursive_servers:
####### IPv4 addresses ######
### Anycast services ###
## Cloudflare
  - address_data: 1.1.1.1
    tls_auth_name: cloudflare-dns.com
  - address_data: 1.0.0.1
    tls_auth_name: cloudflare-dns.com

####### IPv6 addresses #######
### Anycast services ###
## Cloudflare
  - address_data: 2606:4700:4700::1111
    tls_auth_name: cloudflare-dns.com
  - address_data: 2606:4700:4700::1001
    tls_auth_name: cloudflare-dns.com
""".strip)
  end
end
