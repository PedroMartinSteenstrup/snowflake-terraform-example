resource "snowflake_network_policy" "policy" {
  provider = snowflake.admin_security
  name     = "IP_allowlisting"
  comment  = "A policy that allows every origin to connect to Snowflake"

  allowed_ip_list = ["0.0.0.0/0"] # matches all IPs
}

resource "snowflake_network_policy_attachment" "attach" {
  provider            = snowflake.admin_security
  network_policy_name = snowflake_network_policy.policy.name
  set_for_account     = true # applies to everyone
}