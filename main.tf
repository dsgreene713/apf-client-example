import {
  for_each = var.accounts_to_import

  to = aws_organizations_account.this[each.key]
  id = each.key
}

resource "aws_organizations_account" "this" {
  for_each = var.accounts_to_import

  name  = each.value.acct_name
  email = each.value.acct_email

  tags = {
    "imported-by" = "apf-workflow"
  }
}

data "aws_organizations_organization" "this" {
  # ensure we import any new accounts first
  depends_on = [aws_organizations_account.this]
}