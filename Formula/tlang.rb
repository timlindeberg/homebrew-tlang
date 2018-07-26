class Tlang < Formula
  desc "Installs the compiler and accompanying REPL for tlang"
  homepage "https://www.tlang.io"
  url "https://github.com/timlindeberg/T-Compiler/releases/download/v0.1/tlang-0.1.tar.gz"
  sha256 "35f1a0cbdf512d9de915e2155ea068bea172bedf284e6195b417484715aa8fa7"

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    libexec.install "bin"
    libexec.install "lib"
    libexec.install "stdlib"

    ["tcompile", "trepl", "t"].each do |binary|
      (bin/binary).write <<~EOS
        #!/bin/sh
        exec "#{libexec}/bin/#{binary}" "$@"
      EOS
    end
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/tcompile --version")
  end
end
