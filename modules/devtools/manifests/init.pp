class devtools {
  package {
    "git":
      ensure => installed;
    "build-essential":
      ensure => installed;
    "openssl":
      ensure => instsalled;
    "libreadline6":
      ensure => installed;
    "libreadline6-dev":
      ensure => installed;
    "curl":
      ensure => installed;
    "firefox":
      ensure => installed;
    "openjdk-7-jdk":
      ensure => installed;
  }
}
