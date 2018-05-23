class KimaiCli < Formula
  include Language::Python::Virtualenv

  desc "CLI for Kimai time tracking software"
  homepage "https://github.com/wycomco/kimai-cli"
  url "https://github.com/wycomco/kimai-cli/releases/download/0.6.0/kimai-cli-0.6.0.tar.gz"
  sha256 "61c1509611eaf7f4a6bb0b1cfca8fbcbcd351131be40a15a6fe5626db14e9678"

  depends_on "python"

  def install
    venv = virtualenv_create(libexec, "python3")
    system libexec/"bin/pip", "install", "-v", "--no-binary", ":all:",
                              "--ignore-installed", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "kimai-cli"
    venv.pip_install_and_link buildpath

    rm Dir["#{bin}/{kimai-complete.sh}"]
    zsh_completion.install "bin/kimai-complete.sh" => "_kimai"
  end

  test do
    system "true"
  end
end
