locals {

  default_tags = {
    CreationDate = timestamp()
  }

  policy_tags = {
    creationdate = timestamp()
  }
}