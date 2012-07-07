class devtools {
  package {
    "git":
      ensure => installed;
    "build-essential":
      ensure => installed;
    "firefox":
      ensure => installed;
    "openjdk-7-jdk":
      ensure => installed;
  }
}
