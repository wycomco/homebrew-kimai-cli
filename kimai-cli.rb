class KimaiCli < Formula
  include Language::Python::Virtualenv

  desc "CLI for Kimai time tracking software"
  homepage "https://github.com/ksassnowski/kimai-cli"
  url "https://github.com/ksassnowski/kimai-cli/releases/download/0.4.2/kimai-cli-0.4.2.tar.gz"
  sha256 "d386822fb070f284db8b6b5409447d3f62ab571351c90745f2347c6d5ae2b9a7"

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
