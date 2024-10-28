# Helper error function
fail()
{
    echo "$*" 1>&2
    exit 1
}

name="CarletonVPN_MFA"
gateway="cuvpn.carleton.ca"
group_name="mfa"
group_passwd=""
username="willchartrand"
local_user="willc"

nmcli connection add con-name "$name" type vpn vpn-type vpnc ||
    fail "Unable to create the connection"

nmcli connection modify "$name" \
    "autoconnect" "false" \
    "connection.permissions" "user:$local_user" \
    "vpn.data" "IKE DH Group=dh2,
                IPSec ID=$group_name,
                IPSec gateway=$gateway,
                IPSec secret-flags=0,
                Local Port=0,
                NAT Traversal Mode=natt,
                Perfect Forward Secrecy=server,
                Vendor=cisco,
                Xauth password-flags=2,
                Xauth username=$username,
                ipsec-secret-type=save,
                xauth-password-type=ask" \
     "vpn.secrets" "IPSec secret=$group_passwd" \
     "ipv6.ip6-privacy" "0" 
