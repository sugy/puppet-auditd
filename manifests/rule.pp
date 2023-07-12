##  params:
##    content: Rule definition
##    order:   Relative order of this rule

define auditd::rule ($content='', Integer $order = 10) {
  if $content == '' {
    $body = $name
  } else {
    $body = $content
  }

  if (!$order.is_a(Integer)) {
    fail('$order must be an integer')
  }
  validate_legacy('String', 'validate_string', $body)

  concat::fragment { "auditd_fragment_${name}":
    target  => $auditd::rules_file,
    order   => $order,
    content => $body,
  }
}
