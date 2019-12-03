provider "google" {
  region =  "${var.region}"
  # credentials = "${file("~/.creds/gitlab_testing/gitlab-testing-google.json")}"
  project     = "${var.project}"
}
