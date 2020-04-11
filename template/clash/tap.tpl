experimental:
  interface-name: WLAN
{% if request.clash.dns == "fake" %}
dns:
  enable: true
  ipv6: false
  listen: 0.0.0.0:53
  enhanced-mode: fake-ip
  nameserver:
    - 119.29.29.29
    - 114.114.114.114
    - 223.5.5.5
{% endif %}
{% if request.clash.dns == "redir" %}
dns:
  enable: true
  ipv6: false
  listen: 0.0.0.0:53
  enhanced-mode: redir-host
  nameserver:
    - 119.29.29.29
    - 114.114.114.114
    - 223.5.5.5
{% endif %}