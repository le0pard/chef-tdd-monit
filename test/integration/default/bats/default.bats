@test "monit is installed and in the path" {
  which monit
}

@test "monit configuration dir exists" {
  [ -d "/etc/monit" ]
}