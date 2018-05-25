class KimaiCli < Formula
  include Language::Python::Virtualenv

  desc "CLI for Kimai time tracking software"
  homepage "https://github.com/wycomco/kimai-cli"
  url "https://github.com/wycomco/kimai-cli/releases/download/0.6.1/kimai-cli-0.6.1.tar.gz"
  sha256 "4840375a5b15f349f30d4bcbf94ae97c7cb82846f1f2e322ed6fb49437231b4a"

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
