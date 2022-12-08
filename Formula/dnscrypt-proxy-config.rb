class DnscryptProxyConfig < Formula
  desc "Config for dnscrypt-proxy"
  version "1.1.0"
  homepage "https://dnscrypt.info"
  url "https://example.com"
  sha256 "ea8fac7c65fb589b0d53560f5251f74f9e9b243478dcb6b3ea79b5e36449c8d9"
  depends_on "dnscrypt-proxy"

  def install
    File.open("dnscrypt-proxy.toml", "w") { |file| file.write("""
##################################
#         Global settings        #
##################################

## List of servers to use
##
## Servers from the \"public-resolvers\" source (see down below) can
## be viewed here: https://dnscrypt.info/public-servers

# server_names = [
#   'cloudflare',
#   'cloudflare-ipv6',
#   'odoh-cloudflare',
#   'controld-uncensored',
#   'controld-unfiltered',
#   'quad101',
# ]


## Require servers to satisfy specific properties

# Use servers reachable over IPv4
ipv4_servers = true

# Use servers reachable over IPv6 -- Do not enable if you don't have IPv6 connectivity
ipv6_servers = false

# Use servers implementing the DNSCrypt protocol
dnscrypt_servers = true

# Use servers implementing the DNS-over-HTTPS protocol
doh_servers = true

# Use servers implementing the Oblivious DoH protocol
odoh_servers = true

# Server must support DNS security extensions (DNSSEC)
require_dnssec = true

# Server must not log user queries (declarative)
require_nolog = true

# Server must not enforce its own blocklist (for parental control, ads blocking...)
require_nofilter = true

# Server names to avoid even if they match all criteria
disabled_server_names = []


## List of local addresses and ports to listen to. Can be IPv4 and/or IPv6.
## Example with both IPv4 and IPv6:
## listen_addresses = ['127.0.0.1:53', '[::1]:53']

listen_addresses = ['127.0.0.1:53', '[::1]:53']


## Maximum number of simultaneous client connections to accept

max_clients = 128


## Switch to a different system user after listening sockets have been created.

user_name = 'nobody'


## Always use TCP to connect to upstream servers.
## This can be useful if you need to route everything through Tor.
## Otherwise, leave this to `false`, as it doesn't improve security
## (dnscrypt-proxy will always encrypt everything even using UDP), and can
## only increase latency.

force_tcp = false


## SOCKS proxy
## Uncomment the following line to route all TCP connections to a local Tor node
## Tor doesn't support UDP, so set `force_tcp` to `true` as well.

# proxy = 'socks5://127.0.0.1:9050'


## HTTP/HTTPS proxy
## Only for DoH servers

# http_proxy = 'http://127.0.0.1:8888'


## How long a DNS query will wait for a response, in milliseconds.
## If you have a network with *a lot* of latency, you may need to
## increase this. Startup may be slower if you do so.
## Don't increase it too much. 10000 is the highest reasonable value.

timeout = 2500


## Keepalive for HTTP (HTTPS, HTTP/2) queries, in seconds

keepalive = 5


## Response for blocked queries. Options are `refused`, `hinfo` (default) or
## an IP response. To give an IP response, use the format `a:<IPv4>,aaaa:<IPv6>`.
## Using the `hinfo` option means that some responses will be lies.
## Unfortunately, the `hinfo` option appears to be required for Android 8+

# blocked_query_response = 'refused'


## Load-balancing strategy: 'p2' (default), 'ph', 'p<n>', 'first' or 'random'
## Randomly choose 1 of the fastest 2, half, n, 1 or all live servers by latency.
## The response quality still depends on the server itself.

lb_strategy = 'p3'

## Set to `true` to constantly try to estimate the latency of all the resolvers
## and adjust the load-balancing parameters accordingly, or to `false` to disable.
## Default is `true` that makes 'p2' `lb_strategy` work well.

lb_estimator = true


## Log level (0-6, default: 2 - 0 is very verbose, 6 only contains fatal errors)

log_level = 6


## Delay, in minutes, after which certificates are reloaded

cert_refresh_delay = 240


## DNSCrypt: Create a new, unique key for every single DNS query
## This may improve privacy but can also have a significant impact on CPU usage
## Only enable if you don't have a lot of network load

# dnscrypt_ephemeral_keys = false


## DoH: Disable TLS session tickets - increases privacy but also latency

# tls_disable_session_tickets = false


## DoH: Use a specific cipher suite instead of the server preference
## 49199 = TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
## 49195 = TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
## 52392 = TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305
## 52393 = TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305
##  4865 = TLS_AES_128_GCM_SHA256
##  4867 = TLS_CHACHA20_POLY1305_SHA256
##
## On non-Intel CPUs such as MIPS routers and ARM systems (Android, Raspberry Pi...),
## the following suite improves performance.
## This may also help on Intel CPUs running 32-bit operating systems.
##
## Keep tls_cipher_suite empty if you have issues fetching sources or
## connecting to some DoH servers. Google and Cloudflare are fine with it.

# tls_cipher_suite = [52392, 49199]


## Bootstrap resolvers
##
## These are normal, non-encrypted DNS resolvers, that will be only used
## for one-shot queries when retrieving the initial resolvers list and if
## the system DNS configuration doesn't work.
##
## No user queries will ever be leaked through these resolvers, and they will
## not be used after IP addresses of DoH resolvers have been found (if you are
## using DoH).
##
## They will never be used if lists have already been cached, and if the stamps
## of the configured servers already include IP addresses (which is the case for
## most of DoH servers, and for all DNSCrypt servers and relays).
##
## They will not be used if the configured system DNS works, or after the
## proxy already has at least one usable secure resolver.
##
## Resolvers supporting DNSSEC are recommended, and, if you are using
## DoH, bootstrap resolvers should ideally be operated by a different entity
## than the DoH servers you will be using, especially if you have IPv6 enabled.
##
## People in China may want to use 114.114.114.114:53 here.
## Other popular options include 8.8.8.8, 9.9.9.9 and 1.1.1.1.
##
## If more than one resolver is specified, they will be tried in sequence.
##
## TL;DR: put valid standard resolver addresses here. Your actual queries will
## not be sent there. If you're using DNSCrypt or Anonymized DNS and your
## lists are up to date, these resolvers will not even be used.

bootstrap_resolvers = ['127.0.0.1:54', '[::1]:54']


## Always use the bootstrap resolver before the system DNS settings.

ignore_system_dns = true


## Maximum time (in seconds) to wait for network connectivity before
## initializing the proxy.
## Useful if the proxy is automatically started at boot, and network
## connectivity is not guaranteed to be immediately available.
## Use 0 to not test for connectivity at all (not recommended),
## and -1 to wait as much as possible.

netprobe_timeout = -1

## Address and port to try initializing a connection to, just to check
## if the network is up. It can be any address and any port, even if
## there is nothing answering these on the other side. Just don't use
## a local address, as the goal is to check for Internet connectivity.
## On Windows, a datagram with a single, nul byte will be sent, only
## when the system starts.
## On other operating systems, the connection will be initialized
## but nothing will be sent at all.

netprobe_address = '1.1.1.1:443'


## Offline mode - Do not use any remote encrypted servers.
## The proxy will remain fully functional to respond to queries that
## plugins can handle directly (forwarding, cloaking, ...)

offline_mode = false


#########################
#        Filters        #
#########################

## Immediately respond to IPv6-related queries with an empty response
## This makes things faster when there is no IPv6 connectivity, but can
## also cause reliability issues with some stub resolvers.

block_ipv6 = false


## Immediately respond to A and AAAA queries for host names without a domain name

block_unqualified = true


## Immediately respond to queries for local zones instead of leaking them to
## upstream resolvers (always causing errors or timeouts).

block_undelegated = true


## TTL for synthetic responses sent when a request has been blocked (due to
## IPv6 or blocklists).

reject_ttl = 5


###########################
#        DNS cache        #
###########################

## Enable a DNS cache to reduce latency and outgoing traffic

cache = true


## Cache size

cache_size = 65536


## Minimum TTL for cached entries

cache_min_ttl = 300


## Maximum TTL for cached entries

cache_max_ttl = 3600


## Minimum TTL for negatively cached entries

cache_neg_min_ttl = 5


## Maximum TTL for negatively cached entries

cache_neg_max_ttl = 60


#########################
#        Servers        #
#########################

## Remote lists of available servers
## Multiple sources can be used simultaneously, but every source
## requires a dedicated cache file.
##
## Refer to the documentation for URLs of public sources.
##
## A prefix can be prepended to server names in order to
## avoid collisions if different sources share the same for
## different servers. In that case, names listed in `server_names`
## must include the prefixes.
##
## If the `urls` property is missing, cache files and valid signatures
## must already be present. This doesn't prevent these cache files from
## expiring after `refresh_delay` hours.
## Cache freshness is checked every 24 hours, so values for 'refresh_delay'
## of less than 24 hours will have no effect.
## A maximum delay of 168 hours (1 week) is imposed to ensure cache freshness.

[sources]

  ## An example of a remote source from https://github.com/DNSCrypt/dnscrypt-resolvers

  [sources.'public-resolvers']
    urls = ['https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md', 'https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md', 'https://ipv6.download.dnscrypt.info/resolvers-list/v3/public-resolvers.md', 'https://download.dnscrypt.net/resolvers-list/v3/public-resolvers.md']
    cache_file = 'dnscrypt-proxy.sources.d/public-resolvers.md'
    minisign_key = 'RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3'
    refresh_delay = 72
    prefix = ''

  ## Anonymized DNS relays

  [sources.'relays']
    urls = ['https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/relays.md', 'https://download.dnscrypt.info/resolvers-list/v3/relays.md', 'https://ipv6.download.dnscrypt.info/resolvers-list/v3/relays.md', 'https://download.dnscrypt.net/resolvers-list/v3/relays.md']
    cache_file = 'dnscrypt-proxy.sources.d/relays.md'
    minisign_key = 'RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3'
    refresh_delay = 72
    prefix = ''

  ## ODoH (Oblivious DoH) servers and relays

  [sources.'odoh-servers']
    urls = ['https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/odoh-servers.md', 'https://download.dnscrypt.info/resolvers-list/v3/odoh-servers.md', 'https://ipv6.download.dnscrypt.info/resolvers-list/v3/odoh-servers.md', 'https://download.dnscrypt.net/resolvers-list/v3/odoh-servers.md']
    cache_file = 'dnscrypt-proxy.sources.d/odoh-servers.md'
    minisign_key = 'RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3'
    refresh_delay = 24
    prefix = ''
  [sources.'odoh-relays']
    urls = ['https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/odoh-relays.md', 'https://download.dnscrypt.info/resolvers-list/v3/odoh-relays.md', 'https://ipv6.download.dnscrypt.info/resolvers-list/v3/odoh-relays.md', 'https://download.dnscrypt.net/resolvers-list/v3/odoh-relays.md']
    cache_file = 'dnscrypt-proxy.sources.d/odoh-relays.md'
    minisign_key = 'RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3'
    refresh_delay = 24
    prefix = ''


#########################################
#        Servers with known bugs        #
#########################################

[broken_implementations]

# Cisco servers currently cannot handle queries larger than 1472 bytes, and don't
# truncate reponses larger than questions as expected by the DNSCrypt protocol.
# This prevents large responses from being received over UDP and over relays.
#
# Older versions of the `dnsdist` server software had a bug with queries larger
# than 1500 bytes. This is fixed since `dnsdist` version 1.5.0, but
# some server may still run an outdated version.
#
# The list below enables workarounds to make non-relayed usage more reliable
# until the servers are fixed.

fragments_blocked = [
  'cisco',
  'cisco-ipv6',
  'cisco-familyshield',
  'cisco-familyshield-ipv6',
  'cleanbrowsing-adult',
  'cleanbrowsing-adult-ipv6',
  'cleanbrowsing-family',
  'cleanbrowsing-family-ipv6',
  'cleanbrowsing-security',
  'cleanbrowsing-security-ipv6',
]


################################
#        Anonymized DNS        #
################################

[anonymized_dns]

# Skip resolvers incompatible with anonymization instead of using them directly

skip_incompatible = true
""".strip
    ) }
    prefix.install "dnscrypt-proxy.toml"
  end

  def caveats
    puts <<~EOS.strip
      Manually execute the following commands to apply the new configuration.

      cp "#{etc}/dnscrypt-proxy.toml" "#{etc}/dnscrypt-proxy.toml.orig" &&
      cp "#{prefix}/dnscrypt-proxy.toml" "#{etc}/dnscrypt-proxy.toml" &&
      mkdir -p "#{etc}/dnscrypt-proxy.sources.d" &&
      sudo chown nobody:nobody "#{etc}/dnscrypt-proxy.sources.d"
    EOS
  end
end
