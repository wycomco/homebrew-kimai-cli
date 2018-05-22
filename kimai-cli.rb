class KimaiCli < Formula
  include Language::Python::Virtualenv

  desc "CLI for Kimai time tracking software"
  homepage "https://github.com/wycomco/kimai-cli"
  url "https://github.com/wycomco/kimai-cli/releases/download/0.5.3/kimai-cli-0.5.3.tar.gz"
  sha256 "632c17d4e67f07e805f25de6f3b478c40e85e30e25a084d8c8d75f78a358df22"

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
