class KimaiCli < Formula
  include Language::Python::Virtualenv

  desc "CLI for Kimai time tracking software"
  homepage "https://github.com/ksassnowski/kimai-cli"
  url "https://github.com/ksassnowski/kimai-cli/releases/download/0.2.1/kimai-cli-0.2.1.tar.gz"
  sha256 "3a36824171fe93286ede0638b29d160efd598a0e2bd16527389f04586cba2c57"

  depends_on "python"

  def install
    venv = virtualenv_create(libexec, "python3")
    system libexec/"bin/pip", "install", "-v", "--no-binary", ":all:",
                              "--ignore-installed", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "kimai-cli"
    venv.pip_install_and_link buildpath

    rm Dir["#{bin}/{kimai-complete.sh}"]
    zsh_completion.install "bin/kimai-complete.sh"
    (zsh_completion/"_kimai").write <<~EOS
      _kimai () {
        local e
        e=$(dirname ${funcsourcetrace[1]%:*})/kimai-complete.sh
        if [[ -f $e ]]; then source $e; fi
      }
    EOS
  end

  test do
    system "true"
  end
end
