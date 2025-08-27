# typed: false

class Sup < Formula
  include Language::Python::Virtualenv

  desc "English-like programming language with interpreter and Python transpiler"
  homepage "https://github.com/Karthikprasadm/Sup"
  url "https://github.com/Karthikprasadm/Sup/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "6312af0efe6b378b094de7c36d719083547c6bd60fe1596b4f2270d654e5a814"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install_and_link buildpath/"sup-lang"
  end

  test do
    (testpath/"hello.sup").write <<~EOS
      sup
        print "Hello, SUP!"
      bye
    EOS
    system bin/"sup", "transpile", "--emit", "python", "--out", testpath/"hello.py", testpath/"hello.sup"
    assert_match "Hello, SUP!", shell_output("python3 #{testpath}/hello.py")
  end
end
