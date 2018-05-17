class KimaiCli < Formula
  include Language::Python::Virtualenv

  desc "CLI for Kimai time tracking software"
  homepage "https://github.com/ksassnowski/kimai-cli"
  url "https://github.com/ksassnowski/kimai-cli/releases/download/0.3.1/kimai-cli-0.3.1.tar.gz"
  sha256 "42eef85daff6d1167c94dc3890cb1dfb37963baf42b6e0163ba30ab39a632c72"

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
