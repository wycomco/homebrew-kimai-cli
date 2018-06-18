class KimaiCli < Formula
  include Language::Python::Virtualenv

  desc "CLI for Kimai time tracking software"
  homepage "https://github.com/wycomco/kimai-cli"
  url "https://github.com/wycomco/kimai-cli/releases/download/0.6.2/kimai-cli-0.6.2.tar.gz"
  sha256 "ea5adb55b1ec726c14b4ae28bdb15a25d9b8d90803b8829192dca1c209919571"

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
