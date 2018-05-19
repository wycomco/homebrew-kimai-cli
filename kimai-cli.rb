class KimaiCli < Formula
  include Language::Python::Virtualenv

  desc "CLI for Kimai time tracking software"
  homepage "https://github.com/ksassnowski/kimai-cli"
  url "https://github.com/ksassnowski/kimai-cli/releases/download/0.5.0/kimai-cli-0.5.0.tar.gz"
  sha256 "5590f7cc7533ca992c791a3db62be5334ab0fd783de2530c3f71e47902c21019"

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
