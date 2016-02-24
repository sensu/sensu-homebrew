class Sensu < Formula
  desc "A monitoring framework that aims to be simple, malleable, and scalable."
  homepage "https://sensuapp.org"
  url "https://github.com/sensu/sensu-homebrew/archive/0.0.1.tar.gz"
  version "0.0.1"
  sha256 "663d73b0f8711cc257b49f94f2916326f8e128d745dde39dc9645d77ea34bada"

  depends_on "ruby"

  def install
    system "gem", "install", "sensu"
  end
end
